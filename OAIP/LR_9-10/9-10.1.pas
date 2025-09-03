const
    MaxSize = 100;
type
    TArray = array[1..MaxSize] of Integer;
var
    arr1, arr2: TArray;    //глобальные переменные
    size1, size2: Integer; // 
procedure InputArray(var arr: TArray; var size: Integer);//формальные параметры, передача по параметру
var
    i: Integer; //локальные переменные
begin
    write('Введите количество элементов массива: ');
    readln(size);
    for i := 1 to size do
    begin
        write('Введите элемент ', i, ': ');
        readln(arr[i]);
    end;
end;
procedure ReplaceMaxWithZero(var arr: TArray; size: Integer);//формальные параметры, передача по параметру
var
    maxIndex, i: Integer;         //
    foundMultipleOfFive: Boolean; //локальные переменные
begin
    maxIndex := 0;
    foundMultipleOfFive := False;
    for i := 1 to size do
    begin
        if (arr[i] mod 5 = 0) and (not foundMultipleOfFive) then
        begin
            foundMultipleOfFive := True;
        end;
        if (maxIndex = 0) or (arr[maxIndex] < arr[i]) then
            maxIndex := i;
    end;
    if foundMultipleOfFive then
    begin
        arr[maxIndex] := 0;
    end;
end;
procedure MultiplyAfterMin(var arr: TArray; size: Integer); //формальные параметры, передача по параметру
var
    minIndex, i: Integer; //локальные переменные
begin
    minIndex := 1;
    for i := 2 to size do
    begin
        if arr[i] < arr[minIndex] then
            minIndex := i;
    end;
    for i := minIndex + 1 to size do
    begin
        arr[i] := arr[i] * 2;
    end;
end;
procedure PrintArray(arr: TArray; size: Integer); //формальные параметры, передача по параметру
var
    i: Integer; //локальные переменные
begin
    write('Элементы массива: ');
    for i := 1 to size do
    begin
        write(arr[i], ' ');
    end;
    writeln;
end;
begin
    InputArray(arr1, size1);
    InputArray(arr2, size2);
    ReplaceMaxWithZero(arr1, size1);
    MultiplyAfterMin(arr2, size2);
    PrintArray(arr1, size1);
    PrintArray(arr2, size2);

    readln;
end.
