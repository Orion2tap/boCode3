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
<#--    <link rel="stylesheet" type="text/css" href="/bo.css">-->
    <link rel="stylesheet" href="//static2.cnodejs.org/public/stylesheets/index.min.23a5b1ca.min.css" media="all">
    <script type="text/javascript" src="/bo.js"></script>

    <!-- markdown editor -->
    <script src="//static2.cnodejs.org/public/editor.min.1a456564.min.js"></script>

    <!-- markdown parse -->
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

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
        <!-- 作者其他话题 -->
        <div class='panel'>
            <div class='header'>
                <span class='col_fade'>作者其它话题</span>
            </div>
            <div class='inner'>
                <ul class='unstyled'>
                    <#-- otherTopics list-->
                    <#list otherTopics as t>
                        <li>
                            <div><a class='dark topic_title' href="/topic/detail/${t.id}"
                                    title=${t.title}>${t.title}</a>
                            </div>
                        </li>
                    </#list>
                </ul>
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
    </div>

    <!-- content -->
    <div id='content'>
        <#-- 话题信息 -->
        <div class='panel'>
            <div class='header topic_header'>
                <#-- 标题等 -->
                <span class="topic_full_title">${topic.title}</span>
                <div class="changes" data-topic-username=${topic.user.username}>
                    <span>发布于 <@f.timeago time = topic.createdTime/></span>
                    <span>作者 <a href="/user/homepage/${topic.user.username}">${topic.user.username}</a></span>
                    <#--                    <span>11 次浏览</span>-->
                    <span> 来自 ${topic.board.name}</span>
                    <input class="span-common span-success pull-right collect_btn" type="submit" value="收藏"
                           action="star" id=${topic.id}>
                </div>
                <#-- 编辑和删除 -->
                <div id="manage_topic">
                    <a href='/topic/edit/${topic.id}'>
                        <i class="fa fa-lg fa-pencil-square-o" title='编辑'></i></a>
                    <a href="/topic/delete/${topic.id}/${token}" class='delete_topic_btn'>
                        <i class="fa fa-lg fa-trash" title='删除'></i>
                    </a>
                </div>
            </div>
            <#-- 内容 -->
            <div class='inner topic'>
                <div class='topic_content'>
                    <div class="markdown-text"><p>${topic.content}</p>
                    </div>
                </div>
            </div>
        </div>
        <#-- 所有回复 -->
        <div class='panel'>
            <#-- 回复数 -->
            <div class='header' id='id-div-header'>
                <span class='col_fade' id='id-span-count'>${comments?size} 回复</span>
            </div>
            <#-- comments list -->
            <#list comments?sort_by("floor") as c>
                <div class='cell reply_area reply_item' commentId=${c.id} username=${c.user.username} reply_id=${c.userId} reply_to_id=${topic.userId}>
                    <div class='author_content'>
                        <a href="/user/homepage/${c.user.username}" class="user_avatar">
                            <img src="/avatar/${c.user.avatar}" title=${c.user.username}/></a>

                        <div class='user_info'>
                            <a class='dark reply_author' href="/user/homepage/${c.user.username}">${c.user.username}</a>
                            <a class="reply_time">${c.floor}
                                楼•<@f.timeago time = c.updatedTime/></a>
                            <span class="reply_by_author">作者</span>
                        </div>
                        <#-- 对评论的操作 -->
                        <div class='user_action'>
                            <a href='/topicComment/delete/${c.id}' class='delete_reply_btn'>
                                <i  class="fa fa-trash" title='删除'></i>
                            </a>
                        </div>
                    </div>

                    <div class='reply_content'>
                        <div class="markdown-text"><p>${c.content}</p>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
        <#-- 添加回复 -->
        <div class='panel'>
            <div class='header'>
                <span class='col_fade'>添加回复</span>
            </div>
            <div class='inner reply'>
                <form id='reply_form' action='/topicComment/add/${topic.id}' method='post'>
                    <div class='markdown_editor in_editor'>
                        <div class='markdown_in_editor'>
                            <textarea class='editor' name='content' rows='8' maxlength="500"></textarea>
                            <!-- CSRF Token -->
                            <input type="hidden" name="csrfToken" value=${token}>
                            <div class='editor_buttons'>
                                <input class='span-primary submit_btn' type="submit" data-loading-text="回复中.."
                                       value="回复">
                            </div>
                        </div>
                    </div>
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
