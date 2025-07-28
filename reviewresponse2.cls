\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reviewresponse}[2025/06/12 v2.1 class for writing rebuttal letters for reviews of submitted papers]

\RequirePackage{kvoptions}

\PassOptionsToClass{parskip=half-}{scrartcl}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass{scrartcl}
\setkomafont{disposition}{\normalfont}
\setkomafont{section}{\normalfont\bfseries\Large}

\RequirePackage[onehalfspacing]{setspaceenhanced}

\RequirePackage[breakable,skins]{tcolorbox}
\RequirePackage{xcolor}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true,linkcolor=black}


\newcommand*{\journal}[1]{\renewcommand*{\@journal}{#1}}
\newcommand*{\@journal}{}
\newcommand*{\editorname}[1]{\renewcommand*{\@editorname}{#1}}
\newcommand*{\@editorname}{}
\newcommand*{\manuscript}[1]{\renewcommand*{\@manuscript}{#1}}
\newcommand*{\@manuscript}{}
\newcommand*{\affiliation}[1]{\renewcommand*{\@affiliation}{#1}}
\newcommand*{\@affiliation}{}
\newcommand*{\affil}[1]{$^{#1}$}

\newcommand*{\printtitle}{\@title}
\newcommand*{\printdate}{\@date}
\newcommand*{\printeditor}{\@editorname}
\newcommand*{\printmanuscript}{\@manuscript}
\newcommand*{\printauthor}{\begingroup\renewcommand*{\affil}[1]{\@bsphack\@esphack}\@author\endgroup}

%%% Colors
\definecolor{colorcommentfg}{RGB}{0,103,66}
\definecolor{colorcommentbg}{RGB}{241,252,246}
\definecolor{colorcommentframe}{RGB}{0,162,114}

\colorlet{colorchangebg}{black!2}
\colorlet{colorchangeframe}{black!20}

\colorlet{colorconcludingresponsefg}{black!80}
\colorlet{colorconcludingresponsebg}{black!2}
\colorlet{colorconcludingresponseframe}{black!20}
%%%

%%% General Settings
%\setlength{\parindent}{0pt}
%\setlength{\parskip}{.3em plus .2em minus .3em}
%\renewcommand{\baselinestretch}{1.5}

\widowpenalty10000
\clubpenalty10000
%%%

%%% Counters
\newcounter{reviewer}
\setcounter{reviewer}{0}
\newcounter{revcomment}[reviewer]
\setcounter{revcomment}{0}
%%%

%%% Contents
\newcommand{\dottedtocline}[3]{%
	\noindent % left-aligned
	#1 % title
	\xleaders\hbox{\scriptsize.\hspace{0.5em}}\hfill % dotted line
	#2 % page
	\par % newline
	\vspace{0.5ex} % spacing between items
}

\renewcommand*\l@section[2]{%
	\vspace{4.8ex} % line spacing
	\dottedtocline{#1}{#2}{1}
}

\renewcommand*\l@subsection[2]{%
	\hspace{1.5em} % indentation
	\vspace{1.3ex} % line spacing (narrower than \section)
	\dottedtocline{#1}{#2}{2}
}
%%%

%%% Commands
\renewcommand*{\maketitle}{%
	\begin{titlepage}
		\begin{center}
			\singlespacing
			\large
			\vspace*{1cm}
			{Responses to Reviewers' Comments for Manuscript \@manuscript}

			\vspace{5ex}

			{\LARGE\textbf{\@title}}

			\vspace{5ex}

			{Addressed Comments for Publication to}\\[2ex]
			{\Large\@journal}\\[2ex]
			{by}\\[1.5ex]
			{\@author}

			\vspace{1.25ex}

			{\small%
			\begin{tabular}{@{}l@{}}
				\@affiliation
			\end{tabular}}
		\end{center}
	\end{titlepage}
}

\newcommand*{\editor}{
	\clearpage
	\phantomsection
	\section*{Response to Associate Editor}
	\addcontentsline{toc}{section}{Response to Associate Editor} % add to contents
}

\newcommand*{\reviewer}{
	\clearpage
	\refstepcounter{reviewer}%
	\section*{Response to Reviewer~\arabic{reviewer}}
    \addcontentsline{toc}{section}{Response to Reviewer~\arabic{reviewer}} % add to contents
}

\newcommand*{\printpartbibliography}[1]{
	\begin{refsegment}\nocite{#1}
		\phantomsection
		\printbibliography[heading=none,segment=\therefsegment]
	\end{refsegment}}
%%%

%%% Blocks %%%
\newenvironment{generalcomment}{%
	% \addcontentsline{toc}{subsection}{General Comments} % add to contents
	\begin{tcolorbox}[attach title to upper, title={General Comments}, after title={.\enskip}, fonttitle={\bfseries}, coltitle={colorcommentfg}, colback={colorcommentbg}, colframe={colorcommentframe}, bookmark={General Comments}]
	}{\end{tcolorbox}}

\newenvironment{revcomment}[1][]{\refstepcounter{revcomment}
    % \addcontentsline{toc}{subsection}{Comment \arabic{revcomment}} % add to contents
	\begin{tcolorbox}[adjusted title={Comment \arabic{revcomment}}, fonttitle={\bfseries}, coltitle={colorcommentbg}, colback={colorcommentbg}, colframe={colorcommentframe}, bookmark={Comment \arabic{revcomment}},#1]
	}{\end{tcolorbox}}

\newenvironment{revresponse}[1][{Thank you for the comment.}]{%
	\textbf{Response:} #1\par
}{\vspace{4em plus 0.2em minus 1.5em}}

\newenvironment{concludingresponse}[1][]{%
	\begin{tcolorbox}[attach title to upper, breakable, title={Concluding Response #1}, after title={.\enskip}, fonttitle={\bfseries}, coltitle={colorconcludingresponsefg}, colback={colorconcludingresponsebg}, colframe={colorconcludingresponseframe},]
	}{\end{tcolorbox}}

\newenvironment{changes}{
	\begin{tcolorbox}[breakable, colback={colorchangebg}, colframe={colorchangeframe}, enhanced jigsaw,]
	}{\end{tcolorbox}}

\providecommand*{\revcommentautorefname}{Comment}

%%% Hyperref Settings
\AddToHook{package/hyperref/after}{
	\hypersetup{
		bookmarksopen,
		pdfcreator={LaTeX with the reviewresponse package},
	}
}
\AddToHook{begindocument/before}{
	\IfPackageLoadedTF{hyperref}{
		\begingroup
		\renewcommand*{\affil}[1]{\@bsphack\@esphack}
		\hypersetup{
			pdfauthor={\@author},
			pdftitle={Review Response -- \@title{}},
			pdfkeywords={\@journal{}, \@manuscript{}, review response}
		}
		\endgroup
	}{}
}
\AddToHook{begindocument/end}{\def\sectionautorefname{Reviewer}}
