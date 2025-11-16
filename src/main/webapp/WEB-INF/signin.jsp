<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Вход | Парикмахерская "Элегант"</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6a4c93;
            --secondary-color: #8a5a44;
            --accent-color: #f8bbd0;
            --light-color: #f9f9f9;
            --dark-color: #333;
            --error-color: #ff4444;
            --success-color: #00C851;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .login-image {
            flex: 1;
            background: url('https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80') center/cover no-repeat;
            position: relative;
            display: none;
        }

        .login-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to right, rgba(106, 76, 147, 0.7), rgba(138, 90, 68, 0.6));
        }

        .image-content {
            position: relative;
            z-index: 1;
            color: white;
            padding: 40px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        .image-content h2 {
            font-size: 2.2rem;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .image-content p {
            font-size: 1rem;
            line-height: 1.6;
            opacity: 0.9;
        }

        .login-form {
            flex: 1;
            background: white;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .logo {
            text-align: center;
            margin-bottom: 40px;
        }

        .logo i {
            font-size: 2.5rem;
            color: var(--primary-color);
        }

        .logo h1 {
            font-size: 1.8rem;
            color: var(--primary-color);
            margin-top: 10px;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark-color);
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 42px;
            color: var(--primary-color);
        }

        .form-control {
            width: 100%;
            padding: 14px 16px 14px 44px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(106, 76, 147, 0.2);
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }

        .btn:hover {
            background: #5a3d7d;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(106, 76, 147, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .additional-options {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            font-size: 0.9rem;
        }

        .remember-me {
            display: flex;
            align-items: center;
        }

        .remember-me input {
            margin-right: 8px;
        }

        .forgot-password {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .register-link {
            text-align: center;
            margin-top: 30px;
            font-size: 0.95rem;
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: var(--error-color);
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        /* Модальное окно */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: modalFadeIn 0.3s ease-out;

            /* Центрирование модального окна */
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }


        .modal-icon {
            font-size: 3rem;
            color: var(--error-color);
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--dark-color);
        }

        .modal-message {
            font-size: 1rem;
            margin-bottom: 25px;
            color: var(--dark-color);
            line-height: 1.5;
        }

        .modal-btn {
            padding: 10px 25px;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .modal-btn:hover {
            background: #5a3d7d;
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translate(-50%, -60%);
            }
            to {
                opacity: 1;
                transform: translate(-50%, -50%);
            }
        }

        /* Анимации */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-form {
            animation: fadeIn 0.6s ease-out;
        }

        /* Медиа запросы */
        @media (min-width: 768px) {
            .login-image {
                display: block;
            }
        }

        @media (max-width: 576px) {
            .login-form {
                padding: 40px 25px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-image">
        <div class="image-content">
            <h2>Добро пожаловать!</h2>
            <p>Войдите в свой аккаунт, чтобы записаться на прием к нашим мастерам и получить доступ к персональным предложениям.</p>
        </div>
    </div>

    <div class="login-form">
        <div class="logo">
            <i class="fas fa-scissors"></i>
            <h1>Парикмахерская "Элегант"</h1>
        </div>

        <form id="loginForm">
            <div class="form-group">
                <label for="username">Имя пользователя</label>
                <i class="fas fa-user input-icon"></i>
                <input type="text" id="username" name="username" class="form-control" placeholder="Введите username" required>
                <div class="error-message" id="username-error"></div>
            </div>

            <div class="form-group">
                <label for="password">Пароль</label>
                <i class="fas fa-lock input-icon"></i>
                <input type="password" id="password" name="password" class="form-control" placeholder="Введите пароль" required>
                <div class="error-message" id="password-error"></div>
            </div>

            <div class="additional-options">
                <div class="remember-me">
                    <input type="checkbox" id="remember" name="remember">
                    <label for="remember">Запомнить меня</label>
                </div>
                <a href="/forgot-password" class="forgot-password">Забыли пароль?</a>
            </div>

            <button type="submit" class="btn">
                <i class="fas fa-sign-in-alt"></i> Войти
            </button>
        </form>

        <div class="register-link">
            Еще нет аккаунта? <a href="/signup">Зарегистрируйтесь</a>
        </div>
    </div>
</div>

<!-- Модальное окно для ошибок -->
<div id="errorModal" class="modal">
    <div class="modal-content">
        <div class="modal-icon">
            <i class="fas fa-exclamation-circle"></i>
        </div>
        <h3 class="modal-title">Ошибка входа</h3>
        <p class="modal-message" id="modalErrorMessage">Неверное имя пользователя или пароль</p>
        <button class="modal-btn" id="modalCloseBtn">Понятно</button>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Инициализация модального окна
        const modal = $("#errorModal");
        const modalMessage = $("#modalErrorMessage");
        const modalCloseBtn = $("#modalCloseBtn");

        // Функция для показа модального окна с ошибкой
        function showErrorModal(message) {
            modalMessage.text(message);
            modal.css('display', 'flex'); // Изменено на flex для лучшего центрирования
            $('body').css('overflow', 'hidden'); // Блокируем прокрутку страницы
        }

        // Закрытие модального окна
        modalCloseBtn.click(function() {
            modal.fadeOut(200);
            $('body').css('overflow', 'auto'); // Восстанавливаем прокрутку
        });

        // Закрытие при клике вне модального окна
        modal.click(function(event) {
            if (event.target === modal[0]) {
                modal.fadeOut(200);
                $('body').css('overflow', 'auto'); // Восстанавливаем прокрутку
            }
        });

        // Валидация формы
        function validateForm() {
            let isValid = true;

            // Валидация имени пользователя
            if ($("#username").val().trim() === "") {
                $("#username-error").text("Введите имя пользователя").show();
                isValid = false;
            } else {
                $("#username-error").hide();
            }

            // Валидация пароля
            if ($("#password").val().trim() === "") {
                $("#password-error").text("Введите пароль").show();
                isValid = false;
            } else {
                $("#password-error").hide();
            }

            return isValid;
        }

        // Обработка отправки формы
        $("#loginForm").submit(function(e) {
            e.preventDefault();

            if (!validateForm()) return;

            const signinData = {
                username: $("#username").val(),
                password: $("#password").val()
            };

            // Показываем индикатор загрузки
            $(".btn").html('<i class="fas fa-spinner fa-spin"></i> Вход...').prop("disabled", true);

            $.ajax({
                type: "POST",
                url: "/auth/signin",
                contentType: "application/json",
                data: JSON.stringify(signinData),
                success: async function (response) {
                    $(".card-body").prepend(
                        '<div class="success-message">' +
                        '<i class="fas fa-check-circle"></i> Вход прошел успешно! Теперь вы можете войти.' +
                        '</div>'
                    );

                    // Очищаем форму
                    $("#loginForm")[0].reset();

                    // Восстанавливаем кнопку
                    $(".btn").html('<i class="fas fa-user-plus"></i> Войти').prop("disabled", false);

                    localStorage.setItem("jwtToken", response.token);

                    // Переходим на новую страницу
                    window.location.href = response.redirectUrl;
                },
                error: function(xhr) {
                    // Восстанавливаем кнопку
                    $(".btn").html('<i class="fas fa-sign-in-alt"></i> Войти').prop("disabled", false);

                    if (xhr.status === 401) {
                        const errorMsg = xhr.responseText || "Неверное имя пользователя или пароль";
                        showErrorModal(errorMsg);
                    } else {
                        showErrorModal("Произошла ошибка при авторизации. Пожалуйста, попробуйте позже.");
                    }
                }
            });
        });

        // Анимация при фокусе
        $(".form-control").focus(function() {
            $(this).parent().find("label").css("color", "var(--primary-color)");
        }).blur(function() {
            $(this).parent().find("label").css("color", "var(--dark-color)");
        });
    });
</script>
</body>
</html>