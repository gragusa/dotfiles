%% --------------------------------------------------------------
%% grlatex.cls - Giuseppe Ragusa's LaTeX Class
%% --------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{grlatex}[2025/03/14 Giuseppe Ragusa's LaTeX class]
\def\gr@true{true}

\RequirePackage{kvoptions}
\RequirePackage{xstring}

\DeclareStringOption[black]{colorheadings}
\DeclareStringOption[biblatex]{bibengine}
\ProcessKeyvalOptions*

\IfStrEq{\grlatex@bibengine}{biblatex}{%
	% If bibengine=biblatex (default), load biblatex with these options
	\RequirePackage[style=authoryear,
		backend=biber,
		giveninits=true,
		natbib=true,
		date=year,
		uniquelist=false,
		uniquename=init,
		isbn=false,
		maxcitenames=3,
		dashed=false,
		maxbibnames=999,
		doi=true,
		backref=true]{biblatex}
	\input{bibliographystyle}
}{%
	% If bibengine=bibtex or any other value, load natbib
	\RequirePackage[authoryear,round]{natbib}
	\AtBeginDocument{\bibliographystyle{plainnat}}
}



% Default class options
\newcommand*\myfontsize{12pt}
\newcommand*\mypagesize{a4paper}



\DeclareOption{letter}{%
	\renewcommand*\mypagesize{letter}
}

\DeclareOption{12pt}{%
	\renewcommand*\myfontsize{12pt}%
}

\DeclareOption{11pt}{%
	\renewcommand*\myfontsize{11pt}%
}

\DeclareOption{10pt}{%
	\renewcommand*\myfontsize{10pt}%
}
\ProcessOptions
\LoadClass[\myfontsize, \mypagesize]{article}


\RequirePackage[dvipsnames]{xcolor}
%% --------------------------------------------------------------
%% Color
%% --------------------------------------------------------------
\definecolor{teal}{HTML}{355764}
\definecolor{teallight}{HTML}{5A8F7B}
\definecolor{mypink3}{cmyk}{0, 0.7808, 0.4429, 0.1412}
\definecolor{mygray}{gray}{0.6}
\definecolor{egyptianblue}{HTML}{1434A4}
\definecolor{glaucose}{HTML}{6082B6}
\definecolor{steelblue}{HTML}{4682B4}

\definecolor{twilightsky0}{HTML}{0D1B2a}
\definecolor{twilightsky1}{HTML}{1B263B}
\definecolor{twilightsky2}{HTML}{415A77}
\definecolor{twilightsky3}{HTML}{778DA9}
\definecolor{twilightsky4}{HTML}{E0E1DD}
%% -------------------
%% titlesec
%% -------------------
\RequirePackage{titlesec}
\IfStrEq{\grlatex@colorheadings}{black}{%
	% Default case - black headings, no special formatting needed
}{%
	\IfStrEq{\grlatex@colorheadings}{true}{%
		% Use egyptianblue when colorheadings=true
		\colorlet{headingcolor}{twilightsky2}
	}{%
		% Otherwise, use the color specified in colorheadings
		\colorlet{headingcolor}{\grlatex@colorheadings}
	}%

	% Apply the color formatting using headingcolor
	\titleformat{\section}
	{\normalfont\Large\bfseries\color{headingcolor}}
	{\thesection}{1em}{}

	\titleformat{\subsection}
	{\normalfont\large\bfseries\color{headingcolor}}
	{\thesubsection}{1em}{}

	\titleformat{\subsubsection}
	{\normalfont\normalsize\bfseries\color{headingcolor}}
	{\thesubsubsection}{1em}{}

	\titleformat*{\paragraph}{\scshape\mdseries\color{headingcolor}}
}%

%% --------------------------------------------------------------
%% Packages
%% --------------------------------------------------------------
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage[title]{appendix}
\RequirePackage{bm}
\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}
\usepackage{caption}
\captionsetup[figure]{position=bottom}
\captionsetup[figure]{labelfont=sc}
\captionsetup[table]{position=bottom}
\captionsetup[table]{labelfont=sc}


\newcommand{\setbiblatex}{
	\RequirePackage[style=authoryear,
		backend=biber,
		giveninits=true,
		natbib=true,
		date=year,
		uniquelist=false,
		uniquename=init,
		isbn=false,
		maxcitenames=3,
		dashed=false,
		maxbibnames=999,
		doi=true,
		backref=true]{biblatex}
	\AtBeginDocument{\input{bibliographystyle}}
}

\newcommand{\setbibtex}{
	\RequirePackage[authoryear,round]{natbib}
}



