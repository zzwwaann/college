type anketa = record
  fio: string;
  birth: string;
  kurs: 1..5;
end;
var student: anketa;
name:string;
begin
  student.fio:= 'ChetverikovDenisAlbertovich';
  student.birth:='04/05/2007';
  student.kurs:=2;
  writeln(student.fio,'  ',student.birth,'  ',student.kurs);
end.