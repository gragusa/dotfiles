#!/usr/bin/env python3
"""
Python conversion of the LyX bind file parser script.
Original created by Christian Ridderström, 2002
Converted to Python in 2025
"""

import os
import sys
import re
import tempfile
import subprocess
import argparse


def main():
    # Parse command line arguments
    parser = argparse.ArgumentParser(
        description="Parse a .bind-file and output a list of bindings."
    )
    parser.add_argument("bind_files", nargs="*", help="Bind files to process")
    parser.add_argument(
        "-o", "--outdir", default=".", help='Output directory (default is ".")'
    )
    parser.add_argument("-d", "--debug", action="store_true", help="Debug this script")
    parser.add_argument(
        "-v", "--verbose", action="count", default=0, help="Verbose mode"
    )
    parser.add_argument(
        "-e", "--export", metavar="EXT", help="Use LyX to export to format EXT"
    )
    parser.add_argument("-L", "--lyx-template", help="LyX template to use")
    args = parser.parse_args()

    if not args.bind_files:
        parser.print_help()
        sys.exit(0)

    # Get LYXDIR environment variable or use default
    bind_dir = os.environ.get("LYXDIR", "/usr/local/share/lyx") + "/bind"

    # Create temporary files for processing
    with tempfile.NamedTemporaryFile(mode="w", delete=False) as tmp_file:
        tmp_filename = tmp_file.name

    with tempfile.NamedTemporaryFile(mode="w", delete=False) as tmp_sed:
        tmp_sed_filename = tmp_sed.name
        # Write sed script
        tmp_sed.write("""
# Replace whitespaces with single space, and remove last whitespace
s/[ \t]\+/ /g
s/[ ]\+$//
# Handle key bindings
/\\bind /   { 
    s/\\bind "\([^"]\+\)" \(".\+$\)/\\item[\1]    \\verb\2/
}
#
/\\bind_file \+/   {                    
    s/\\bind_file \+\(.\+\)/\\item[Include file]    \\verb"\1"/
}
# Remove multiple " inside \\verb
s/\(    \\verb"[^"]\+\)"\(.*$\)/\1\2"/g
# Escape ~ within the argument to \\item
s/^\([^~]\+\)~\(.\+\\verb\)/\1\\~{}\2/
s/^\([^_]\+\)_\(.\+\\verb\)/\1\\_\2/
# Print resulting item-lines
/^\\item/    p
# and ignore the rest
d
""")

    if args.verbose > 1:
        with open(tmp_sed_filename, "r") as f:
            print(f.read())

    for bind_file in args.bind_files:
        out_file = os.path.join(
            args.outdir, os.path.splitext(os.path.basename(bind_file))[0] + ".tex"
        )
        print(f"Parsing: {bind_file:<25} -> {out_file}")

        with open(out_file, "w") as out:
            # Write header
            escaped_filename = bind_file.replace("_", r"\_")
            out.write(f"\\chead{{Bind file: {escaped_filename}}}\n")
            out.write("\\begin{list}{}{\n")
            out.write("    \\setlength{\\baselineskip}{0cm}\n")
            out.write("    \\setlength{\\itemsep}{0cm}\n")
            out.write("    \\settowidth{\\labelwidth}{0000.00000.0000}\n")
            out.write("    \\setlength{\\leftmargin}{\\labelwidth}\n")
            out.write("    \\addtolength{\\leftmargin}{\\labelsep}\n")
            out.write("    \\renewcommand{\\makelabel}[1]{#1\\hfil}}\n")
            out.write("\\item[Key] Description\n")

            # Process bind file
            with open(bind_file, "r") as bind:
                for line in bind:
                    if re.search(r"^\s*\\bind", line) and "self-insert" not in line:
                        # Apply sed transformations manually
                        # Replace whitespaces with single space
                        line = re.sub(r"[ \t]+", " ", line)
                        # Remove trailing whitespace
                        line = re.sub(r"[ ]+$", "", line)

                        # Handle key bindings
                        if "\\bind " in line:
                            line = re.sub(
                                r'\\bind "([^"]+)" (".*$)',
                                r"\\item[\1]    \\verb\2",
                                line,
                            )

                        # Handle bind_file
                        if "\\bind_file " in line:
                            line = re.sub(
                                r"\\bind_file +(.+)",
                                r'\\item[Include file]    \\verb"\1"',
                                line,
                            )

                        # Remove multiple " inside \verb
                        line = re.sub(r'(    \\verb"[^"]+)"(.*$)', r'\1\2"', line)

                        # Escape ~ within the argument to \item
                        line = re.sub(r"^([^~]+)~(.+\\verb)", r"\1\\~{}\2", line)
                        line = re.sub(r"^([^_]+)_(.+\\verb)", r"\1\\_\2", line)

                        # Only write \item lines
                        if line.startswith("\\item"):
                            out.write(line + "\n")

            # Write footer
            out.write("\\end{list}\n")

        # Handle export if requested
        if args.export:
            os.rename(out_file, "bindings.inc")
            subprocess.run(["lyx", "-e", args.export, "bindings.lyx"])
            exported_file = os.path.splitext(out_file)[0] + "." + args.export
            print(f"Renaming bindings.lyx to {exported_file}")
            os.rename(f"bindings.{args.export}", exported_file)

    # Clean up temporary files
    os.unlink(tmp_filename)
    os.unlink(tmp_sed_filename)


if __name__ == "__main__":
    main()
