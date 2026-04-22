import Foundation  // Импорт базового фреймворка

func calculate(_ line: String) -> Int { 
    let dict: [Character: Int] = [
        "I": 1,
        "V": 5,
        "X": 10,
        "L": 50,
        "C": 100,
        "D": 500,
        "M": 1000
    ]
    
    for item in line {
        // uppercased() в верхний регистр
        // Character() создаёт символ из строки
        let upperItem = Character(item.uppercased())
        // nil если нет ключа
        if dict[upperItem] == nil {
            print("Такого числа не существует, попробуйте еще раз:")
            return -1
        }
    }
    
    // Array() преобразует строку в массив символов
    let chars = Array(line)
    // last! последний элемент 
    var result = dict[Character(chars.last!.uppercased())]!
    
    
    for i in stride(from: chars.count - 1, to: 0, by: -1) {
        let current = dict[Character(chars[i].uppercased())]!
        let previous = dict[Character(chars[i - 1].uppercased())]!
        
        if current <= previous {
            result += previous
        } else {
            result -= previous
        }
    }
    return result
}

print("Введите строку: ")
// ?? "" если nil, использовать пустую строку
var line = readLine() ?? ""
var res = calculate(line)

while res == -1 {
    line = readLine() ?? ""
    res = calculate(line)
}
print(res)