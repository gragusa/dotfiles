# Prefer the dedicated environment, but avoid the legacy SymbolServer stack
# on Julia 1.13+. An installed VS Code Julia extension bundles the newer server.
using Pkg, TOML

function language_server_version(project_file)
    directory = dirname(project_file)
    for name in ("Manifest-v$(VERSION.major).$(VERSION.minor).toml", "Manifest.toml")
        manifest_file = joinpath(directory, name)
        isfile(manifest_file) || continue
        manifest = TOML.parsefile(manifest_file)
        entries = get(get(manifest, "deps", Dict()), "LanguageServer", [])
        isempty(entries) && return nothing
        return VersionNumber(only(entries)["version"])
    end
    return nothing
end

function vscode_server_project()
    candidates = Tuple{VersionNumber,String}[]
    for editor in (".vscode", ".vscode-insiders")
        extensions = joinpath(homedir(), editor, "extensions")
        isdir(extensions) || continue
        for name in readdir(extensions)
            matched = match(r"^julialang\.language-julia-(\d+\.\d+\.\d+)", name)
            matched === nothing && continue
            base = joinpath(extensions, name, "scripts", "environments", "languageserver")
            for environment in ("v$(VERSION.major).$(VERSION.minor)", "fallback")
                project = joinpath(base, environment, "Project.toml")
                isfile(project) || continue
                version = language_server_version(project)
                if version !== nothing && version.major >= 6
                    push!(candidates, (VersionNumber(matched[1]), project))
                    break
                end
            end
        end
    end
    isempty(candidates) && return nothing
    sort!(candidates; by=first, rev=true)
    return first(candidates)[2]
end

project = Base.active_project()
override = get(ENV, "NVIM_JULIA_LSP_PROJECT", "")
if !isempty(override)
    project = Base.load_path_expand(expanduser(override))
    project !== nothing && isfile(project) || error("No Julia LSP project at $override")
end

version = project === nothing ? nothing : language_server_version(project)
if isempty(override) && (version === nothing || (VERSION >= v"1.13" && version.major < 6))
    project = vscode_server_project()
    project === nothing && error(
        "No compatible Julia language server found. Install LanguageServer 6 or newer " *
        "in @nvim-lsp, or install the VS Code Julia extension. " *
        "NVIM_JULIA_LSP_PROJECT can select another server environment."
    )
    version = language_server_version(project)
end

version !== nothing || error("LanguageServer is missing from the selected environment")
VERSION >= v"1.13" && version.major < 6 && error(
    "LanguageServer $version uses the legacy SymbolServer stack and cannot run on " *
    "Julia $VERSION. Install LanguageServer 6 or newer in the selected environment."
)

Pkg.activate(dirname(project); io=stderr)
@info "Starting Neovim Julia language server" julia=VERSION server=version project
using LanguageServer
LanguageServer.runserver()
