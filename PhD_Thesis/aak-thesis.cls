\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{aak-thesis}[2018/12/05 v1.0 Thesis Class]

%===============================================================
% Packages
%===============================================================

\LoadClass[12pt, twosides, a4paper]{book}
\RequirePackage[utf8]{inputenc}
\RequirePackage{fontspec}
\RequirePackage[left=3cm,right=2cm,top=2cm,bottom=2cm,includefoot,includehead,headheight=14pt,asymmetric]{geometry}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{amssymb}
\RequirePackage[centertags]{amsmath}
\RequirePackage[many]{tcolorbox}
\RequirePackage{multirow}
\RequirePackage{tablefootnote}
\RequirePackage[ruled]{algorithm2e}
\RequirePackage{hyperref}
\RequirePackage{natbib}
\RequirePackage{verbatim}
\RequirePackage{lettrine}
\RequirePackage{longtable}
%\RequirePackage{titlesec}%sections vertical spacing
\RequirePackage{setspace}
\RequirePackage{lscape} %landscape page
\RequirePackage{afterpage}% used with landscape to prevent white pages
\RequirePackage{tocvsec2} %to set the TOC level
%\RequirePackage{tocloft} % toc, lof, lot
\RequirePackage{mdframed}

\usepackage[font=footnotesize,skip=2pt,tableposition=top]{caption}

\RequirePackage{graphbox} 

\usepackage{indentfirst}

\RequirePackage{xeCJK}

\RequirePackage{acro}

\RequirePackage{listings}

\RequirePackage{arabxetex}


%===============================================================
% Fonts
%===============================================================

\defaultfontfeatures{Mapping=tex-text}

\setmainfont
[Path = fonts/CrimsonText/,
Extension = .ttf,
Ligatures=TeX, 
UprightFont=*-Regular,
BoldFont=*-Bold,
ItalicFont=*-Italic,
BoldItalicFont=*-BoldItalic
]{CrimsonText} %

%===============================================================
% General Layout
%===============================================================

% Default page style
\pagestyle{plain}

\renewcommand{\baselinestretch}{1.5} 
%\setlength{\bibsep}{0.0pt}
% \titlespacing*{<command>}{<left>}{<before-sep>}{<after-sep>}

%\titlespacing*{\paragraph}{0pt}{12pt}{12pt}
%\titlespacing*{\section}{0pt}{8pt}{16pt}
%\titlespacing*{\subsection}{0pt}{8pt}{12pt}

% Front Matter
% -------------

\fancypagestyle{fancymain}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{.4pt}
	\fancyfoot[C]{%
		\rule{0.33\textwidth}{.4pt}\\[.2cm]
		Page \thepage\ of \pageref{LastMainPage}
	}
	\fancyhead[RE]{\bfseries\nouppercase{\leftmark}}      % Chapter in the right on even pages
	\fancyhead[LO]{\bfseries\nouppercase{\rightmark}}     % Section in the left on odd pages
	\fancyhead[LE,RO]{}
}

\fancypagestyle{fancychap}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{%
		\rule{0.33\textwidth}{.4pt}\\[.2cm]
		Page \thepage\ of \pageref{LastMainPage}
	}
%	\fancyhead{}
}

\fancypagestyle{fancyfront}{
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[C]{%
		\rule{0.33\textwidth}{.4pt}\\[.2cm]
		\thepage
	}
	%	\fancyhead{}
}


\renewcommand{\frontmatter}{%
	\newpage
	\pagestyle{fancyfront}
	\pagenumbering{roman}
}

\renewcommand{\mainmatter}{%
	\newpage
	\pagenumbering{arabic}
	\pagestyle{fancymain}
}

%===============================================================
% Chapter Layout
%===============================================================

\newtcolorbox{quotebox}{
	enhanced jigsaw,
	oversize,
	rightrule=0pt,
	toprule=0pt,
	bottomrule=0pt,
	leftrule=5pt,
	colback=white!90!black,
	colframe=black,
	arc=0pt,
	outer arc=0pt,
	%	title={Remarque :},
	%	title style={white},
	%	fonttitle=\color{black}\bfseries,
	titlerule=0pt,
	bottomtitle=0pt,
	top=0pt,
	bottom=0pt,
	left=0pt,
	enlarge left by=.5\textwidth,
	width=0.5\textwidth,
	fontupper=\itshape
}

\renewcommand{\thechapter}{\Roman{chapter}}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}

%\renewcommand\chapter{%
%	\if@openright\cleardoublepage\else\clearpage\fi
%	\thispagestyle{plain}%
%	\global\@topnum\z@
%	\@afterindentfalse
%	\secdef\@chapter\@schapter}

\newif\if@numbredchap\@numbredchaptrue

\def\@current@quote{}

