var 
n,i:integer;
sum:real;
numbers:array[1..10] of integer;
begin
  for i:=1 to 10 do
  begin
   writeln('Введите ', i,'-ый элемент массива');
   readln(n);
   numbers[i]:=n;
  end;
  sum:=0;
  for i:=1 to 10 do
    sum:=sum+numbers[i];
  sum:=sum/10;
  writeln(sum);
  end.