use std::io;  

fn main() {
    let mut str = String::new();  // Создаём пустую строку
    println!("Введите строку: ");
    io::stdin().read_line(&mut str).expect("Ошибка чтения");  // Читаем ввод
    let str = str.trim().to_string();  // Убираем пробелы и перевод строки

    let mut k_input = String::new();
    println!("Введите количество единиц: ");
    io::stdin().read_line(&mut k_input).expect("Ошибка чтения");
    let k: usize = k_input.trim().parse().expect("Ошибка парсинга");  // Парсим в число

    let mut max_len = 0;      // Максимальная длина
    let mut counter = 0;      // Счётчик нулей
    let mut j = 0;            // Левая граница окна

    let chars: Vec<char> = str.chars().collect();  // Строку в вектор символов

    for i in 0..chars.len() {  // i - правая граница интервала
        if chars[i] == '0' {    
            counter += 1;      
        }
        // Пока нулей больше допустимого
        while counter > k {
            if chars[j] == '0' { 
                counter -= 1; 
            }
            j += 1;  // Сдвигаем левую границу
        }
        // Обновляем максимум
        if max_len < i - j + 1 {
            max_len = i - j + 1;
        }
    }
    println!("{}", max_len);  // Вывод результата
}