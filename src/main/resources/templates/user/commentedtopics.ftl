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

    <!-- bo -->
    <link rel="stylesheet" type="text/css" href="/bo.css">
    <script type="text/javascript" src="/bo.js"></script>

    <!-- DIY -->
    <script src="/bocode.js"></script>
    <link rel="stylesheet" type="text/css" href="/bocode.css">

    <title>${u.username} 参与的话题</title>

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
                    <li><a href="/">主页</a><span class="divider">/</span></li>
                    <li class="active"><a href="/user/homepage/${u.username}">${u.username}的主页</a></li>
                </ul>
            </div>
        </div>

        <#-- 该用户参与的话题 -->
        <div class="panel">
            <div class="header">${u.username} 参与的话题</div>
            <div class="inner padding">
                <div id="topic_list">
                    <#-- topic 按最新评论时间逆序排列 -->
                    <#list pageTopics as t>
                        <div class="cell">
                            <a class="user_avatar pull-left" href="/user/homepage/${t.user.username}">
                                <img src="/avatar/${t.user.avatar}" title="${t.user.username}">
                            </a>

                            <#-- 评论数和点击量 -->
                            <span class="reply_count pull-left">
                       <span class="count_of_replies" title="回复数">
                         ${t.count}
                       </span>
                       <span class="count_seperator">&#8194回复</span>
<#--                       <span class="count_of_visits" title="点击数">-->
                                <#--                         557-->
                                <#--                       </span>-->
                   </span>

                            <#-- 贴子最新评论时间 -->
                            <a class="last_time pull-right" href="/topic/detail/${t.id}">
                                <img class="user_small_avatar" id="id-crt-newAvatar" src="/avatar/${t.newReviewerAvatar!'default.jpg'}">
                                <#-- 宏调用 -->
                                <span class="last_active_time"><@f.timeago time = t.latestComment.updatedTime/></span>
                            </a>

                            <#-- 贴子标题 -->
                            <div class="topic_title_wrapper">
                                <a class="topic_title" href="/topic/detail/${t.id}" title="${t.title}">
                                    ${t.title}
                                </a>
                            </div>
                        </div>
                    </#list>
                </div>

                <div class="pagination" current_page=${page}>
                    <ul>
                        <#-- 跳到第一页 -->
                        <li><a href="/user/commentedtopics/${u.username}?page=1">«</a></li>
                        <#list 1..pages as p>
                            <li><a href="/user/commentedtopics/${u.username}?page=${p}">${p}</a></li>
                        </#list>
                        <#-- 跳到最后一页 -->
                        <li><a href="/user/commentedtopics/${u.username}?page=${pages}">»</a></li>
                    </ul>
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
