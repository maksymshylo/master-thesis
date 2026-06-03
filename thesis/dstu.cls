\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dstu}

% Base class: extended report with 14pt font on A4 paper
\LoadClass[14pt,a4paper]{extreport}

% Counters
\RequirePackage[figure]{totalcount}

% =====================
% FONTS & LANGUAGE
% =====================

\RequirePackage{fontspec} % Allows using system fonts (XeLaTeX/LuaLaTeX)
\setmainfont{XITS}[Ligatures=TeX] % Main document font

\RequirePackage[english,ukrainian]{babel} % Multilingual support
\RequirePackage{csquotes} % Context-aware quotation marks

% =====================
% GEOMETRY
% =====================

\RequirePackage{geometry} % Page layout configuration
\geometry{
    left=2.0cm,
    right=1.0cm,
    top=2.0cm,
    bottom=2.0cm
}

% =====================
% SPACING
% =====================

\frenchspacing % Uniform spacing after punctuation
\linespread{1.5} % Line spacing (1.5x)
\setlength\parindent{2.5em} % Paragraph indentation
\renewcommand{\arraystretch}{1.3} % Table row spacing

% =====================
% HEADERS / FOOTERS
% =====================

\RequirePackage{fancyhdr} % Custom headers and footers

\fancyhf{} % Clear all header/footer fields
\fancyhead[R]{\thepage} % Page number on the right header
\fancyheadoffset{0mm}
\fancyfootoffset{0mm}
\setlength{\headheight}{17pt} % Prevent header warning
\renewcommand{\headrulewidth}{0pt} % Remove header line
\renewcommand{\footrulewidth}{0pt} % Remove footer line

% Style for plain pages (e.g., chapter start)
\fancypagestyle{plain}{
    \fancyhf{}
    \rhead{\thepage}
}

% =====================
% CAPTIONS
% =====================

\RequirePackage[tableposition=top]{caption} % Caption customization
\RequirePackage{subcaption} % Subfigures support

% Custom caption labels (Ukrainian ДСТУ-style)
\DeclareCaptionLabelFormat{gostfigure}{Рисунок #2}
\DeclareCaptionLabelFormat{gosttable}{Таблиця #2}
\DeclareCaptionLabelSeparator{gost}{~---~}

% Apply caption settings
\captionsetup{labelsep=gost}
\captionsetup[figure]{labelformat=gostfigure, justification=centering}
\captionsetup[table]{labelformat=gosttable, labelsep=gost}

% Subfigure numbering using Ukrainian alphabet
\renewcommand{\thesubfigure}{\asbuk{subfigure}}

% =====================
% SECTIONING & LISTS
% =====================

\RequirePackage{titlesec} % Section title formatting
\RequirePackage{enumitem} % List customization

\setcounter{secnumdepth}{5} % Numbering depth
\setcounter{tocdepth}{2} % TOC depth

% ======================================
% TABLE OF CONTENTS
% ======================================

\RequirePackage[titles]{tocloft} % TOC customization

% TOC title (uppercase)
\renewcommand{\contentsname}{ЗМІСТ}

% Chapter entries formatting (non-bold with dotted leaders)
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}

% Force centering of TOC title if needed
\newcommand{\forcecentercontents}{
  \patchcmd{\tableofcontents}{\contentsname}{\filcenter\contentsname}{}{}
}

% Chapter entries (level 1)
\setlength{\cftchapindent}{0pt}
\setlength{\cftchapnumwidth}{1.0em}

% Section entries (level 2)
\setlength{\cftsecindent}{2.5em}
\setlength{\cftsecnumwidth}{2.0em}

% Subsection entries (level 3)
\setlength{\cftsubsecindent}{3.8em}
\setlength{\cftsubsecnumwidth}{3.2em}

% ======================================
% COMPACT TOC SPACING
% ======================================

% Remove vertical spacing between TOC entries
\setlength{\cftbeforechapskip}{0pt}
\setlength{\cftbeforesecskip}{0pt}
\setlength{\cftbeforesubsecskip}{0pt}

% ======================================
% SECTION TITLES FORMATTING (TITLESEC)
% ======================================

% Numbered chapters (bold, centered, uppercase)
\titleformat{\chapter}[block]
    {\filcenter\bfseries}
    {\thechapter}
    {1em}
    {\MakeUppercase}

% Unnumbered chapters (e.g., Introduction)
\titleformat{name=\chapter,numberless}[block]
    {\filcenter\bfseries}
    {}
    {0pt}
    {\MakeUppercase}

% Sections
\titleformat{\section}[block]
    {\hspace{\parindent}\bfseries}
    {\thesection}
    {1em}{}

% Subsections
\titleformat{\subsection}[block]
    {\hspace{\parindent}\bfseries}
    {\thesubsection}
    {1em}{}

% Subsubsections
\titleformat{\subsubsection}[block]
    {\hspace{\parindent}\bfseries}
    {\thesubsubsection}
    {1em}{}

% Spacing around titles
\titlespacing*{\chapter}{0pt}{-30pt}{2em}
\titlespacing*{\section}{0pt}{2em}{2em}
\titlespacing*{\subsection}{0pt}{2em}{2em}
\titlespacing*{\subsubsection}{0pt}{2em}{2em}

% =====================
% LIST CUSTOMIZATION
% =====================

\makeatletter
    % Ukrainian alphabet enumeration (а), б), ...)
    \AddEnumerateCounter{\asbuk}{\@asbuk}{ю)}
\makeatother

\setlist{nolistsep} % Remove extra spacing in lists
\renewcommand{\labelitemi}{-} % Bullet style
\renewcommand{\labelenumi}{\arabic{enumi})} % 1)
\renewcommand{\labelenumii}{\asbuk{enumii})} % а)

\setenumerate{leftmargin=\parindent} % Align lists with paragraph indent

% =====================
% CUSTOM COMMANDS
% =====================

% Appendix command (custom formatted)
\newcommand{\append}[1]{%
    \clearpage
    \phantomsection
    \stepcounter{chapter}
    \begin{center}
      \textbf{\MakeUppercase{\chaptertitlename~\Asbuk{chapter} #1}}
    \end{center}
    \addcontentsline{toc}{chapter}{\Asbuk{chapter} #1}%
}

% Unnumbered chapter with TOC entry
\newcommand\chap[1]{
  \chapter*{#1}
  \addcontentsline{toc}{chapter}{#1}
}

% Footnote format: 1)
\renewcommand*{\thefootnote}{\arabic{footnote})}

% Adjust spacing around displayed equations
\AtBeginDocument{
  \setlength\abovedisplayskip{2em}
  \setlength\belowdisplayskip{2em}
}
