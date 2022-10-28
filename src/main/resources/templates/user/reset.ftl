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
    <link rel="stylesheet" type="text/css" href="/bo.css">
    <script type="text/javascript" src="/bo.js"></script>

    <!-- DIY -->
    <script src="/bocode.js"></script>
    <link rel="stylesheet" type="text/css" href="/bocode.css">

    <title>boCode</title>

</head>

<body onload="reset()">

<!-- Modal reset -->
<div id="reset" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
    <div id="modal-dialog" class="modal-dialog">
        <div class="loginmodal-container">
            <div class="modal-header">
                <button class="close" data-dismiss="modal">
                    <span>×</span>
                </button>
            </div>

            <h1>重置密码</h1><br>
            <form id="id-form-update" action="/reset/update" method="post">
                <input type="hidden" name="token" value=${token}>
                <input type="text" name="password" placeholder="New Password">
                <input type="submit" name="findPassword" class="login loginmodal-submit" value="提交">
            </form>
        </div>
    </div>
</div>

<script>
    let reset = function () {
        $('#reset').modal('show');
    }
</script>

</body>
</html>