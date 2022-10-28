<#import "freemarker.ftl" as f>

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

<body onload="loginRequired()">
<!-- Modal Register -->
<div id="register" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div id="modal-dialog" class="modal-dialog">
        <div class="loginmodal-container">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>×</span>
                </button>
            </div>

            <h1>注册</h1><br>
            <form action="/user/register" method="post">
                <input type="text" name="username" placeholder="Username" value="">
                <input type="password" name="password" placeholder="Password" value="">
<#--                <input type="password" name="password" placeholder="Password Confirm" value="">-->
                <input type="text" name="email" placeholder="Email" value="">
                <input type="submit" name="register" class="login loginmodal-submit" value="提交">
            </form>

            <div class="login-help">
                <a href="" data-toggle="modal" data-dismiss="modal" data-target="#login">登录</a> - <a href="" data-toggle="modal" data-dismiss="modal" data-target="#findPassword">忘记密码</a>
            </div>
        </div>
    </div>
</div>

<!-- Modal Login -->
<div id="login" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div id="modal-dialog" class="modal-dialog">
        <div class="loginmodal-container">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>×</span>
                </button>
            </div>

            <h1>登录</h1><br>
            <form action="/user/login" method="post">
                <input type="text" name="username" placeholder="Username" value="bobo">
                <input type="password" name="password" placeholder="Password" value="123">
                <input type="submit" name="login" class="login loginmodal-submit" value="提交">
            </form>

            <div class="login-help">
                <a href="" data-toggle="modal" data-dismiss="modal" data-target="#register">注册</a> - <a href="" data-toggle="modal" data-dismiss="modal" data-target="#findPassword">忘记密码</a>
            </div>
        </div>
    </div>
</div>

<!-- Modal findPassword -->
<div id="findPassword" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div id="modal-dialog" class="modal-dialog">
        <div class="loginmodal-container">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>×</span>
                </button>
            </div>

            <h1>找回密码</h1><br>
            <form id="id-form-send" action="/reset/send" method="post">
                <input type="text" name="username" placeholder="Username">
                <input type="submit" name="findPassword" class="login loginmodal-submit" value="发送邮件">
            </form>

            <div class="login-help">
                <a href="" data-toggle="modal" data-dismiss="modal" data-target="#login">登录</a> - <a href="" data-toggle="modal" data-dismiss="modal" data-target="#register">注册</a>
            </div>
            <h4 id="id-h4-tips">点击后前往邮箱查收</h4>
        </div>
    </div>
</div>

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
        <!-- 无人回复的话题 -->
        <div class='panel'>
            <div class='header'>
                <span class='col_fade'>无人回复的话题</span>
            </div>
            <div class='inner'>

                <ul class='unstyled'>
                    <#list noReplyTopics as t>
                        <li>
                            <div><a class='dark topic_title' href="/topic/detail/${t.id}"
                                    title=${t.title}>${t.title}</a>
                            </div>
                        </li>
                    </#list>
                </ul>

            </div>
        </div>
        <!-- 积分榜 -->
        <div class="panel">
            <div class="header">
                <span class="col_fade">积分榜</span>
                &nbsp;
                <a class="dark" href="/user/top">TOP 50 &gt;&gt;</a>
            </div>
            <div class="inner">
                <ol>
                    <#list rankingUsers as r>
                        <li>
                            <span class="top_score">${r.score}</span>
                            <span class="user_name"><a href="/user/homepage/${r.username}">${r.username}</a></span>
                        </li>
                    </#list>
                </ol>
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
    <div id='content'>
        <div class='panel'>
            <#-- 版块 -->
            <div class="header current-board" current_board=${boardId}>
                    <a href="/topic/0/1" class="topic-tab " board=0>全部</a>
                <#list boards as b>
<#--                    <li role="presentation" class="active"><a href="/topic/board/${b.id}">${b.name}</a></li>-->
                    <a href="/topic/${b.id}/1" class="topic-tab " board=${b.id}>${b.name}</a>
                </#list>
            </div>

            <div class="inner no-padding">
                <div id="topic_list">
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
                            <#-- 贴子创建时间 -->
                            <a class="last_time pull-right" href="/topic/detail/${t.id}">
                                <img class="user_small_avatar" id="id-crt-newAvatar" src="/avatar/${t.newReviewerAvatar!'default.jpg'}">
                                <#-- 宏调用 -->
                                <#-- 无回复则显示话题创建时间 -->
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
                        <#if pages gt 0>
                            <#-- 跳到第一页 -->
                            <li><a href="/topic/${boardId}/1">«</a></li>
                            <#list 1..pages as p>
                                <li><a href="/topic/${boardId}/${p}">${p}</a></li>
                            </#list>
                            <#-- 跳到最后一页 -->
                            <li><a href="/topic/${boardId}/${pages}">»</a></li>
                        </#if>
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
            <a style="display: block; text-align: center" href="https://beian.miit.gov.cn/" target="_blank">湘ICP备2022022168号</a>
        </div>
    </div>
</div>
<div id="sidebar-mask"></div>

<script>
    let loginRequired = function () {
        let username = $('#id-a-username').data('username');
        if (username == "游客") {
            $('#login').modal('show');
        }
    }
</script>

</body>

</html>
