use std::collections::HashMap;  // Импорт хеш-таблицы
use std::io;

fn calculate(line: &str) -> i32 {  // Принимаем ссылку на строку
    // Создаём словарь римских цифр
    let mut dict: HashMap<char, i32> = HashMap::new();
    dict.insert('I', 1);
    dict.insert('V', 5);
    dict.insert('X', 10);
    dict.insert('L', 50);
    dict.insert('C', 100);
    dict.insert('D', 500);
    dict.insert('M', 1000);


    for item in line.chars() {
        // contains_key - проверяет наличие ключа в словаре
        // to_ascii_uppercase - в верхний регистр
        if !dict.contains_key(&item.to_ascii_uppercase()) {
            println!("Такого числа не существует, попробуйте еще раз:");
            return -1;  
        }
    }

    let chars: Vec<char> = line.chars().collect();
    let mut result = *dict.get(&chars[chars.len() - 1].to_ascii_uppercase()).unwrap();

    // rev() - в обратном порядке от len-1 до 1
    for i in (1..chars.len()).rev() {
        if dict.get(&chars[i].to_ascii_uppercase()).unwrap() <= 
           dict.get(&chars[i - 1].to_ascii_uppercase()).unwrap() {
            result += dict.get(&chars[i - 1].to_ascii_uppercase()).unwrap();
        } else {
            result -= dict.get(&chars[i - 1].to_ascii_uppercase()).unwrap();
        }
    }
    result  // Возврат значения 
}

fn main() {
    let mut line = String::new();
    println!("Введите строку: ");
    io::stdin().read_line(&mut line).expect("Ошибка чтения");
    let mut line = line.trim().to_string();

    let mut res = calculate(&line);
    while res == -1 {
        line.clear();  // Очищаем строку
        io::stdin().read_line(&mut line).expect("Ошибка чтения");
        line = line.trim().to_string();
        res = calculate(&line);
    }
    println!("{}", res);
}