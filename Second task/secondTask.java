import java.util.HashMap;  // Импорт класса HashMap
import java.util.Map;      // Импорт интерфейса Map
import java.util.Scanner;  // Импорт класса Scanner для ввода

public class Main {
    public static int calculate(String line) {
        // Создаём словарь через HashMap
        Map<Character, Integer> dict = new HashMap<>();
        dict.put('I', 1);   
        dict.put('V', 5);
        dict.put('X', 10);
        dict.put('L', 50);
        dict.put('C', 100);
        dict.put('D', 500);
        dict.put('M', 1000);
        // toCharArray() преобразует строку в массив символов
        for (char item : line.toCharArray()) {
            // Character.toUpperCase() в верхний регистр
            // containsKey() - проверяет наличие ключа
            if (!dict.containsKey(Character.toUpperCase(item))) {
                System.out.println("Такого числа не существует, попробуйте еще раз:");
                return -1;  // Код ошибки
            }
        }
        
        int result = dict.get(Character.toUpperCase(line.charAt(line.length() - 1)));
        
        for (int i = line.length() - 1; i > 0; i--) {
            if (dict.get(Character.toUpperCase(line.charAt(i))) <= 
                dict.get(Character.toUpperCase(line.charAt(i - 1)))) {
                result += dict.get(Character.toUpperCase(line.charAt(i - 1)));
            } else {
                result -= dict.get(Character.toUpperCase(line.charAt(i - 1)));
            }
        }
        return result;
    }
    

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);  // Создаём сканер для ввода
        System.out.println("Введите строку: ");
        String line = scanner.next();  // Читаем слово
        int res = calculate(line);
        
        while (res == -1) {
            line = scanner.next();
            res = calculate(line);
        }
        System.out.println(res);
        scanner.close();  // Закрываем сканер
    }
}