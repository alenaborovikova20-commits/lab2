defmodule Main do
  def filter(num) do
    sum = num
          |> String.graphemes()        # Разбиваем строку на отдельные символы
          |> Enum.map(&String.to_integer/1)  # Преобразуем каждый символ в число
          |> Enum.sum()                # Суммируем все цифры
    
    sum > 10  # Возвращаем true если сумма > 10
  end



  def main do
    # Заданный массив чисел 
    numbers = ["124", "9829", "9872", "2", "456"]
    
    # Счётчик подходящих чисел
    counter = Enum.count(numbers, &filter/1)
    
    # Вывод результатов
    IO.puts("Массив: #{Enum.join(numbers, ", ")}")
    IO.puts("Результат: #{counter}")  
  end
end

Main.main()