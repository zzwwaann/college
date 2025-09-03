type toys = record
  name:string;
  price:integer;
  age: 0..16;
end;
var toy: array[1..3] of toys;
i:integer;
begin
  for i:=1 to 3 do
  begin
    with toy[i] do
    begin
      writeln('наименование');
      readln(name);
      writeln('цена');
      readln(price);
      writeln('возраст');
      readln(age)
    end;
  end;
  for i:=1 to 3 do
  begin
    with toy[i] do
    begin
      writeln(name,'   ', price,'   ',age)
    end;
  end;
end.