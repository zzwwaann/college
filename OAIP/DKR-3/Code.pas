uses crt;
function f(x: Real): Real;
begin
    f := 2 * x ** 3 + (-1) * x ** 2 + (-1) * x + (16);
end;
function RRI(a, b: Real; n: Integer): Real;
var
  h, x, sum: real;
  i: integer;
begin
  h := (b - a) / n;
  sum := 0;
  x := a + h;  
  for i := 1 to n do
  begin
    sum := sum + f(x);
    x := x + h;
  end;  
  RRI := h * sum;
end;
function errest(a, b: Real; n: Integer): Real;
var
    sdmax, x, err: Real;
    i: Integer;
begin
    for i := 0 to n do
    begin
        x := a + i * (b - a) / n;
        if (6 * x + 4) > sdmax then // первообразная 2-ого порядка от начальной функции
            sdmax := 6 * x + 4;
    end;
    err := (b - a) ** 5 / (180 * n ** 4) * sdmax; // Формула для вычисления погрешности
    errest := err;
end;
var
    a, b: Real;
    n: Integer;
    choice: Char;
    area, error: Real;
begin
    repeat
        writeln('Меню:');
        writeln('1. Вычислить площадь фигуры');
        writeln('2. Выход');
        write('Выберите опцию: ');
        readln(choice);
        case choice of '1':
            begin              
                ClrScr;
                write('Введите нижний предел интегрирования (a): ');
                readln(a);
                write('Введите верхний предел интегрирования (b): ');
                readln(b);
                write('Введите количество подынтервалов: ');
                readln(n);
                area := RRI(a, b, n);
                error := errest(a, b, n);
                writeln('Площадь фигуры: ', area:0:6);
                writeln('Оценка погрешности: ', error:0:6);
            end;
            '2':
                writeln('Выход из программы.');
            else
                writeln('Неверный выбор. Попробуйте снова.');
        end;
    until choice = '2';
end.
