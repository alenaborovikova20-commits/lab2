section .data
    prompt_n    db  "Введитe количество чисел: ", 0
    prompt_num  db  "Введите число: ", 0
    result_msg  db  "Результат: ", 0
    newline     db  10, 0
    error_msg   db  "Ошибка ввода", 10, 0

section .bss
    n       resq    1       ; количество чисел
    counter resq    1       ; счётчик подходящих чисел
    buffer  resb    32      ; буфер для ввода строки
    sum     resq    1       ; сумма цифр

section .text
    global _start

_start:
    ; инициализируем счётчик нулём
    mov qword [counter], 0

    ; выводим приглашение для ввода количества чисел
    mov rsi, prompt_n
    call print_string

    ; читаем количество чисел
    call read_int
    mov [n], rax

    ; цикл для ввода n чисел
    mov rcx, 0              ; rcx = счётчик итераций

input_loop:
    cmp rcx, [n]            ; сравниваем с n
    jge print_result        ; если >= n, выходим на печать результата

    ; выводим приглашение для ввода числа
    push rcx                ; сохраняем rcx (счётчик цикла)
    mov rsi, prompt_num
    call print_string

    ; читаем строку (число как строка)
    call read_string

    ; считаем сумму цифр
    call calculate_sum

    ; проверяем, больше ли сумма 10
    cmp qword [sum], 10
    jle next_iteration      ; если сумма <= 10, пропускаем

    ; увеличиваем счётчик подходящих чисел
    inc qword [counter]

next_iteration:
    pop rcx                 ; восстанавливаем счётчик цикла
    inc rcx                 ; увеличиваем счётчик
    jmp input_loop

print_result:
    ; выводим строку "Результат: "
    mov rsi, result_msg
    call print_string

    ; выводим значение счётчика
    mov rax, [counter]
    call print_int

    ; выводим перевод строки
    mov rsi, newline
    call print_string

    ; завершаем программу
    mov rax, 60             ; sys_exit
    xor rdi, rdi            ; код возврата 0
    syscall

; ------------------------------------------------------------
; Функция: print_string
; Выводит строку на экран
; Вход: rsi - адрес строки (заканчивается нулём)
; ------------------------------------------------------------
print_string:
    push rax
    push rdi
    push rdx

    ; считаем длину строки
    mov rdx, 0
.count_len:
    cmp byte [rsi + rdx], 0
    je .print
    inc rdx
    jmp .count_len

.print:
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    syscall

    pop rdx
    pop rdi
    pop rax
    ret

; ------------------------------------------------------------
; Функция: read_string
; Читает строку с клавиатуры в buffer
; ------------------------------------------------------------
read_string:
    push rax
    push rdi
    push rdx

    mov rax, 0              ; sys_read
    mov rdi, 0              ; stdin
    mov rsi, buffer
    mov rdx, 32             ; максимальная длина
    syscall

    ; заменяем перевод строки на 0 (конец строки)
    dec rax                 ; последний символ - \n
    mov byte [buffer + rax], 0

    pop rdx
    pop rdi
    pop rax
    ret

; ------------------------------------------------------------
; Функция: read_int
; Читает целое число с клавиатуры
; Возврат: rax - число
; ------------------------------------------------------------
read_int:
    push rsi
    push rdx
    push rcx
    push rbx

    call read_string        ; читаем строку в buffer

    ; преобразуем строку в число
    mov rsi, buffer
    xor rax, rax            ; результат
    xor rbx, rbx            ; временный регистр
    mov rcx, 10             ; множитель для десятичной системы

.parse_loop:
    mov bl, [rsi]           ; берём следующий символ
    cmp bl, 0               ; конец строки?
    je .done
    cmp bl, 10              ; перевод строки?
    je .done
    cmp bl, '0'             ; проверяем что это цифра
    jb .error
    cmp bl, '9'
    ja .error

    sub bl, '0'             ; преобразуем ASCII в число (символ '5' -> 5)
    mul rcx                 ; rax = rax * 10
    add rax, rbx            ; добавляем новую цифру
    inc rsi                 ; следующий символ
    jmp .parse_loop

.done:
    pop rbx
    pop rcx
    pop rdx
    pop rsi
    ret

.error:
    mov rsi, error_msg
    call print_string
    mov rax, 60
    mov rdi, 1
    syscall

; ------------------------------------------------------------
; Функция: calculate_sum
; Считает сумму цифр строки в buffer
; Результат сохраняется в [sum]
; ------------------------------------------------------------
calculate_sum:
    push rax
    push rsi
    push rbx

    mov qword [sum], 0      ; обнуляем сумму
    mov rsi, buffer

.sum_loop:
    mov bl, [rsi]           ; берём символ
    cmp bl, 0               ; конец строки?
    je .done
    cmp bl, 10              ; перевод строки?
    je .done
    cmp bl, '0'             ; проверяем цифра ли это
    jb .skip                ; если нет - пропускаем
    cmp bl, '9'
    ja .skip

    sub bl, '0'             ; ASCII -> число
    add [sum], rbx          ; добавляем к сумме

.skip:
    inc rsi                 ; следующий символ
    jmp .sum_loop

.done:
    pop rbx
    pop rsi
    pop rax
    ret

; ------------------------------------------------------------
; Функция: print_int
; Выводит целое число из rax на экран
; ------------------------------------------------------------
print_int:
    push rax
    push rbx
    push rcx
    push rdx
    push rsi

    mov rcx, 0              ; счётчик цифр
    mov rbx, 10             ; делитель

    ; специальный случай для 0
    cmp rax, 0
    jne .convert
    push '0'
    inc rcx
    jmp .print

.convert:
    ; преобразуем число в ASCII цифры (в обратном порядке)
.divide:
    cmp rax, 0
    je .print
    xor rdx, rdx            ; очищаем rdx перед делением
    div rbx                 ; rax = rax / 10, rdx = rax % 10
    add rdx, '0'            ; преобразуем остаток в ASCII
    push rdx                ; сохраняем цифру в стеке
    inc rcx                 ; увеличиваем счётчик цифр
    jmp .divide

.print:
    ; выводим цифры из стека
.print_loop:
    cmp rcx, 0
    je .done
    pop rsi                 ; берём цифру из стека
    push rcx                ; сохраняем счётчик

    ; временно сохраняем символ и выводим
    push rsi
    mov rax, 1              ; sys_write
    mov rdi, 1              ; stdout
    mov rsi, rsp            ; адрес символа в стеке
    mov rdx, 1              ; длина 1 байт
    syscall
    pop rsi

    pop rcx
    dec rcx
    jmp .print_loop

.done:
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    ret
