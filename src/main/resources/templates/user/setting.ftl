
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
    <link rel="icon" href="favicon.ico" type="image/x-icon"/>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.1.js" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" crossorigin="anonymous"></script>

    <!-- bo -->
<#--    <link rel="stylesheet" type="text/css" href="/bo.css">-->
    <link rel="stylesheet" href="//static2.cnodejs.org/public/stylesheets/index.min.23a5b1ca.min.css" media="all">
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
<div id="main">
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

    <div id="content">
        <!-- form -->
        <div class="panel">
            <div class="header">
                <ul class="breadcrumb">
                    <li>
                        <a href="/">主页</a>
<#--                        <span class="divider">/</span>-->
                    </li>
                    <li class="active">设置</li>
                </ul>
            </div>
            <div class="inner">
                <!-- 头像 -->
                <div id="id-div-avatar">
                    <div class="avatar-upload">
                        <div class="avatar-edit">
                            <input type='file' name="file" id="imageUpload" accept=".jpg" />
                            <label for="imageUpload"></label>
                        </div>
                        <div class="avatar-preview">
                            <div id="imagePreview" style="background-image: url(http://119.45.22.158:8080/avatar/${u.avatar});">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 其他信息 -->
                <form id="setting_form" class="form-horizontal" action="/user/setting" method="post">
                    <!-- 用户名 -->
                    <div class="control-group">
                        <label class="control-label" for="username">用户名</label>
                        <div class="controls">
                            <input class="input-xlarge readonly" id="username" name="username" size="30" type="text" readonly="readonly" value=${u.username}>
                        </div>
                    </div>
                    <!-- 邮箱 -->
                    <div class="control-group">
                        <label class="control-label" for="email">邮箱</label>
                        <div class="controls">
                            <input class="input-xlarge readonly" id="email" name="email" size="30" type="text" readonly="readonly" value=${u.email}>
                        </div>
                    </div>
                    <!-- 个人网站 -->
                    <div class="control-group">
                        <label class="control-label" for="site">个人网站</label>
                        <div class="controls">
                            <input class="input-xlarge" id="site" name="site" size="30" type="text" value=${u.site!""}>
                        </div>
                    </div>
                    <!-- 所在地点 -->
                    <div class="control-group">
                        <label class="control-label" for="location">所在地点</label>
                        <div class="controls">
                            <input class="input-xlarge" id="location" name="location" size="30" type="text" value=${u.location!""}>
                        </div>
                    </div>
                    <!-- GitHub -->
                    <div class="control-group">
                        <label class="control-label" for="github">GitHub</label>
                        <div class="controls">
                            <input class="input-xlarge" id="github" name="github" size="30" type="text" placeholder="https://github.com/ + username" value=${u.github!""}>
                        </div>
                    </div>
                    <!-- 签名 -->
                    <div class="control-group">
                        <label class="control-label" for="note">签名</label>
                        <div class="controls">
                            <textarea class="input-xlarge" id="note" name="note" size="30">${u.note!""}</textarea>
                        </div>
                    </div>
                    <!-- CSRF Token -->
                    <input type="hidden" name="csrfToken" value=${token}>

                    <div class="form-actions">
                        <input type="submit" class="span-primary submit_btn" data-loading-text="保存中.." value="保存设置">
                    </div>
                </form>
            </div>
        </div>

        <!-- 找回密码 -->
<#--        <div class="panel">-->
<#--            <div class="header">-->
<#--                <span class="col_fade">更改密码</span>-->
<#--            </div>-->
<#--            <div class="inner">-->
<#--                <form id="change_pass_form" class="form-horizontal" action="/user/setting" method="post">-->
<#--                    <div class="control-group">-->
<#--                        <label class="control-label" for="old_pass">当前密码</label>-->

<#--                        <div class="controls">-->
<#--                            <input class="input-xlarge" type="password" id="old_pass" name="old_pass" size="30">-->
<#--                        </div>-->
<#--                    </div>-->
<#--                    <div class="control-group">-->
<#--                        <label class="control-label" for="new_pass">新密码</label>-->

<#--                        <div class="controls">-->
<#--                            <input class="input-xlarge" type="password" id="new_pass" name="new_pass" size="30">-->
<#--                        </div>-->
<#--                    </div>-->
<#--<!--                    <input type="hidden" id="id-setting-password" name="action" value="change_password">&ndash;&gt;-->
<#--<!--                    <input type="hidden" name="_csrf" value="KTXbY8hC-Tu3EalT3aMLo2ZX7cYCJTwnM0NU">&ndash;&gt;-->

<#--                    <div class="form-actions">-->
<#--                        <input type="submit" class="span-primary submit_btn" data-loading-text="更改中.." value="更改密码">-->
<#--                    </div>-->
<#--                </form>-->
<#--            </div>-->
<#--        </div>-->
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
