type anketa = record
  fio: string;
  birth: string;
  kurs: 1..5;
end;
var students: array[1..100] of anketa;
i: integer;
begin
  students[1].fio:= 'Четвериков Денис Альбертович';
  students[2].fio:= 'Ратушный Кирилл Александрович';
  students[3].fio:= 'Иванов Иван Иванович';
  students[1].birth:='04/05/2007';
  students[2].birth:='22/07/2007';
  students[3].birth:='12/12/2008';
  students[1].kurs:=2;
  students[2].kurs:=2;
  students[3].kurs:=1;
  for i:=1 to 3 do
  begin
    writeln(students[i].fio, '  ',students[i].birth, '  ',students[i].kurs)
  end;
end.