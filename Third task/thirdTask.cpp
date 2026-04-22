#include <iostream>
using namespace std;


bool filter(string num){
    int sum = 0;
    for(char k : num){
        k = k - '0';  // Преобразование символа '5' в число 5
        sum += k;   
    }
    return (sum > 10) ? true : false;  // Тернарный оператор
}

int main(){
    cout << "Введитe количество чисел" << endl;
    int n, counter = 0;  // n сколько чисел; counter счётчик подходящих
    cin >> n;
    
    for (int i = 0; i < n; i++){
        cout << "Введите число: " << endl;
        string num;
        cin >> num;

        if (filter(num)){  // Если сумма цифр > 10
            counter++;     // Увеличиваем счётчик
        }
    }
    cout << "Результат: " << counter << endl;
    return 0;
}
