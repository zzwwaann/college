begin
var e,q,w,t,y:integer;
writeln ('Введите шаг');
readln (e);
t:=2;
w:= (10 div e)+1;
for q:=1 to w do 
begin
y:=t*t;
writeln ('X = ',t, '   Y = ',y);
t:=t+e;
end;
end.