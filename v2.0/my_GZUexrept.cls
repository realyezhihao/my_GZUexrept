\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{my_GZUexrept}[2024/05/23 v2.0]


%% Initial Code
\newif\ifGZU@rulepage
  \GZU@rulepagetrue
\newif\ifGZU@withateacher
  \GZU@withateacherfalse


%% Class Options
\DeclareOption{norulepage}{\GZU@rulepagefalse}
\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{graphicx}}
\DeclareOption*{
  \typeout{Option \CurrentOption\ has been passed to class ctexart.}
  \PassOptionsToClass{\CurrentOption}{ctexart}
  }
\ProcessOptions\relax


%% Loading Classes
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
    \geometry{left=2.8cm,right=2.8cm,top=2.5cm,bottom=2.5cm}
\pagestyle{plain}


% 插入图表
\RequirePackage{graphicx}
\RequirePackage{array}
    \renewcommand\arraystretch{1.4}


% 设置代码环境
\RequirePackage{listings}
\RequirePackage{xcolor}
  \definecolor{dkgreen}{rgb}{0,0.6,0}    
  \definecolor{gray}{rgb}{0.5,0.5,0.5}
  \definecolor{mauve}{rgb}{0.58,0,0.82}
  \lstset{
    frame=tb,
    aboveskip=3mm,
    belowskip=3mm,
    showstringspaces=false,
    columns=flexible,
    framerule=1pt,
    rulecolor=\color{gray!35},
    backgroundcolor=\color{gray!5},
    morekeywords={}, %补充更多关键字，用逗号分隔
    emph={}, %设置强调词，用逗号分隔
    numbers=none, %取消行号显示
    %numberstyle=\footnotesize\color{gray}, %行号字体格式
    basicstyle={\small\rmfamily}, %基本代码字体格式
    keywordstyle={\bfseries\color{blue}}, %关键词字体格式
    commentstyle={\itshape\color{dkgreen}}, %注释字体格式
    stringstyle=\color{mauve}, %字符串字体格式
    emphstyle={\bfseries\color{red}}, % 强调词字体格式
    breaklines=true,
    breakatwhitespace=true,
    tabsize=3,
    escapeinside={``} %半角反单引号括住的内容退回由LaTeX编译
}
\RequirePackage[ruled,linesnumbered]{algorithm2e}


%% Defining Environments and Commands
% 实验报告封面
\RequirePackage{keyval}

\newcommand*{\GZU@tokens@course}{}
\newcommand*{\GZU@tokens@department}{数学与统计学院}
\newcommand*{\GZU@tokens@major}{数学与应用数学}
\newcommand*{\GZU@tokens@studentID}{}
\newcommand*{\GZU@tokens@teacher}{}
\renewcommand*{\@title}{}
\renewcommand*{\@author}{}
\renewcommand*{\@date}{\today}

\newcommand*{\course}[1]{%
	\renewcommand*{\GZU@tokens@course}{#1}}
\newcommand*{\department}[1]{%
	\renewcommand*{\GZU@tokens@department}{#1}}
\newcommand*{\major}[1]{%
	\renewcommand*{\GZU@tokens@major}{#1}}
\newcommand*{\studentID}[1]{%
	\renewcommand*{\GZU@tokens@studentID}{#1}}
\newcommand*{\teacher}[1]{%
	\renewcommand*{\GZU@tokens@teacher}{#1}}
\renewcommand*{\title}[1]{%
  \renewcommand*{\@title}{#1}}
\renewcommand*{\author}[1]{%
  \renewcommand*{\@author}{#1}}
\renewcommand*{\date}[1]{%
  \renewcommand*{\@date}{#1}}

\define@key{titlepage}{course}[]{%
  \course{#1}}
\define@key{titlepage}{title}[]{%
  \title{#1}}
\define@key{titlepage}{department}[]{%
  \department{#1}}
\define@key{titlepage}{major}[]{%
  \major{#1}}
\define@key{titlepage}{author}[]{%
  \author{#1}}
\define@key{titlepage}{studentID}[]{%
  \studentID{#1}}
\define@key{titlepage}{teacher}[]{%
  \GZU@withateachertrue\teacher{#1}}
\define@key{titlepage}{date}[\qquad 年\quad 月\quad 日]{%
  \date{#1}}

\newcommand\titlepageset[1]{%
  \setkeys{titlepage}{#1}}

\renewcommand{\maketitle}{%
  \global\let\thanks\@empty

  \thispagestyle{empty}
	\begin{figure}[t]
		\centering
		\includegraphics[height=4.89cm]{GZUlogo.jpg}
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
				学 \hspace{8ex} 号: & \GZU@tokens@studentID \\ \cline{2-2}
        \ifGZU@withateacher
				\\教 \hspace{8ex} 师: & \GZU@tokens@teacher \\ \cline{2-2}
        \fi
			\end{tabular}
		\end{table}
		\vskip 36pt
		\songti{\zihao{3}{实验日期：\@date}}
	\end{center}
  \newpage

  \ifGZU@rulepage
  \thispagestyle{empty}
  \newgeometry{left=2.8cm,right=2.8cm,top=4.5cm,bottom=2.5cm}
  \begin{center}
    \heiti{\zihao{2}{学生实验室守则}}
    \vskip 36pt
  \end{center}

  \linespread{1.75}\selectfont
  一、按教学安排准时到实验室上实验课，不得迟到、早退和旷课。

  二、进入实验室必须遵守实验室的各项规章制度，保持室内安静、整洁，不准在室内打闹、喧哗、吸烟、吃食物、随地吐痰、乱扔杂物，不准做与实验内容无关的事，非实验用品一律不准带进实验室。

  三、实验前必须做好预习（或按要求写好预习报告），未做预习者不准参加实验。

  四、实验必须服从教师的安排和指导，认真按规程操作，未经教师允许不得擅自动用仪器设备，特别是与本实验无关的仪器设备和设施，如擅自动用或违反操作规程造成损坏，应按规定赔偿，严重者给予纪律处分。

  五、实验中要节约水、电、气及其它消耗材料。

  六、细心观察、如实记录实验现象和结果，不得抄袭或随意更改原始记录和数据，不得擅离操作岗位和干扰他人实验。

  七、使用易燃、易爆、腐蚀性、有毒有害物品或接触带电设备进行实验，应特别注意规范操作，注意防护；若发生意外，要保持冷静，并及时向指导教师和管理人员报告，不得自行处理。仪器设备发生故障和损坏，应立即停止实验，并主动向指导教师报告，不得自行拆卸查看和拼装。

  八、实验完毕，应清理好实验仪器设备并放回原位，清扫好实验现场，经指导教师检查认可并将实验记录交指导教师检查签字后方可离去。

  九、无故不参加实验者，应写出检查，提出申请并缴纳相应的实验费及材料消耗费，经批准后，方可补做。

  十、自选实验，应事先预约，拟订出实验方案，经实验室主任同意后，在指导教师或实验技术人员的指导下进行。

  十一、实验室内一切物品未经允许严禁带出室外，确需带出，必须经过批准并办理手续。
  
  \newpage
  \restoregeometry
  \fi

  \linespread{1.5}\selectfont
  \setcounter{page}{1}
}

% 题目环境
\newenvironment{experiment}[1][\empty]
  {\paragraph{实验~#1} \kaishu}
  {\par \normalfont}

\endinput