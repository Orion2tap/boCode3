let log = console.log.bind(console);

let uploadBindChange = function () {
    $("#imageUpload").on('change', function () {
        if (this.files && this.files[0]) {
            let reader = new FileReader();
            let preview = $('#imagePreview');
            reader.onload = function(e) {
                preview.css('background-image', 'url('+e.target.result +')');
                preview.hide();
                preview.fadeIn(650);
            }
            reader.readAsDataURL(this.files[0]);

            let data = new FormData();
            data.append("file", this.files[0]);
            $.ajax({
                url: "/upload",
                type: "post",
                data: data,
                processData: false,
                contentType: false,
                dataType: 'text',
                success: function(response) {
                    log(response);
                }
            });
        }
    });
}

let resetSendSubmit = function () {
    $("#id-form-send").submit(function(event) {
        event.preventDefault();
        let form = $(this);

        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            dataType: 'text',           // 响应类型
            success: function(response)
            {
                $('#id-h4-tips').text(response);
                $('#findPassword').modal('show');
            }
        });
    });
}

let collectBindClick = function () {
    let target = $('.collect_btn');

    target.on('click', function () {
        let action = target.attr('action');
        let data = {
            topicId: target.attr('id')
        };

        $.ajax({
            url: '/topic/' + action,
            type: 'post',
            data: JSON.stringify(data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'text',
            success: function (response) {
                if (response === 'success') {
                    if (action === 'star') {
                        target.val('取消收藏');
                        target.attr('action', 'unstar');
                    } else {
                        target.val('收藏');
                        target.attr('action', 'star');
                    }
                    target.toggleClass('span-success');
                }
            }
        });
    });
}

let editAndDeleteButton = function () {
    // topic username = current username
    if ($('.changes').data('topic-username') !== $('#id-a-username').data('username')) {
        $('#manage_topic').css('display', 'none');
    }
}

let commentDeleteButton = function () {
    $('.reply_item').each(function() {
        let e = $(this);
        // topicComment username !== current username
        if (e.attr('username') !== $('#id-a-username').data('username')) {
            e.find('.delete_reply_btn').css('display', 'none');
        }
    });
}

let commentAuthorButton = function () {
    $('.reply_item').each(function() {
        let e = $(this);
        // topicComment userId !== topic userId
        if (e.attr('reply_id') !== e.attr('reply_to_id')) {
            e.find('.reply_by_author').css('display', 'none');
        }
    });
}

let loginAndRegisterButton = function () {
    let register = $('#id-a-register');
    let logIn = $('#id-a-login');
    let logOut = $('<a href=\'/user/logout\'><span class="glyphicon glyphicon-log-out"></span> 退出</a>');

    let currentUsername = $('#id-a-username').data("username");
    if (currentUsername !== '游客') {
        logIn.replaceWith(logOut);
        register.parent().remove();
    }
}

let collectButton = function () {
    let target = $('.collect_btn');
    let data = {
        topicId: target.attr('id')
    };

    $.ajax({
        url: '/topic/starcheck',
        type: 'post',
        data: JSON.stringify(data),
        contentType: 'application/json; charset=utf-8',
        dataType: 'text',
        success: function (response) {
            if (response !== '0') {
                target.val('取消收藏');
                target.attr('action', 'unstar');
                target.toggleClass('span-success');
            }
        }
    });
}

let pageHighLight = function () {
    let target = $('.pagination');
    let current_page = target.attr('current_page');
    if (current_page) {
        target.find('li').each(function () {
            let li = $(this);
            let a = li.find('a');
            if (a.html() === current_page) {
                li.addClass('active');
                a.removeAttr('href');
            }
        });
    }
}

let boardHighLight = function () {
    let target = $('.current-board');
    let current_boardId = target.attr('current_board');
    target.find('a').each(function () {
        let a = $(this);
        let boardId = a.attr('board');
        if (boardId === current_boardId) {
            a.addClass('current-tab');
        }
    })
}

let noReplyCount = function () {
    $("#id-span-count:contains('0 回复')").closest('.panel').css('display', 'none');
}

let noReplyAvatar = function () {
    // 如果 no reply
    $("[src='/avatar/default.jpg']").css('display', 'none');
}

let selectBoardCheck = function () {
    $('#create_topic_form').on('submit', function (e) {
        let tabValue = $('#tab-value').val();
        if (!tabValue) {
            alert('必须选择一个版块 ^_^');
            $('.submit_btn').button('reset');
            $('.tab-selector').css('color', 'red');
            return false;
        }
    });
}

let preselectBoard = function () {
    let boardId = $('#tab-value').data('board-id');

    $('.option-value').each(function(){
        if ($(this).attr('value') == boardId) {
            $(this).attr('selected', true);
        }
    });
}

let mdEditor = function () {
    $('textarea.editor').each(function () {
        var editor = new Editor({
            status: []
        });
        editor.render(this);
    });

    let target = $( "a" );
    target.remove( ".eicon-link" );
    target.remove( ".eicon-image" );
    $( "i" ).remove( ".separator" );
}

let mdParse = function () {
    $(".markdown-text").each(function(){
        let target = $(this);
        // 在 b.js 中调用 a.js 的方法
        // HTML 的 head 部分必须先引入 a.js, 后引入 b.js
        let parseResult = marked.parse(target.text());
        target.html(parseResult);
    });
}

let _main = function () {
    $(document).ready(function () {
        uploadBindChange();         // 上传头像
        resetSendSubmit();          // 重置密码
        collectBindClick();         // 收藏话题

        editAndDeleteButton();
        commentDeleteButton();
        commentAuthorButton();
        loginAndRegisterButton();
        collectButton();

        pageHighLight();            // 选中高亮
        boardHighLight();

        noReplyCount();             // 零回复隐藏的部分
        noReplyAvatar();

        selectBoardCheck();         // 版块选择检查
        preselectBoard();           // 预选版块
        mdEditor();                 // md 编辑区
        mdParse();                  // md 解析
    });
};

_main()
