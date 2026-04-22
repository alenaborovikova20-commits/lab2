// Импортируем модуль readline для ввода с консоли
const readline = require('readline');

// Создание интерфейса для чтения из stdin и записи в stdout
const rl = readline.createInterface({
    input: process.stdin,   
    output: process.stdout  
});


rl.question('Введите строку: ', (str) => {  
    rl.question('Введите количество единиц: ', (kInput) => {
        const k = parseInt(kInput);  // Парсим строку в целое число
        
        let max_len = 0;    // Максимальная длина
        let counter = 0;    // Счётчик нулей
        let j = 0;          // Левая граница
        
        // i - правая граница интервала
        for (let i = 0; i < str.length; i++) {
            if (str[i] === '0') {  
                counter++;         
            }
            while (counter > k) {  
                if (str[j] === '0') {
                    counter--;     
                }
                j++;  // Сдвигаем левую границу
            }
            // Обновляем максимум
            if (max_len < i - j + 1) {
                max_len = i - j + 1;
            }
        }
        console.log(max_len);  // Вывод результата
        rl.close();  // Закрываем интерфейс
    });
});