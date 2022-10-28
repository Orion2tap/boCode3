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

    <!-- markdown editor -->
    <script src="//static2.cnodejs.org/public/editor.min.1a456564.min.js"></script>

    <!-- DIY -->
    <script src="/bocode.js"></script>
    <link rel="stylesheet" type="text/css" href="/bocode.css">

    <title>发布话题</title>

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
        <!-- Markdown 语法参考 -->
        <div class='panel'>
            <div class='header'>
                <span class='col_fade'>Markdown 语法参考</span>
            </div>
            <div class='inner'>
                <ol>
                    <li><tt>### 单行的标题</tt></li>
                    <li><tt>**粗体**</tt></li>
                    <li><tt>`console.log('行内代码')`</tt></li>
                    <li><tt>```js\n code \n```</tt> 标记代码块</li>
                    <li><tt>[内容](链接)</tt></li>
                    <li><tt>![文字说明](图片链接)</tt></li>
                </ol>
                <span><a href='https://markdown.com.cn/' target='_blank'>Markdown 文档</a></span>
            </div>
        </div>
        <!-- 话题发布指南 -->
        <div class='panel'>
            <div class='header'>
                <span class='col_fade'>话题发布指南</span>
            </div>
            <div class='inner'>
                <ol>
                    <li>尽量把话题要点浓缩到标题里</li>
                    <li>代码含义和报错可在 <a href="https://stackoverflow.com/">Stack Overflow</a> 提问</li>
                </ol>
            </div>
        </div>
    </div>

    <!-- content -->
    <div id='content'>
        <div class='panel'>
            <div class='header'>
                <ol class='breadcrumb'>
                    <li>
                        <a href='/'>主页</a>
                    </li>
                    <li class='active'>发布话题</li>
                </ol>
            </div>
            <div class='inner post'>

                <form id='create_topic_form' action='/topic/create' method='post'>
                    <fieldset>
                        <#-- 选择版块 -->
                        <span class="tab-selector">选择版块：</span>
                        <select name="boardId" id="tab-value">
                            <option value="">请选择</option>
                            <#list boards as b>
                                <option value="${b.id}" >${b.name}</option>
                            </#list>
                        </select>

                        <span id="topic_create_warn"></span>

                        <#-- 标题 -->
                        <textarea autofocus class='span9' id='title' name='title' rows='1'
                                  placeholder="标题字数 30 字以内" maxlength="30"
                        ></textarea>

                        <#-- 内容 -->
                        <div class='markdown_editor in_editor'>
                            <div class='markdown_in_editor'>
                                <textarea class='editor' name='content' rows='20' placeholder='文章支持 Markdown 语法, 请注意标记代码'
                                          maxlength="1000"
                                ></textarea>
                                <!-- CSRF Token -->
                                <input type='hidden' name='csrfToken' value=${token}>
                                <#-- 提交 -->
                                <div class='editor_buttons'>
                                    <input type="submit" class='span-primary submit_btn' data-loading-text="提交中"
                                           value="提交">
                                </div>
                            </div>
                        </div>

                    </fieldset>
                </form>

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
