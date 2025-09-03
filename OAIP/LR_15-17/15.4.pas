type toys = record
  name:string[20];
  price:integer;
  age: 0..16;
end;
var arr: array[1..3] of toys;
toy: toys;
i:integer;
f: file of toys;
begin
  assign(f, 'C:\Users\LenNout\Desktop\15_4');
  rewrite(f);
  for i:=1 to 3 do
  begin
    with arr[i] do
    begin
      writeln('наименование');
      readln(name);
      writeln('цена');
      readln(price);
      writeln('возраст');
      readln(age);
    end;
    write(f,arr[i]);
  end;
  close(f);
  assign(f, 'C:\Users\LenNout\Desktop\15_4');
  reset(f);
  for i:=1 to 3 do
  begin
    read(f, toy);
    writeln(toy.name,'   ', toy.price,'   ',toy.age)
  end;
  close(f)
end.