\RequirePackage{centernot}
\RequirePackage{comment}
\RequirePackage{datetime}
\RequirePackage{enumerate}
\RequirePackage[capposition=bottom]{floatrow}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage[unicode=true,
bookmarks=true,
bookmarksnumbered=false,
bookmarksopen=false,
breaklinks=false,
pdfborder={0 0 0},
pdfborderstyle={},
backref=false,
colorlinks=true]{hyperref}
\RequirePackage{cleveref}
\RequirePackage{mathrsfs}
\RequirePackage{mathtools}
\RequirePackage{microtype}
\RequirePackage{setspace}
\onehalfspacing
\RequirePackage{threeparttable}
\RequirePackage{threeparttablex}
\RequirePackage{units}

%% --------------------------------------------------------------
%% Geometry & Spacing
%% --------------------------------------------------------------
\geometry{left=2.62cm,right=2.62cm,top=2.2cm,bottom=2.3cm}
%\spacing{1.4}
\pagestyle{empty}

%% --------------------------------------------------------------
%% Abstract
%% --------------------------------------------------------------
\renewenvironment{abstract}
{\small
	\begin{center}
		\bfseries \abstractname\vspace{-.5em}\vspace{0pt}
	\end{center}
	\list{}{%
		\setlength{\leftmargin}{5mm}%
		\setlength{\rightmargin}{\leftmargin}%
	}%
	\item\relax}
{\endlist}

%% --------------------------------------------------------------
%% Hyperref
%% --------------------------------------------------------------
\hypersetup{pdftitle={ },
	pdfauthor={Giuseppe Ragusa},
	colorlinks,
	breaklinks,
	linkcolor=twilightsky2,
	citecolor=twilightsky2,
	filecolor=egyptianblue,
	urlcolor=egyptianblue}


%% --------------------------------------------------------------
%% Fonts
%% --------------------------------------------------------------
% \DeclareFontFamily{OT1}{pzc}{}
% \DeclareFontShape{OT1}{pzc}{m}{it}{<-> s * [1.20] pzcmi7t}{}
% \DeclareMathAlphabet{\mathpzc}{OT1}{pzc}{m}{it}

%% --------------------------------------------------------------
%% Theorems
%% --------------------------------------------------------------
\theoremstyle{plain}
\newtheorem{thm}{\protect\theoremname}
\providecommand{\theoremname}{Theorem}
\newcommand{\thmautorefname}{Theorem}

\newtheoremstyle{customremark}
{3pt}   % Space above
{3pt}   % Space below
{}       % Body font (empty = upright)
{}       % Indent amount
{\bfseries} % Theorem head font
{.}       % Punctuation after theorem head
{ }       % Space after theorem head
{}        % Theorem head spec

\theoremstyle{customremark}
\newtheorem{remark}{\protect\remarkname}
\providecommand{\remarkname}{Remark}

\theoremstyle{plain}
\newtheorem{prop}{\protect\propname}
\providecommand{\propname}{Proposition}
\newcommand{\propautorefname}{Proposition}

\newtheorem{lemma}{\protect\lemmaname}
\providecommand{\lemmaname}{Lemma}
\newcommand{\lemmaautorefname}{Lemma}

\newtheorem{corollary}{\protect\corollaryname}
\providecommand{\corollaryname}{Corollary}
\newcommand{\corollaryautorefname}{Corollary}

\newtheorem{ass}{\protect\assname}
\providecommand{\assname}{Assumption}
\newcounter{subassumption}[ass]
\renewcommand{\thesubassumption}{(\textit{\alph{subassumption}})}

% Alternative Assumption!
\newtheorem{assalt}{Assumption}[ass]
\newcommand{\assaltautorefname}{Assumption}
% New environment
\newenvironment{assumptionp}[1]{
	\renewcommand\theassalt{#1}
	\assalt
}{\endassalt}

\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newcommand{\definitionautorefname}{Definition}

\makeatletter
\renewcommand{\p@subassumption}{\theass}% Counter prefix.
\makeatother
\newcommand{\subasu}{% Just like \item in a list but for an asu
	\refstepcounter{subassumption}%
	\thesubassumption~\ignorespaces}

\def\subassumptionautorefname{Assumption}

\makeatletter
\newcommand{\leqnomode}{\tagsleft@true\let\veqno\@@leqno}
\newcommand{\reqnomode}{\tagsleft@false\let\veqno\@@eqno}
\makeatother

%% --------------------------------------------------------------
%% Appendix
%% --------------------------------------------------------------
\newcommand*{\Appendixautorefname}{Appendix}

%% --------------------------------------------------------------
%% Mathtools
%% --------------------------------------------------------------
\mathtoolsset{centercolon}
\mathtoolsset{showmanualtags}
\setlength{\parindent}{1em}





%% Item symbols
\AtBeginDocument{
	\def\labelitemi{\(\vartriangleright\)}
	\def\labelitemii{\(\circ\)}
}


%% mathtools
\DeclarePairedDelimiter{\paren}{\lparen}{\rparen}
\DeclarePairedDelimiter{\brock}{\lbrack}{\rbrack}
\DeclarePairedDelimiter{\curly}{\{}{\}}
\DeclarePairedDelimiter{\norm}{\lVert}{\rVert}
\DeclarePairedDelimiter{\abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\anglebrackets}{\langle}{\rangle}
\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}
\DeclarePairedDelimiter{\floor}{\lfloor}{\rfloor}
\DeclarePairedDelimiter{\card}{|}{|}