\renewcommand{\@makechapterhead}[1]{%
	\if@openright\cleardoublepage\else\clearpage\fi
	\vspace*{-\headheight}%
	\thispagestyle{fancyfront}
	\if@numbredchap%
	\if@mainmatter%
	\thispagestyle{fancychap}
	{\fontsize{50}{4}\bfseries\selectfont\raggedright\thechapter\par%
	     \rule{0.25\textwidth}{2pt}\par}%
	\fi\fi%
	{\fontsize{30}{30}\bfseries\selectfont\raggedleft#1\par}%
	\vspace*{1cm}%
	\@current@quote{}
	\@numbredchaptrue%
	\def\@current@quote{}%
}

\renewcommand{\@makeschapterhead}[1]{\@numbredchapfalse\@makechapterhead{#1}}

\RequirePackage{environ}

\def\define@quote#1{\gdef\@current@quote{%
		\begin{quotebox}%
			#1%
		\end{quotebox}%
	    \vspace*{1cm}%
}}

% compatibility with package "quotchap"
\AtBeginDocument {
	\makeatletter
	\@ifundefined{savequote}{%
		\newenvironment{savequote}[1][10cm]{\collect@body\define@quote}{}
	}{}

	\@ifundefined{qauthor}{%
		\newcommand{\qauthor}[1]{%
			\begin{flushright}%
				#1%
			\end{flushright}%
		}%
	}{}

	\makeatother
}

\def\listabbreviations{%
	
	\chapter*{List of abbreviations}
	\addcontentsline{toc}{chapter}{List of abbreviations}
	
	\printacronyms[include-classes=abbrev,name=]
	%	\printglossaries
	%	\printglossary[type=\acronymtype]
	%	\printglossary
	
}

\let\old@listoffigures\listoffigures
\def\listoffigures{%
	\old@listoffigures
	\addcontentsline{toc}{chapter}{List of figures}
}

\let\old@listoftables\listoftables
\def\listoftables{%
	\old@listoftables
	\addcontentsline{toc}{chapter}{List of tables}
}

%\def\appendix{
%	\setcounter{chapter}{0}%
%	\setcounter{section}{0}%
%	\gdef\@chapapp{Appendix}%
%	\gdef\thechapter{\@Alph\c@chapter}
%	\setcounter{tocdepth}{1}
%}
%\setcounter{tocdepth}{0}


%===============================================================
% Tables
%===============================================================

\newcommand{\readtable}[1]{ %
	\input{tables/#1}
}


%===============================================================
% Equations and  Algorithms
%===============================================================

\newcommand{\readalgo}[1]{ %
	\input{algorithms/#1}
}


\let\cleardoublepage\clearpage

\renewcommand{\@listI}{%
	\leftmargin=25pt
	\rightmargin=0pt
	\labelsep=5pt
	\labelwidth=20pt
	\itemindent=0pt
	\listparindent=0pt
	\topsep=0pt plus 2pt minus 4pt
	\partopsep=0pt plus 1pt minus 1pt
	\parsep=0pt plus 1pt
	\itemsep=\parsep}


\lstdefinestyle{codeStyle}{
	belowcaptionskip=1\baselineskip,
	breaklines=true,
	frame=L,
	xleftmargin=1.5cm,%\parindent,
	showstringspaces=false,
	basicstyle=\scriptsize\ttfamily\bfseries, %\codefont,
	keywordstyle=\bfseries\color{blue!70!black}, %green!40!black
	keywordstyle = [2]{\bfseries\color{orange!70!black}},
	keywordstyle = [3]{\bfseries\color{red!70!black}},
	commentstyle=\itshape\color{black!70!white}, %purple!40!black
	identifierstyle=\color{black},%blue
	stringstyle=\color{green!50!black},
	backgroundcolor=\color{white} ,
	lineskip=.2em,
	numbers=left
	%  frameround=tttt
}


%\usepackage{etoolbox}
%\makeatletter
%\pretocmd{\chapter}{\addtocontents{toc}{\protect\addvspace{15\p@}}}{}{}
%\pretocmd{\section}{\addtocontents{toc}{\protect\addvspace{10\p@}}}{}{}
%\makeatother


%\setlength{\cftbeforechapskip}{-5pt}
%\setlength{\cftbeforesecskip}{-5pt}
%\setlength{\cftbeforesubsecskip}{-5pt}

\usepackage{etoolbox}

\preto{\appendix}{%
	\label{LastMainPage}%
	\ifbool{@openright}{%
		\cleardoublepage
	}{%
		\clearpage
	}%
	\fancypagestyle{fancymain}{
		\fancyhf{}
		\renewcommand{\headrulewidth}{.4pt}
		\fancyfoot[C]{%
			\rule{0.33\textwidth}{.4pt}\\[.2cm]
			Page \thepage
		}
		\fancyhead[RE]{\bfseries\nouppercase{\leftmark}}      % Chapter in the right on even pages
		\fancyhead[LO]{\bfseries\nouppercase{\rightmark}}     % Section in the left on odd pages
		\fancyhead[LE,RO]{}
	}
	
	\fancypagestyle{fancychap}{
		\fancyhf{}
		\renewcommand{\headrulewidth}{0pt}
		\fancyfoot[C]{%
			\rule{0.33\textwidth}{.4pt}\\[.2cm]
			Page \thepage
		}
		%	\fancyhead{}
	}
\pagestyle{fancymain}

%	\pagenumbering{arabic}%
%	\fancyfoot[C]{Page~\thepage\ of~\pageref{LastPage}}%
%	\fancypagestyle{plain}{%
%		\fancyhf{}%
%		\renewcommand{\headrulewidth}{0pt}%
%		\fancyfoot[C]{Page~\thepage\ of~\pageref{LastPage}}%
%	}%
}

\def\@subtitle{}
\def\subtitle#1{\def\@subtitle{#1}}