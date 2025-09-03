procedure qwe(n:integer); //параметры
begin
  if n >= 1 then //база
  begin
    write(n,' ');
    qwe(n-1) //декомпозиция
  end;
end;
begin
  qwe(25);
end.