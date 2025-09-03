var 
n,i,z,x:integer;
numbers:array[1..20] of integer;
begin
  for i:=1 to 20 do
  begin
   writeln('Введите ', i,'-ый элемент массива');
   readln(n);
   numbers[i]:=n;
  end;
  for z:=1 to 20 do
  begin
    if numbers[z]>0 then
     numbers[z]:=0
    else
    numbers[z]:=numbers[z]*numbers[z];
  end;
  writeln('Конечный массив');
  for x:=1 to 20 do
    write(numbers[x],' ');
end.