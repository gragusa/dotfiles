%% --------------------------------------------------------------
%% grlatex.cls - Giuseppe Ragusa's LaTeX Class
%% --------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{grlatex}[2025/03/14 Giuseppe Ragusa's LaTeX class]

\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}
\DeclareOption{a4paper}{\PassOptionsToClass{a4paper}{article}}
\DeclareOption{a5paper}{\PassOptionsToClass{a5paper}{article}}
\DeclareOption{b5paper}{\PassOptionsToClass{b5paper}{article}}
\DeclareOption{letterpaper}{\PassOptionsToClass{letterpaper}{article}}
\DeclareOption{legalpaper}{\PassOptionsToClass{legalpaper}{article}}
\DeclareOption{executivepaper}{\PassOptionsToClass{executivepaper}{article}}
\DeclareOption{landscape}{\PassOptionsToClass{landscape}{article}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{article}}
\DeclareOption{draft}{\PassOptionsToClass{draft}{article}}
\DeclareOption{final}{\PassOptionsToClass{final}{article}}
\DeclareOption{titlepage}{\PassOptionsToClass{titlepage}{article}}
\DeclareOption{notitlepage}{\PassOptionsToClass{notitlepage}{article}}
\DeclareOption{onecolumn}{\PassOptionsToClass{onecolumn}{article}}
\DeclareOption{twocolumn}{\PassOptionsToClass{twocolumn}{article}}
\DeclareOption{leqno}{\PassOptionsToClass{leqno}{article}}
\DeclareOption{fleqn}{\PassOptionsToClass{fleqn}{article}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{article}}

%% Pass all other options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%% Pass all unknown options to article class
\ProcessOptions\relax

%% Load base class
\LoadClass{article}

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
\RequirePackage{booktabs}

\RequirePackage[style=authoryear, 
            backend=biber, 
            giveninits=true,
            natbib=true,
            date=year,
            uniquelist = false, 
            uniquename=init,
            isbn=false, 
            maxcitenames=3,
            dashed=false, 
            maxbibnames=999,
            doi=true,
            backref=true,
            url=false]{biblatex}

\AtBeginDocument{\input{bibliographystyle}}

\RequirePackage[bf,nooneline,labelsep=period,footnotesize]{caption}
\RequirePackage{centernot}
\RequirePackage{comment}
\RequirePackage{datetime}
\RequirePackage{enumerate}
\RequirePackage[capposition=top]{floatrow}
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
 \RequirePackage{titlesec}
\RequirePackage{units}
\RequirePackage[dvipsnames]{xcolor}
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
            linkcolor=egyptianblue,
            citecolor=egyptianblue,
            filecolor=egyptianblue,
            urlcolor=egyptianblue}

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




\titleformat*{\paragraph}{\scshape\mdseries}




\endinput
