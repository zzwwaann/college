type t_chs = set of Char;
const
  lett: t_chs = ['a'..'z','A'..'Z','_'];
  num: t_chs = ['0'..'9'];
var
  str: string;
  i: byte;
  flag: boolean;
begin
  flag := True;
  writeln('Введите строку');
  readln(str);
  if str[1] not in lett then
    flag:=False;
  for i := 2 to length(str) do
  begin
    if str[i] not in lett + num then
      flag:=False;
  end;
  if flag then
    writeln('Слово написано корректно')
  else
    writeln('Слово написано некорректно')
end.