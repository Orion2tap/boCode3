<#import "../freemarker.ftl" as f>

<!DOCTYPE html>
<html>
<head>
    <!-- meta -->
    <meta charset="utf-8"/>
    <meta name='description' content='boCode'>
    <!-- 可视区域 -->
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- 追踪用户上一个访问页面 -->
    <meta name="referrer" content="always">
    <meta name="author" content="liubobo" />
    <link rel="icon" href="/favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.1.js" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>

    <!-- bo -->
    <link rel="stylesheet" type="text/css" href="/bo.css">
    <script type="text/javascript" src="/bo.js"></script>

    <!-- DIY -->
    <script src="/bocode.js"></script>
    <link rel="stylesheet" type="text/css" href="/bocode.css">

    <title>boCode</title>

</head>


<body>
<!-- 导航栏 -->
<div class='navbar'>
    <div class='navbar-inner'>
        <div class='container'>
            <a id='id-a-brand' class='brand' href='/'>
                <img src="/boCode.png" />
            </a>

            <ul class='nav pull-right'>
                <li><a href='/'>首页</a></li>
                <li><a href='/user/greener'>新手入门</a></li>
                <li><a href='/user/about'>关于</a></li>
                <li><a href='/user/setting'>设置</a></li>
                <li>
                    <a id='id-a-register' data-toggle="modal" data-target="#register">
                        <span class="glyphicon glyphicon-user"></span> 注册
                    </a>
                </li>
                <li>
                    <a id='id-a-login' data-toggle="modal" data-target="#login">
                        <span class="glyphicon glyphicon-log-in"></span> 登录
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<!-- main -->
<div id='main'>
    <!-- 侧边栏 -->
    <div id='sidebar'>
        <!-- 个人信息 -->
        <div class='panel'>

            <div class='header'>
                <span class='col_fade'>个人信息</span>
            </div>
            <div class='inner'>
                <div class='user_card'>
                    <div>
                        <a class='user_avatar' href="/user/homepage/${u.username}">
                            <img src="/avatar/${u.avatar}" title=${u.username}>
                        </a>
                        <span class='user_name'>
                            <a id='id-a-username' data-username=${u.username} class='dark' href="/user/homepage/${u.username}">
                                ${u.username}
                            </a>
                        </span>

                        <div class='board clearfix'>
                            <div class='floor'>
                                <span class='big'>
                                    Github: <a href=${u.github!"https://github.com/"} target="_blank">${u.github!"待填写"}</a>
                                </span>
                                <#--                                <span class='big'>Github: ${u.github!"待填写"}</span>-->
                            </div>
                            <div class='floor'>
                                <span class='big'>签名: ${u.note!"待填写"}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 发布话题 -->
        <div class="panel">
            <div class="inner">
                <a href="/topic/create" id="create_topic_btn">
                    <span class="span-success">发布话题</span>
                </a>
            </div>
        </div>
        <!-- 友情社区 -->
        <div class="panel">
            <div class="header">
                <span class="col_fade">友情社区</span>
            </div>
            <div class="inner">
                <ol class="friendship-community">
                    <li>
                        <a href="https://github.com/" target="_blank">
                            <img src="/github.png">
                        </a>
                    </li>
                    <div class="sep10"></div>
                    <li>
                        <a href="https://stackoverflow.com/" target="_blank">
                            <img src="/stackoverflow.png">
                        </a>
                    </li>
                    <div class="sep10"></div>
                    <li>
                        <a href="https://www.bilibili.com/" target="_blank">
                            <img src="/bilibili.png">
                        </a>
                    </li>
                </ol>
            </div>
        </div>
        <!-- 二维码 -->
        <div class="panel">
            <div class="header">
                <span class="col_fade">源码地址</span>
            </div>
            <div class="inner cnode-app-download">
                <img width="200" src="/QRcode.png">
                <br>
                <a href="https://github.com/liubobo1996/boCode3" target="_blank">源码地址</a>
            </div>
        </div>
    </div>

    <!-- content -->
    <div id="content">
        <div class="panel">
            <div class="header">
                <ul class="breadcrumb">
                    <li><a href="/">主页</a></li>
                    <li class="active">Java Web 新手入门</li>
                </ul>
            </div>
            <div class="inner topic">
                <div class="topic_content">
                    <div class="markdown-text">
                        <h2>技术书籍</h2>
                        <p>《<strong>Java核心技术·卷 I（原书第11版）</strong>》</p>
                        <p><a href="https://book.douban.com/subject/34898994/" target="_blank">https://book.douban.com/subject/34898994/</a></p>

                        <p>《<strong>SQL必知必会（第5版）</strong>》</p>
                        <p><a href="https://book.douban.com/subject/35167240/" target="_blank">https://book.douban.com/subject/35167240/</a></p>

                        <p>《<strong>Clean Code: A Handbook of Agile Software Craftsmanship</strong>》</p>
                        <p><a href="https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882" target="_blank">https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882</a></p>

                        <h2>官方文档</h2>
                        <p><strong>Spring Framework Documentation</strong></p>
                        <p><a href="https://docs.spring.io/spring-framework/docs/current/reference/html/" target="_blank">https://docs.spring.io/spring-framework/docs/current/reference/html/</a></p>

                        <p><strong>The Linux Command Line</strong></p>
                        <p><a href="https://www.amazon.com/Linux-Command-Line-Complete-Introduction/dp/1593273894" target="_blank">https://www.amazon.com/Linux-Command-Line-Complete-Introduction/dp/1593273894</a></p>

                        <h2>网络资源</h2>
                        <p><strong>线性代数的本质</strong></p>
                        <p><a href="https://www.bilibili.com/video/BV1ys411472E/?spm_id_from=333.999.0.0" target="_blank">https://www.bilibili.com/video/BV1ys411472E/?spm_id_from=333.999.0.0</a></p>

                        <p><strong>微积分的本质</strong></p>
                        <p><a href="https://www.bilibili.com/video/BV1qW411N7FU/?spm_id_from=333.999.0.0" target="_blank">https://www.bilibili.com/video/BV1qW411N7FU/?spm_id_from=333.999.0.0</a></p>

                        <p><strong>2015 CMU 15-213 CSAPP</strong></p>
                        <p><a href="https://www.bilibili.com/video/BV1iW411d7hd/?spm_id_from=333.999.0.0" target="_blank">https://www.bilibili.com/video/BV1iW411d7hd/?spm_id_from=333.999.0.0</a></p>

                        <p><strong>计算机程序的构造和解释（SICP）</strong></p>
                        <p><a href="https://www.bilibili.com/video/BV1Xx41117tr/?spm_id_from=333.999.0.0" target="_blank">https://www.bilibili.com/video/BV1Xx41117tr/?spm_id_from=333.999.0.0</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="backtotop" style="display: none; top: 657px; right: 0;">回到顶部</div>
<div id="footer">
    <div id="footer_main">
        <div class="links">
            <a class="dark">Github</a>
            |
            <a class="dark" href="https://github.com/liubobo1996/boCode3">源码地址</a>
        </div>

        <div class="col_fade">
            <p>boCode 社区为国内最专业的 Java Web 技术社区，致力于 Java Web 的技术研究。</p>
            <p>服务器搭建在
                <a href="https://www.tencentcloud.com/" target="_blank" class="sponsor_outlink" data-label="tencentcloud">
                    <img src="/cloud.png" title="tencentcloud" alt="tencentcloud" width="150">
                </a>
            </p>
        </div>
    </div>
</div>
<div id="sidebar-mask"></div>

</body>
</html>
