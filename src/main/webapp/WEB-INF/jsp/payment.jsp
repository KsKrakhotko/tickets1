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
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .page-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--charcoal);
            margin-bottom: 10px;
        }

        .payment-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 30px;
        }

        .ticket-summary {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            border-top: 4px solid var(--purple);
        }

        .ticket-summary h2 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 20px;
            font-size: 1.5rem;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid rgba(0,0,0,0.1);
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

        .payment-form {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            border-top: 4px solid var(--purple);
        }

        .payment-form h2 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 20px;
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

        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s;
            font-family: 'Montserrat', sans-serif;
        }

        .form-control:focus {
            border-color: var(--purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .btn {
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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }

        .btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .btn:disabled {
            background: var(--slate);
            cursor: not-allowed;
            transform: none;
        }

        .btn-back {
            background: var(--slate);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            font-family: 'Montserrat', sans-serif;
        }

        .btn-back:hover {
            background: var(--charcoal);
            transform: translateX(-3px);
        }

        .error-message {
            color: var(--danger);
            font-size: 14px;
            margin-top: 5px;
            display: none;
        }

        .loading {
            display: none;
            text-align: center;
            padding: 20px;
        }

        .loading i {
            font-size: 2rem;
            color: var(--purple);
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .payment-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="page-header">
        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px;">
            <button onclick="goBack()" class="btn-back" style="background: var(--slate); color: white; padding: 10px 20px; border: none; border-radius: 8px; cursor: pointer; font-size: 14px; display: flex; align-items: center; gap: 8px;">
                <i class="fas fa-arrow-left"></i> Назад
            </button>
            <h1 style="flex: 1; text-align: center; margin: 0;"><i class="fas fa-credit-card" style="color: var(--purple);"></i> Оплата билета</h1>
            <div style="width: 100px;"></div> <!-- Для центрирования заголовка -->
        </div>
        <p style="color: var(--slate);">Введите данные карты для завершения покупки</p>
    </div>

    <div class="payment-container">
        <div class="ticket-summary">
            <h2><i class="fas fa-ticket-alt" style="color: var(--purple); margin-right: 10px;"></i>Информация о билете</h2>
            <div id="ticketSummary">
                <div class="summary-item">
                    <span class="summary-label">Маршрут:</span>
                    <span class="summary-value" id="routeInfo">Загрузка...</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Место:</span>
                    <span class="summary-value" id="seatInfo">-</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Тип вагона:</span>
                    <span class="summary-value" id="carriageInfo">Стандарт</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Цена:</span>
                    <span class="summary-value" id="priceInfo">-</span>
                </div>
            </div>
        </div>

        <div class="payment-form">
            <h2><i class="fas fa-lock" style="color: var(--purple); margin-right: 10px;"></i>Данные карты</h2>
            <form id="paymentForm">
                <div class="form-group">
                    <label class="form-label">Номер карты</label>
                    <input type="text" id="cardNumber" class="form-control" 
                           placeholder="1234 5678 9012 3456" maxlength="19" required>
                    <div class="error-message" id="cardNumberError"></div>
                </div>

                <div class="form-group">
                    <label class="form-label">Имя держателя карты</label>
                    <input type="text" id="cardHolder" class="form-control" 
                           placeholder="IVAN IVANOV" required>
                    <div class="error-message" id="cardHolderError"></div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Срок действия</label>
                        <input type="text" id="expiryDate" class="form-control" 
                               placeholder="MM/YY" maxlength="5" required>
                        <div class="error-message" id="expiryDateError"></div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">CVV</label>
                        <input type="text" id="cvv" class="form-control" 
                               placeholder="123" maxlength="3" required>
                        <div class="error-message" id="cvvError"></div>
                    </div>
                </div>

                <div class="loading" id="loading">
                    <i class="fas fa-spinner"></i>
                    <p>Обработка платежа...</p>
                </div>

                <button type="submit" class="btn" id="payButton">
                    <i class="fas fa-check"></i> Оплатить
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Получаем параметры из URL
        const urlParams = new URLSearchParams(window.location.search);
        const routeId = urlParams.get('routeId');
        const seatNumber = urlParams.get('seatNumber');
        const userId = urlParams.get('userId');

        if (!routeId || !seatNumber || !userId) {
            alert('Ошибка: отсутствуют необходимые параметры');
            window.location.href = '/home';
            return;
        }

        // Загружаем информацию о маршруте
        loadRouteInfo(routeId, seatNumber);

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

        // Обработка отправки формы
        $('#paymentForm').submit(function(e) {
            e.preventDefault();

            if (!validateForm()) {
                return;
            }

            // Показываем загрузку
            $('#loading').show();
            $('#payButton').prop('disabled', true);

            const paymentData = {
                userId: parseInt(userId),
                routeId: parseInt(routeId),
                seatNumber: parseInt(seatNumber),
                carriageType: 'Стандарт',
                cardNumber: $('#cardNumber').val().replace(/\s/g, ''),
                cardHolder: $('#cardHolder').val(),
                expiryDate: $('#expiryDate').val(),
                cvv: $('#cvv').val()
            };

            // Отправляем запрос на оплату
            $.ajax({
                url: '/api/payment/process',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(paymentData),
                xhrFields: {
                    responseType: 'blob'
                },
                success: function(data, status, xhr) {
                    // Создаем ссылку для скачивания PDF
                    const blob = new Blob([data], { type: 'application/pdf' });
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = 'ticket.pdf';
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);
                    document.body.removeChild(a);

                    // Проверяем статус отправки email из заголовков
                    const emailStatus = xhr.getResponseHeader('X-Email-Status');
                    let message = 'Оплата успешно завершена! Билет скачан.';
                    
                    if (emailStatus === 'sent') {
                        const emailAddress = xhr.getResponseHeader('X-Email-Address');
                        message += '\n\nБилет также отправлен на вашу электронную почту: ' + emailAddress;
                    } else if (emailStatus === 'failed') {
                        const emailError = xhr.getResponseHeader('X-Email-Error');
                        message += '\n\nВНИМАНИЕ: Не удалось отправить билет на email. ' + 
                                  (emailError || 'Проверьте настройки почтового сервера.');
                    } else if (emailStatus === 'skipped') {
                        message += '\n\nБилет не был отправлен на email (email не указан в профиле).';
                    }
                    
                    alert(message);
                    window.location.href = '/booking';
                },
                error: function(xhr, status, error) {
                    $('#loading').hide();
                    $('#payButton').prop('disabled', false);
                    
                    let errorMsg = 'Ошибка при обработке платежа';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg += ': ' + xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        try {
                            const error = JSON.parse(xhr.responseText);
                            errorMsg += ': ' + error.message;
                        } catch (e) {
                            errorMsg += '. Попробуйте еще раз.';
                        }
                    }
                    alert(errorMsg);
                }
            });
        });
    });

    function loadRouteInfo(routeId, seatNumber) {
        $.ajax({
            url: '/routes/' + routeId,
            type: 'GET',
            dataType: 'json',
            success: function(route) {
                const departure = route.departureStation ? route.departureStation.name : 'Н/Д';
                const arrival = route.arrivalStation ? route.arrivalStation.name : 'Н/Д';
                const trainNumber = route.train ? route.train.trainNumber : 'Н/Д';
                
                const departureDate = new Date(route.departureTime);
                const formattedDate = departureDate.toLocaleDateString('ru-RU', {
                    day: '2-digit',
                    month: '2-digit',
                    year: 'numeric'
                });
                const formattedTime = departureDate.toLocaleTimeString('ru-RU', {
                    hour: '2-digit',
                    minute: '2-digit'
                });

                $('#routeInfo').text(departure + ' → ' + arrival + ' (Поезд №' + trainNumber + ')');
                $('#seatInfo').text('Место №' + seatNumber);
                $('#priceInfo').text((route.price || 0) + ' BYN');
            },
            error: function() {
                $('#routeInfo').text('Ошибка загрузки данных');
            }
        });
    }

    function goBack() {
        if (confirm('Вы уверены, что хотите вернуться? Данные формы будут потеряны.')) {
            window.history.back();
        }
    }

    function validateForm() {
        let isValid = true;

        // Валидация номера карты
        const cardNumber = $('#cardNumber').val().replace(/\s/g, '');
        if (cardNumber.length < 13 || cardNumber.length > 19 || !/^\d+$/.test(cardNumber)) {
            $('#cardNumberError').text('Неверный формат номера карты').show();
            isValid = false;
        } else {
            $('#cardNumberError').hide();
        }

        // Валидация имени держателя
        if ($('#cardHolder').val().trim().length < 3) {
            $('#cardHolderError').text('Имя держателя должно содержать минимум 3 символа').show();
            isValid = false;
        } else {
            $('#cardHolderError').hide();
        }

        // Валидация срока действия
        const expiryDate = $('#expiryDate').val();
        if (!/^\d{2}\/\d{2}$/.test(expiryDate)) {
            $('#expiryDateError').text('Неверный формат (MM/YY)').show();
            isValid = false;
        } else {
            $('#expiryDateError').hide();
        }

        // Валидация CVV
        const cvv = $('#cvv').val();
        if (cvv.length !== 3 || !/^\d+$/.test(cvv)) {
            $('#cvvError').text('CVV должен содержать 3 цифры').show();
            isValid = false;
        } else {
            $('#cvvError').hide();
        }

        return isValid;
    }
</script>
</body>
</html>

