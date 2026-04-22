str_input = input("Введите строку: ")
k = int(input("Введите количество единиц: "))

max_len = 0    # Максимальная длина
counter = 0    # Счётчик нулей
j = 0          # Левая граница интервала


for i in range(len(str_input)):
    if str_input[i] == '0':  
        counter += 1         
    
    
    while counter > k:
        if str_input[j] == '0':  
            counter -= 1         
        j += 1  # Сдвигаем левую границу
    
    # Обновляем максимум если текущий инетрвал длиннее
    if max_len < i - j + 1:
        max_len = i - j + 1  
print(max_len)  