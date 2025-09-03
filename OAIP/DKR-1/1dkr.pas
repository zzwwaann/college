var
  x,r,y: real;
begin
  ReadLn(x);
  if x < -9 then
    y:=Sqr(Sin(x)/Cos(x));
  if (x >= -9) and (x < -5) then
    y:=Sin(x) * ((-x)**(0.1 * (-x))) + (47 / ln(-x));
  if (x >= -5) and (x < 3) then
    y:=(Cos(2 * x) / Cos(2 * x)) * (abs(x)**(0.1 * abs(x)) / exp(x*ln(1/3)));
  if x >= 3 then
    y:=x**(1/3) + x**2;
  writeln(y)
end.