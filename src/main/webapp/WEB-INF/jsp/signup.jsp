<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Регистрация | Железнодорожные перевозки</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --purple: #8A2BE2;
            --dark-purple: #6A1B9A;
            --light-purple: #E6E6FA;
            --ivory: #FFFFF0;
            --charcoal: #36454F;
            --slate: #708090;
            --success: #4CAF50;
            --danger: #F44336;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--ivory);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 480px;
        }

        .card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background: var(--purple);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
        }

        .card-header img {
            height: 50px;
            width: auto;
            margin-bottom: 15px;
        }

        .card-header h2 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
            font-size: 1.8rem;
            position: relative;
        }

        .card-header h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 2px;
            background: white;
        }

        .card-body {
            padding: 32px;
        }

        .form-group {
            margin-bottom: 24px;
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
            left: 16px;
            top: 42px;
            color: var(--purple);
        }

        .form-control {
            width: 100%;
            padding: 14px 16px 14px 44px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-control:focus {
            border-color: var(--purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.2);
        }

        .btn {
            display: block;
            width: 100%;
            padding: 14px;
            background: var(--purple);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .btn:active {
            transform: translateY(0);
        }

        .text-center {
            text-align: center;
        }

        .mt-3 {
            margin-top: 16px;
        }

        .link {
            color: var(--purple);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .link:hover {
            color: var(--dark-purple);
            text-decoration: underline;
        }

        .error-message {
            color: var(--danger);
            font-size: 14px;
            margin-top: 4px;
            display: none;
        }

        .success-message {
            color: var(--success);
            text-align: center;
            margin-bottom: 20px;
            font-weight: 500;
        }

        @media (max-width: 576px) {
            .card-body {
                padding: 24px;
            }
        }

        /* Анимации */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .card {
            animation: fadeIn 0.6s ease-out;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <div class="card-header">
            <i class="fas fa-train" style="font-size: 3rem; color: white; margin-bottom: 15px;"></i>
            <h2>Создать аккаунт</h2>
        </div>
        <div class="card-body">
            <form id="signupForm">
                <div class="form-group">
                    <label for="username">Имя пользователя</label>
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" id="username" class="form-control" placeholder="Введите имя пользователя" required>
                    <div class="error-message" id="username-error"></div>
                </div>

                <div class="form-group">
                    <label for="email">Электронная почта</label>
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" id="email" class="form-control" placeholder="Введите ваш email" required>
                    <div class="error-message" id="email-error"></div>
                </div>

                <div class="form-group">
                    <label for="password">Пароль</label>
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" id="password" class="form-control" placeholder="Создайте пароль" required>
                    <div class="error-message" id="password-error"></div>
                </div>

                <button type="submit" class="btn">
                    <i class="fas fa-user-plus"></i> Зарегистрироваться
                </button>
            </form>

            <div class="text-center mt-3">
                <span>Уже есть аккаунт?</span>
                <a href="/signin" class="link">Войти</a>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Валидация формы
        function validateForm() {
            let isValid = true;

            // Валидация имени пользователя
            if ($("#username").val().length < 4) {
                $("#username-error").text("Имя пользователя должно содержать минимум 4 символа").show();
                isValid = false;
            } else {
                $("#username-error").hide();
            }

            // Валидация email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test($("#email").val())) {
                $("#email-error").text("Введите корректный email").show();
                isValid = false;
            } else {
                $("#email-error").hide();
            }

            // Валидация пароля
            if ($("#password").val().length < 6) {
                $("#password-error").text("Пароль должен содержать минимум 6 символов").show();
                isValid = false;
            } else {
                $("#password-error").hide();
            }

            return isValid;
        }

        // Обработка отправки формы
        $("#signupForm").submit(function(e) {
            e.preventDefault();

            if (!validateForm()) return;

            const signupData = {
                username: $("#username").val(),
                email: $("#email").val(),
                password: $("#password").val()
            };

            // Показываем индикатор загрузки
            $(".btn").html('<i class="fas fa-spinner fa-spin"></i> Регистрация...').prop("disabled", true);

            $.ajax({
                type: "POST",
                url: "/auth/signup",
                contentType: "application/json",
                data: JSON.stringify(signupData),
                success: function(response) {
                    // Проверяем, вернулся ли токен (автоматическая авторизация)
                    if (response && response.token) {
                        // Сохраняем токен
                        localStorage.setItem("jwtToken", response.token);
                        sessionStorage.setItem("jwtToken", response.token);
                        
                        // Устанавливаем cookie для токена
                        document.cookie = "jwtToken=" + response.token + "; path=/; max-age=86400";
                        
                        $(".card-body").prepend(
                            '<div class="success-message">' +
                            '<i class="fas fa-check-circle"></i> Регистрация прошла успешно! Вы автоматически вошли в систему.' +
                            '</div>'
                        );

                        $("#signupForm")[0].reset();
                        $(".btn").html('<i class="fas fa-user-plus"></i> Зарегистрироваться').prop("disabled", false);

                        // Перенаправляем на страницу пользователя
                        setTimeout(() => {
                            window.location.href = response.redirectUrl || "/userHome";
                        }, 1500);
                    } else {
                        // Если токен не вернулся, показываем сообщение о необходимости входа
                    $(".card-body").prepend(
                        '<div class="success-message">' +
                        '<i class="fas fa-check-circle"></i> Регистрация прошла успешно! Теперь вы можете войти.' +
                        '</div>'
                    );

                    $("#signupForm")[0].reset();
                    $(".btn").html('<i class="fas fa-user-plus"></i> Зарегистрироваться').prop("disabled", false);

                    setTimeout(() => {
                            window.location.href = "/signin";
                    }, 2000);
                    }
                },
                error: function(xhr) {
                    // Восстанавливаем кнопку
                    $(".btn").html('<i class="fas fa-user-plus"></i> Зарегистрироваться').prop("disabled", false);

                    if (xhr.status === 400) {
                        const errorMsg = xhr.responseText;
                        if (errorMsg.includes("имя пользователя")) {
                            $("#username-error").text(errorMsg).show();
                        } else if (errorMsg.includes("Email")) {
                            $("#email-error").text(errorMsg).show();
                        } else {
                            alert(errorMsg);
                        }
                    } else {
                        alert("Произошла ошибка при регистрации. Пожалуйста, попробуйте позже.");
                    }
                }
            });
        });

        // Анимация при фокусе
        $(".form-control").focus(function() {
            $(this).parent().find("label").css("color", "var(--purple)");
        }).blur(function() {
            $(this).parent().find("label").css("color", "var(--charcoal)");
        });
    });
</script>
</body>
</html>