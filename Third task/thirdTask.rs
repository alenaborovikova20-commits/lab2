use std::io;

fn filter(num: &str) -> bool {
    let mut sum = 0;
    for k in num.chars() {
        // to_digit(10) - преобразует символ в цифру, возвращает Option
        // unwrap() - извлекаем значение
        let k = k.to_digit(10).unwrap() as i32;  // as i32 - приводим тип
        sum += k;
    }
    if sum > 10 { true } else { false }
}

fn main() {
    println!("Введитe количество чисел");
    let mut n_input = String::new();
    io::stdin().read_line(&mut n_input).expect("Ошибка чтения");
    let n: i32 = n_input.trim().parse().expect("Ошибка парсинга");
    let mut counter = 0;

    
    for _ in 0..n {
        println!("Введите число: ");
        let mut num = String::new();
        io::stdin().read_line(&mut num).expect("Ошибка чтения");
        let num = num.trim();

        if filter(num) {
            counter += 1;
        }
    }
    println!("Результат: {}", counter);
}