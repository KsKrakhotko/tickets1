<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Оплата билета | Железнодорожные перевозки</title>
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
            --warning: #FFC107;
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
            color: var(--charcoal);
            line-height: 1.6;
        }

        .admin-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        .admin-sidebar {
            background: linear-gradient(to bottom, #FFFFFF, #F8F8F8);
            box-shadow: 5px 0 15px rgba(0,0,0,0.05);
            border-right: 1px solid rgba(138, 43, 226, 0.3);
        }

        .admin-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
            margin-bottom: 20px;
        }

        .admin-title {
            display: flex;
            align-items: center;
            font-family: 'Playfair Display', serif;
        }

        .admin-title i {
            font-size: 2rem;
            margin-right: 15px;
            color: var(--purple);
        }

        .admin-title h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--charcoal);
            position: relative;
        }

        .admin-title h1::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 40px;
            height: 2px;
            background: var(--purple);
        }

        .nav-item {
            margin-bottom: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            color: var(--slate);
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .nav-link:hover {
            background: rgba(138, 43, 226, 0.1);
            color: var(--charcoal);
            transform: translateX(5px);
        }

        .nav-link.active {
            background: rgba(138, 43, 226, 0.15);
            color: var(--charcoal);
            border-left: 3px solid var(--purple);
            font-weight: 600;
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
            color: var(--purple);
            text-align: center;
        }

        .admin-content {
            padding: 40px;
            background-color: #FFF;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--charcoal);
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--purple);
        }

        .payment-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 30px;
        }

        .ticket-summary {
            background: #FFF;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            border-top: 4px solid var(--purple);
        }

        .payment-form {
            background: #FFF;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            border-top: 4px solid var(--purple);
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 25px;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--charcoal);
        }

        .form-input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-family: 'Montserrat', sans-serif;
            transition: border-color 0.3s;
            font-size: 1rem;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }

        .summary-item:last-child {
            border-bottom: none;
            font-weight: 600;
            font-size: 1.1rem;
            color: var(--purple);
            margin-top: 10px;
        }

        .summary-label {
            color: var(--slate);
        }

        .summary-value {
            color: var(--charcoal);
            font-weight: 500;
        }

        .submit-btn {
            background: var(--purple);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .submit-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .submit-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        .security-note {
            background: var(--light-purple);
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 0.9rem;
            color: var(--charcoal);
            text-align: center;
        }

        .security-note i {
            color: var(--purple);
            margin-right: 5px;
        }

        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }

            .payment-container {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .admin-content {
                padding: 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="admin-layout">
    <div class="admin-sidebar">
        <div class="admin-header">
            <div class="admin-title">
                <i class="fas fa-train"></i>
                <h1>ЖД-Портал</h1>
            </div>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/userHome" class="nav-link">
                    <i class="fas fa-user nav-icon"></i>
                    <span class="nav-text">Профиль</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link">
                    <i class="fas fa-route nav-icon"></i>
                    <span class="nav-text">Маршруты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/booking" class="nav-link">
                    <i class="fas fa-ticket-alt nav-icon"></i>
                    <span class="nav-text">Мои билеты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/reviews" class="nav-link">
                    <i class="fas fa-star nav-icon"></i>
                    <span class="nav-text">Отзывы</span>
                </a>
            </li>
            <li class="nav-item" style="margin-top: 30px;">
                <a href="javascript:void(0);" class="nav-link" onclick="logout()">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Выход</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Оплата билета</h2>
        </div>

        <div class="payment-container">
            <div class="ticket-summary">
                <h3 class="form-title">Детали билета</h3>
                <div id="ticketSummary">
                    <!-- Информация о билете будет загружена динамически -->
                </div>
            </div>

            <div class="payment-form">
                <h3 class="form-title">Платежные данные</h3>
                <form id="paymentForm">
                    <div class="form-group">
                        <label class="form-label">Номер карты</label>
                        <input type="text" class="form-input" id="cardNumber" 
                               placeholder="1234 5678 9012 3456" 
                               maxlength="19" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Имя держателя карты</label>
                        <input type="text" class="form-input" id="cardHolder" 
                               placeholder="IVAN IVANOV" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label">Срок действия</label>
                            <input type="text" class="form-input" id="expiryDate" 
                                   placeholder="MM/YY" maxlength="5" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">CVV</label>
                            <input type="text" class="form-input" id="cvv" 
                                   placeholder="123" maxlength="4" required>
                        </div>
                    </div>
                    <button type="submit" class="submit-btn" id="submitBtn">
                        <i class="fas fa-lock"></i> Оплатить
                    </button>
                </form>
                <div class="security-note">
                    <i class="fas fa-shield-alt"></i>
                    Ваши платежные данные защищены и не сохраняются на сервере
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>
<script>
    let routeData = null;
    let seatNumber = null;
    let carriageType = null;

    $(document).ready(function() {
        // Получаем данные из URL параметров
        const urlParams = new URLSearchParams(window.location.search);
        const routeId = urlParams.get('routeId');
        seatNumber = urlParams.get('seatNumber');
        carriageType = urlParams.get('carriageType') || 'Обычный';

        if (!routeId || !seatNumber) {
            alert('Не указаны параметры билета');
            window.location.href = '${pageContext.request.contextPath}/serviceUser';
            return;
        }

        // Загружаем информацию о маршруте
        loadRouteInfo(routeId);
        
        // Форматирование номера карты
        $('#cardNumber').on('input', function() {
            let value = $(this).val().replace(/\s/g, '');
            let formatted = value.match(/.{1,4}/g)?.join(' ') || value;
            $(this).val(formatted);
        });

        // Форматирование срока действия
        $('#expiryDate').on('input', function() {
            let value = $(this).val().replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            $(this).val(value);
        });

        // Только цифры для CVV
        $('#cvv').on('input', function() {
            $(this).val($(this).val().replace(/\D/g, ''));
        });

        // Обработка формы оплаты
        $('#paymentForm').on('submit', function(e) {
            e.preventDefault();
            processPayment();
        });
    });

    function loadRouteInfo(routeId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/routes/' + routeId,
            type: 'GET',
            dataType: 'json',
            success: function(route) {
                routeData = route;
                displayTicketSummary(route);
            },
            error: function(xhr, status, error) {
                alert('Ошибка при загрузке информации о маршруте');
                console.error(error);
            }
        });
    }

    function displayTicketSummary(route) {
        const departureCity = route.departureStation && route.departureStation.city ? route.departureStation.city : '';
        const departureStation = route.departureStation ? route.departureStation.name : 'Не указано';
        const arrivalCity = route.arrivalStation && route.arrivalStation.city ? route.arrivalStation.city : '';
        const arrivalStation = route.arrivalStation ? route.arrivalStation.name : 'Не указано';
        
        const departureDate = new Date(route.departureTime);
        const arrivalDate = new Date(route.arrivalTime);
        
        const departureDateStr = departureDate.toLocaleDateString('ru-RU', {
            day: '2-digit',
            month: 'long',
            year: 'numeric'
        });
        const departureTimeStr = departureDate.toLocaleTimeString('ru-RU', {
            hour: '2-digit',
            minute: '2-digit'
        });
        
        const arrivalDateStr = arrivalDate.toLocaleDateString('ru-RU', {
            day: '2-digit',
            month: 'long',
            year: 'numeric'
        });
        const arrivalTimeStr = arrivalDate.toLocaleTimeString('ru-RU', {
            hour: '2-digit',
            minute: '2-digit'
        });
        
        const trainNumber = route.train && route.train.trainNumber ? route.train.trainNumber : 
                           (route.train && route.train.id ? '№' + route.train.id : 'Не указан');
        const trainName = route.train && route.train.trainName ? route.train.trainName : '';
        const trainType = route.train && route.train.trainType ? route.train.trainType : '';
        const price = route.price || 0;

        const summaryHTML = `
            <div class="summary-item">
                <span class="summary-label">Поезд:</span>
                <span class="summary-value">${trainNumber}${trainName ? ' - ' + trainName : ''}${trainType ? ' (' + trainType + ')' : ''}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Отправление:</span>
                <span class="summary-value">${departureCity ? departureCity + ', ' : ''}${departureStation}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Дата и время отправления:</span>
                <span class="summary-value">${departureDateStr}, ${departureTimeStr}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Прибытие:</span>
                <span class="summary-value">${arrivalCity ? arrivalCity + ', ' : ''}${arrivalStation}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Дата и время прибытия:</span>
                <span class="summary-value">${arrivalDateStr}, ${arrivalTimeStr}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Место:</span>
                <span class="summary-value">${carriageType}, №${seatNumber}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">К оплате:</span>
                <span class="summary-value">${price} BYN</span>
            </div>
        `;

        $('#ticketSummary').html(summaryHTML);
    }

    function processPayment() {
        const cardNumber = $('#cardNumber').val().replace(/\s/g, '');
        const cardHolder = $('#cardHolder').val();
        const expiryDate = $('#expiryDate').val();
        const cvv = $('#cvv').val();

        if (!cardNumber || !cardHolder || !expiryDate || !cvv) {
            alert('Пожалуйста, заполните все поля');
            return;
        }

        const userId = getUserIdFromToken();
        if (!userId) {
            alert('Ошибка аутентификации. Пожалуйста, войдите снова.');
            window.location.href = '${pageContext.request.contextPath}/signin';
            return;
        }

        const paymentData = {
            cardNumber: cardNumber,
            cardHolder: cardHolder,
            expiryDate: expiryDate,
            cvv: cvv,
            ticketRequest: {
                userId: userId,
                routeId: routeData.id,
                seatNumber: parseInt(seatNumber),
                carriageType: carriageType
            }
        };

        $('#submitBtn').prop('disabled', true);
        $('#submitBtn').html('<i class="fas fa-spinner fa-spin"></i> Обработка...');

        $.ajax({
            url: '${pageContext.request.contextPath}/payment/process',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(paymentData),
            success: function(ticket) {
                // Скачиваем PDF автоматически
                const pdfUrl = '${pageContext.request.contextPath}/payment/ticket/' + ticket.id + '/pdf';
                const link = document.createElement('a');
                link.href = pdfUrl;
                link.download = 'ticket_' + ticket.pnrCode + '.pdf';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
                
                // Показываем сообщение об успехе
                setTimeout(function() {
                    alert('Оплата успешно завершена!\n\nPNR: ' + ticket.pnrCode + 
                          '\n\nБилет скачан. Вы также можете найти его в разделе "Мои билеты".');
                    // Перенаправляем на страницу с билетами
                    window.location.href = '${pageContext.request.contextPath}/booking';
                }, 500);
            },
            error: function(xhr, status, error) {
                let errorMsg = 'Ошибка при обработке оплаты';
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMsg += ': ' + xhr.responseJSON.message;
                } else if (xhr.responseText) {
                    errorMsg += ': ' + xhr.responseText;
                }
                alert(errorMsg);
                $('#submitBtn').prop('disabled', false);
                $('#submitBtn').html('<i class="fas fa-lock"></i> Оплатить');
            }
        });
    }

    function getUserIdFromToken() {
        try {
            const token = localStorage.getItem('jwtToken');
            if (!token) return null;
            const payload = jwt_decode(token);
            return payload.id || payload.userId;
        } catch (e) {
            return null;
        }
    }

    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>
