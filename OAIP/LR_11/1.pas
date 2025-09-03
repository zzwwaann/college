uses GraphABC;
begin
  moveTo(300,100);
  lineTo(400,150);
  lineto(200,150);
  lineto(300,100);
  moveTo(200,150);
  lineto(300,200);
  lineTo(400,150);
  Circle(150,150,50);
  Circle(450,150,50);
  FloodFill(155,145,clred);
  FloodFill(300,110,clblue);
  FloodFill(300,155,cllime);
  FloodFill(450,150,clyellow);
end.