uses crt;

const
  MAX_SIZE = 10;
type
  Deque = record
    data: array[0..MAX_SIZE-1] of Integer;
    front, rear: Integer;
  end;

procedure InitializeDeque(var dq: Deque);
begin
  dq.front := -1;
  dq.rear := -1;
end;

function IsFull(dq: Deque): Boolean;
begin
  IsFull := ((dq.front = 0) and (dq.rear = MAX_SIZE - 1)) or (dq.front = dq.rear + 1);
end;

function IsEmpty(dq: Deque): Boolean;
begin
  IsEmpty := dq.front = -1;
end;

procedure InsertFront(var dq: Deque; value: Integer);
begin
  if IsFull(dq) then
  begin
    WriteLn('Дек полон!');
    Exit;
  end;

  if dq.front = -1 then
  begin
    dq.front := 0;
    dq.rear := 0;
  end
  else if dq.front = 0 then
    dq.front := MAX_SIZE - 1
  else
    Dec(dq.front);

  dq.data[dq.front] := value;
end;

procedure InsertRear(var dq: Deque; value: Integer);
begin
  if IsFull(dq) then
  begin
    WriteLn('Дек полон!');
    Exit;
  end;

  if dq.front = -1 then
  begin
    dq.front := 0;
    dq.rear := 0;
  end
  else if dq.rear = MAX_SIZE - 1 then
    dq.rear := 0
  else
    Inc(dq.rear);

  dq.data[dq.rear] := value;
end;

procedure DeleteFront(var dq: Deque);
begin
  if IsEmpty(dq) then
  begin
    WriteLn('Дек пуст!');
    Exit;
  end;

  if dq.front = dq.rear then
  begin
    dq.front := -1;
    dq.rear := -1;
  end
  else if dq.front = MAX_SIZE - 1 then
    dq.front := 0
  else
    Inc(dq.front);
end;

procedure DeleteRear(var dq: Deque);
begin
  if IsEmpty(dq) then
  begin
    WriteLn('Дек пуст!');
    Exit;
  end;

  if dq.front = dq.rear then
  begin
    dq.front := -1;
    dq.rear := -1;
  end
  else if dq.rear = 0 then
    dq.rear := MAX_SIZE - 1
  else
    Dec(dq.rear);
end;

procedure DisplayDeque(dq: Deque);
var
  i: Integer;
begin
  if IsEmpty(dq) then
  begin
    WriteLn('Дек пуст!');
    Exit;
  end;

  Write('Элементы дека: ');
  i := dq.front;
  while True do
  begin
    Write(dq.data[i], ' ');
    if i = dq.rear then Break;
    i := (i + 1) mod MAX_SIZE;
  end;
  WriteLn;
end;

var
  dq: Deque;
  choice, value: Integer;
  ch: Char;
begin
  InitializeDeque(dq);
  repeat
    ClrScr; // Очистка экрана
    WriteLn('1. Добавить в начало');
    WriteLn('2. Добавить в конец');
    WriteLn('3. Удалить с начала');
    WriteLn('4. Удалить с конца');
    WriteLn('5. Визуализация');
    WriteLn('6. Выход');
    Write('Выберите действие (1-6): ');

    ch := ReadKey; // Считываем нажатую клавишу
    case ch of
      '1': begin
             Write('Введите значение для добавления в начало: ');
             ReadLn(value);
             InsertFront(dq, value);
           end;
      '2': begin
             Write('Введите значение для добавления в конец: ');
             ReadLn(value);
             InsertRear(dq, value);
           end;
      '3': DeleteFront(dq);
      '4': DeleteRear(dq);
      '5': DisplayDeque(dq);
      '6': begin
             WriteLn('Выход...');
             Break;
           end;
      else WriteLn('Неверный выбор! Нажмите клавишу от 1 до 6.');
    end;
    WriteLn('Нажмите любую клавишу для продолжения...');
    ReadKey; // Ожидание нажатия любой клавиши
  until False;
end.