% use \Set*{x\inX \given \frac{\sqrt{x}}{x^2+1} > 1 }
\providecommand\given{}
\DeclarePairedDelimiterX\Set[1]\{\}{\renewcommand\given{\SetSymbol[\delimsize]}#1}
% \P{A} = P(A) - \P{A \given B}
\let\P\relax
\DeclarePairedDelimiterXPP\P[1]{\mathbb{P}}(){}{
	\renewcommand\given{\nonscript\:\delimsize\vert\nonscript\:\mathopen{}}#1}
\DeclarePairedDelimiterXPP\E[1]{\mathbb{E}}(){}{\renewcommand\given{\nonscript\:\delimsize\vert\nonscript\:\mathopen{}}#1}
\DeclarePairedDelimiterXPP\proj[1]{\mathrm{proj}}(){}{#1}
\DeclarePairedDelimiterXPP\projn[1]{\mathrm{proj}_{n}}(){}{#1}

% variance
\DeclarePairedDelimiterXPP{\var}[1]{\mathbb{V}\mathrm{ar}}(){}{#1}
\DeclarePairedDelimiterXPP{\avar}[1]{\mathrm{a}\mathbb{V}\mathrm{ar}}(){}{#1}
\DeclarePairedDelimiterXPP{\SD}[1]{\mathbb{S}\mathrm{D}}(){}{#1}
% covariance
\DeclarePairedDelimiterXPP{\cov}[1]{\mathbb{C}\mathrm{ov}}[]{}{#1}
\DeclarePairedDelimiterXPP{\cor}[1]{\mathbb{C}\mathrm{o}}[]{}{#1}

%% argmax
\newcommand{\argmin}{\operatornamewithlimits{arg\,min}}
\newcommand{\argmax}{\operatornamewithlimits{arg\,max}}
%% Indicator function
% \usepackage{unicode-math}

% \DeclareMathAlphabet{\mathbbb{U}{bbold}{m}{n}}
% \newcommand*{\1}{\mathbb{1}}
\DeclareMathAlphabet{\mathbbold}{U}{bbold}{m}{n}
\newcommand*{\1}{\mathbbold{1}}
%% Mathop
\DeclareMathOperator{\sign}{sign}
\DeclareMathOperator{\Real}{\text{Re}}
\DeclareMathOperator{\Imag}{\text{Im}}
\DeclareMathOperator{\nil}{\textsc{nil}}
\DeclareMathOperator{\Normal}{\mathcal{N}}
\DeclareMathOperator{\Uniform}{\mathcal{U}}
\DeclareMathOperator{\Dirichlet}{Dir}
\DeclareMathOperator{\atantwo}{atan2}
\DeclareMathOperator{\trace}{Tr}
\DeclareMathOperator{\determinant}{det}


\newcommand{\simiid}{\overset{\text{iid}}{\sim}}
\newcommand{\simnid}{\overset{\text{nid}}{\sim}}
\newcommand{\sima}{\overset{\text{a}}{\sim}}

\newcommand{\indep}{\perp \!\!\! \perp}
\newcommand{\nindep}{\centernot{\indep}}

\newcommand{\sumg}{\sum_{g=1}^{G}}
\newcommand{\sumin}{\sum_{i=1}^{n}}

\renewcommand{\vec}{\mathrm{vec}}

\newcommand{\R}{\mathbb{R}}
\newcommand{\N}{\mathbb{N}}

% calligraphic capital letters
\newcommand{\calA}{\mathcal{A}}
\newcommand{\calB}{\mathcal{B}}
\newcommand{\calC}{\mathcal{C}}
\newcommand{\calD}{\mathcal{D}}
\newcommand{\calE}{\mathcal{E}}
\newcommand{\calF}{\mathcal{F}}
\newcommand{\calG}{\mathcal{G}}
\newcommand{\calH}{\mathcal{H}}
\newcommand{\calI}{\mathcal{I}}
\newcommand{\calJ}{\mathcal{J}}
\newcommand{\calK}{\mathcal{K}}
\newcommand{\calL}{\mathcal{L}}
\newcommand{\calM}{\mathcal{M}}
\newcommand{\calN}{\mathcal{N}}

\newcommand{\calO}{\mathcal{O}}
\newcommand{\calP}{\mathcal{P}}
\newcommand{\calQ}{\mathcal{Q}}
\newcommand{\calR}{\mathcal{R}}
\newcommand{\calS}{\mathcal{S}}
\newcommand{\calT}{\mathcal{T}}
\newcommand{\calU}{\mathcal{U}}
\newcommand{\calV}{\mathcal{V}}
\newcommand{\calW}{\mathcal{W}}
\newcommand{\calX}{\mathcal{X}}
\newcommand{\calY}{\mathcal{Y}}
\newcommand{\calZ}{\mathcal{Z}}

\newcommand{\mA}{\bm A}
\newcommand{\va}{\bm a}
\newcommand{\mB}{\bm B}
\newcommand{\vb}{\bm b}
\newcommand{\mC}{\bm C}
\newcommand{\vc}{\bm c}
\newcommand{\mD}{\bm D}
\newcommand{\vd}{\bm d}
\newcommand{\mE}{\bm E}
\newcommand{\ve}{\bm e}
\newcommand{\mF}{\bm F}
\newcommand{\vf}{\bm f}
\newcommand{\mG}{\bm G}
\newcommand{\vg}{\bm g}
\newcommand{\mH}{\bm H}
\newcommand{\vh}{\bm h}
\newcommand{\mI}{\bm I}
\newcommand{\vi}{\bm i}
\newcommand{\mJ}{\bm J}
\newcommand{\vj}{\bm j}
\newcommand{\mK}{\bm K}
\newcommand{\vk}{\bm k}
\newcommand{\mL}{\bm L}
\newcommand{\vl}{\bm l}
\newcommand{\mM}{\bm M}
\newcommand{\vm}{\bm m}
\newcommand{\mN}{\bm N}
\newcommand{\vn}{\bm n}
\newcommand{\mO}{\bm O}
\newcommand{\vo}{\bm o}
\newcommand{\mP}{\bm P}
\newcommand{\vp}{\bm p}
\newcommand{\mQ}{\bm Q}
\newcommand{\vq}{\bm q}
\newcommand{\mR}{\bm R}
\newcommand{\vr}{\bm r}
\newcommand{\mS}{\bm S}
\newcommand{\vs}{\bm s}
\newcommand{\mT}{\bm T}
\newcommand{\vt}{\bm t}
\newcommand{\mU}{\bm U}
\newcommand{\vu}{\bm u}
\newcommand{\mV}{\bm V}
\newcommand{\vv}{\bm v}
\newcommand{\mW}{\bm W}
\newcommand{\vw}{\bm w}
\newcommand{\mX}{\bm X}
\newcommand{\vx}{\bm x}
\newcommand{\mY}{\bm Y}
\newcommand{\vy}{\bm y}
\newcommand{\mZ}{\bm Z}
\newcommand{\vz}{\bm z}

\newcommand{\valpha}{\bm \alpha}
\newcommand{\vbeta}{\bm \beta}
\newcommand{\vgamma}{\bm \gamma}
\newcommand{\vdelta}{\bm \delta}
\newcommand{\vepsi}{\bm \epsi}
\newcommand{\vvarepsilon}{\bm \varepsilon}
\newcommand{\vzeta}{\bm \zeta}
\newcommand{\veta}{\bm \eta}
\newcommand{\vtheta}{\bm \theta}
\newcommand{\viota}{\bm \iota}
\newcommand{\vkappa}{\bm \kappa}
\newcommand{\vlambda}{\bm \lambda}
\newcommand{\vmu}{\bm \mu}
\newcommand{\vnu}{\bm \nu}
\newcommand{\vxi}{\bm \xi}
\newcommand{\vpi}{\bm \pi}
\newcommand{\vrho}{\bm \rho}
\newcommand{\vsigma}{\bm \sigma}
\newcommand{\vtau}{\bm \tau}
\newcommand{\vupsilon}{\bm \upsilon}
\newcommand{\vphi}{\bm \phi}
\newcommand{\vchi}{\bm \chi}
\newcommand{\vpsi}{\bm \psi}
\newcommand{\vomega}{\bm \omega}

\newcommand{\pto}{\stackrel{p}{\longrightarrow}}
\newcommand{\dto}{\stackrel{d}{\longrightarrow}}

\newcommand{\ped}[1]{\ensuremath{_\mathrm{#1}}} %pedex
\newcommand{\ap}[1]{\ensuremath{^\mathrm{#1}}} %apex

%% --------------------------------------------------------------
%% Headings Style
%% --------------------------------------------------------------
% Apply colored headings based on option




\endinput







