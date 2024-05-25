\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{my_GZUexrept}[2023/11/01 v1.0]


%% Class Options
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{graphicx}}
\DeclareOption*{
  \typeout{Option \CurrentOption\ has been passed to class ctexart.}
  \PassOptionsToClass{\CurrentOption}{ctexart}
  }
\ProcessOptions\relax


%% Loading Class
% 面向中文排版的ctexart文档类
\LoadClass[a4paper,oneside,zihao=-4,scheme=chinese,]{ctexart}[2022/07/14 v2.5.10]
  \ctexset{
    today = small,
    punct = kaiming,
    section = {
      name = {,、},
      number = \chinese{section},
      format = \large\bfseries\centering,
    },
    subsection/format = \large\bfseries,
    paragraph/runin = true,
  }


%% Loading Packages
% 确保使用xelatex来进行编译
\RequirePackage{iftex}
\RequireXeTeX
\ifxetex
  \relax
\else
  \ClassError{my_GZUexrept}{You must use driver `xelatex'.}
\fi


% 数学符号
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}


% 页面布局
\RequirePackage{geometry}
    \geometry{left=3.17cm,right=3.17cm,top=2.54cm,bottom=1.70cm}
\pagestyle{plain}


% 插入图表
\RequirePackage{graphicx}
\RequirePackage{array}
    \renewcommand\arraystretch{1.4}


% 设置代码环境
\RequirePackage{xcolor}
    \definecolor{dkgreen}{rgb}{0,0.6,0}    
    \definecolor{gray}{rgb}{0.5,0.5,0.5}
    \definecolor{mauve}{rgb}{0.58,0,0.82}
\RequirePackage{listings}
    \lstset{
        frame=tb,
        aboveskip=3mm,
        belowskip=3mm,
        showstringspaces=false,
        columns=flexible,
        framerule=1pt,
        rulecolor=\color{gray!35},
        backgroundcolor=\color{gray!5},
        basicstyle={\small\rmfamily}, %基础文字格式
        numbers=left, %行号居左显示
        numberstyle=\footnotesize\color{gray}, %行号格式
        keywordstyle=\color{blue}, %关键字颜色
        commentstyle={\itshape\color{dkgreen}}, %注释文字格式
        stringstyle=\color{mauve}, %字符串文字格式
        breaklines=true, %允许断行
        breakatwhitespace=true,
        tabsize=3,
        escapeinside={""} %半角双引号括住的内容退回由LaTeX编译
    }
\RequirePackage[ruled,linesnumbered]{algorithm2e}


%% Define environments and commands
% 实验报告封面
\newcommand*\GZU@tokens@course{}
\newcommand*\GZU@tokens@department{}
\newcommand*\GZU@tokens@major{}
\newcommand*\GZU@tokens@studentID{}
\newcommand*\GZU@tokens@teacher{}

\newcommand*\course[1]{%
	\renewcommand{\GZU@tokens@course}{#1}}

\newcommand*\department[1]{%
	\renewcommand{\GZU@tokens@department}{#1}}

\newcommand*\major[1]{%
	\renewcommand{\GZU@tokens@major}{#1}}

\newcommand*\studentID[1]{%
	\renewcommand{\GZU@tokens@studentID}{#1}}

\newcommand*\teacher[1]{%
	\renewcommand{\GZU@tokens@teacher}{#1}}


\renewcommand{\maketitle} {
  \global\let\thanks\@empty
	\begin{titlepage}
		\begin{figure}[t]
			\centering
			\includegraphics[height=200pt]{GZUlogo.jpg}
		\end{figure}
		\begin{center}
			\heiti{\zihao{0}{实验报告}}
			\vskip 48pt
			\begin{table}[h]
				\centering
				\begin{tabular}{>{\heiti \zihao{3}}p{3.7cm} >{\zihao{3}}p{7cm}}
					实验课程名称: & \GZU@tokens@course \\ \cline{2-2} \\
					实验项目名称: & \@title \\ \cline{2-2} \\
					学 \hspace{8ex} 院: & \GZU@tokens@department \\ \cline{2-2} \\
					专 \hspace{8ex} 业: & \GZU@tokens@major \\ \cline{2-2} \\
					学 \hspace{8ex} 生: & \@author \\ \cline{2-2} \\
					学 \hspace{8ex} 号: & \GZU@tokens@studentID \\ \cline{2-2} \\
					教 \hspace{8ex} 师: & \GZU@tokens@teacher \\ \cline{2-2}
				\end{tabular}
			\end{table}
			\vskip 16pt
			\songti{\zihao{3}{\@date}}
		\end{center}
	  \end{titlepage}
	\newpage
  \setcounter{page}{1}
}



% 解题环境
\newenvironment{exercise}[1][\empty]
  {\paragraph{实验~#1} \kaishu}
  {\par \normalfont}


\endinput