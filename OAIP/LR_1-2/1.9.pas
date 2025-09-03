program z;
var
  a: string;
  b, c, d: integer;
  z: real;
begin
  writeln('Введите фамилию');
  readln(a);
  writeln('Количество занятий по предмету');
  readln(b);
  writeln('Количество пропусков');
  readln(c);
  d:=b-c;
  z:=(d/b)*100;
  writeln('Процент посещаемости ',z, '%');
end.