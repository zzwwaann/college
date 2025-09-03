var
  year: Integer;
  ending: String;
begin
  Write('Введите число: ');
  ReadLn(year);
  if (year mod 100 = 11) or (year mod 100 = 12) or (year mod 100 = 13) or (year mod 100 = 14) then
    ending := 'лет'
  else if (year mod 10 = 1) then
    ending := 'год'
  else if (year mod 10 in [2, 3, 4]) then
    ending := 'года'
  else
    ending := 'лет';
  WriteLn(year, ' ', ending);
end.