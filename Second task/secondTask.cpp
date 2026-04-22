#include <iostream>
#include <map>

using namespace std;


int calculate(string line){
    map<char, int> dict = {
        {'I', 1}, {'V', 5}, {'X', 10}, 
        {'L', 50}, {'C', 100}, {'D', 500}, {'M', 1000}
    };

    // Проверяем, все ли символы допустимы
    for (char item : line){
        if (dict.find(toupper(item)) == dict.end()){
            cout << "Такого числа не существует, попробуйте еще раз:" << endl;
            return -1; 
        }
    }

    // Начинаем с последней цифры
    int result = dict.at(toupper(line[line.size() - 1]));

    // Идём справа налево 
    for (size_t i = line.size() - 1; i > 0; --i){
        if (dict.at(toupper(line[i])) <= dict.at(toupper(line[i-1]))){
            result += dict.at(toupper(line[i-1]));  // Прибавляем
        } else {
            result -= dict.at(toupper(line[i-1]));  // Вычитаем
        }
    }
    return result; 
}

int main(){
    string line;
    cout << "Введите строку: " << endl;
    cin >> line;
    int res = calculate(line);
    // Если ввели некорректное число, просим ввести заново
    while (res == -1){
        cin >> line;
        res = calculate(line);
    }
    cout << res << endl;
}