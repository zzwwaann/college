procedure CountingSort(var data: array of Integer; count: Integer; comparator: function(a, b: Integer): Integer);
var
  i, j, Range, MinValue, MaxValue: Integer;
  CountArray: array of Integer;
begin
  if count = 0 then Exit;
  MinValue := data[0];
  MaxValue := data[0];
  // Находим минимальное и максимальное значение
  for i := 1 to count - 1 do
  begin
    if data[i] < MinValue then MinValue := data[i];
    if data[i] > MaxValue then MaxValue := data[i];
  end;
  Range := MaxValue - MinValue + 1;
  SetLength(CountArray, Range);
  // Инициализация массива подсчета
  for i := 0 to High(CountArray) do
    CountArray[i] := 0;
  // Подсчет количества вхождений каждого элемента
  for i := 0 to count - 1 do
    Inc(CountArray[data[i] - MinValue]);
  // Заполнение исходного массива отсортированными элементами
  j := 0;
  for i := 0 to High(CountArray) do
    while CountArray[i] > 0 do
    begin
      data[j] := i + MinValue;
      Inc(j);
      Dec(CountArray[i]);
    end;
end;
procedure Heapify(var data: array of Integer; n, i: Integer; comparator: function(a, b: Integer): Integer);
var
  largest, left, right: Integer;
begin
  largest := i;
  left := 2 * i + 1;
  right := 2 * i + 2;
  if (left < n) and (comparator(data[left], data[largest]) > 0) then
    largest := left;
  if (right < n) and (comparator(data[right], data[largest]) > 0) then
    largest := right;
  if largest <> i then
  begin
    Swap(data[i], data[largest]);
    Heapify(data, n, largest, comparator);
  end;
end;
procedure HeapSort(var data: array of Integer; count: Integer; comparator: function(a, b: Integer): Integer);
var
  i: Integer;
begin
  for i := count div 2 - 1 downto 0 do
    Heapify(data, count, i, comparator);
  for i := count - 1 downto 1 do
  begin
    Swap(data[0], data[i]);
    Heapify(data, i, 0, comparator);
  end;
end;
function CompareAscending(a, b: Integer): Integer;
begin
  Result := a - b;
end;
procedure ReadDataFromFile(const filename: string; var data: array of Integer; var count: Integer);
var
  f: TextFile;
begin
  AssignFile(f, filename);
  Reset(f); 
  count := 0;
  while not Eof(f) do
  begin
    Read(f, data[count]);
    Inc(count);
    SetLength(data, count + 1); // Увеличиваем размер массива для следующего числа.
  end;
  CloseFile(f);
end;
procedure WriteDataToFile(const filename: string; const data: array of Integer; count: Integer);
var
  f: TextFile;
begin
  AssignFile(f, filename);
  Rewrite(f);
  for var i := 0 to count - 1 do
    WriteLn(f, data[i]);
  CloseFile(f);
end;
var
  inputData: array of Integer; 
  countingData: array of Integer; 
  heapData: array of Integer; 
  count, i, time1, time2, time3, time4, countingTime, heapTime: Integer;
begin
  SetLength(inputData, 1000); 
  ReadDataFromFile('C:\Users\LenNout\Desktop\ОАиП\ДКР-5\text\5.txt', inputData, count);
   // Сортировка подсчетом
   time1 := Milliseconds;
   SetLength(countingData, count); // Устанавливаем размер для сортировки подсчетом.
   for i := 0 to count - 1 do
     countingData[i] := inputData[i];
   CountingSort(countingData, count, CompareAscending);
   WriteDataToFile('C:\Users\LenNout\Desktop\ОАиП\ДКР-5\text\5_1.txt', countingData, count); 
   time2 := Milliseconds;
   // Пирамидальная сортировка (Heap Sort)
   time3 := Milliseconds;
   SetLength(heapData, count); // Устанавливаем размер для пирамидальной сортировки.
   for i := 0 to count - 1 do
     heapData[i] := inputData[i];
   HeapSort(heapData, count, CompareAscending);
   time4 := Milliseconds; 
   WriteDataToFile('C:\Users\LenNout\Desktop\ОАиП\ДКР-5\text\5_2.txt', heapData, count);
   countingTime := time2 - time1; 
   heapTime := time4 - time3;
   WriteLn('Для сортировки данных методом подсчета потребовалось: ', countingTime, ' миллисекунд. А для пирамидальной сортировки: ', heapTime, '.');
   WriteLn('Результат можно посмотреть в соответствующих файлах.');
end.