var
   filetext: text;
   a:string;
   i:integer;
begin
assign(filetext,'C:\Users\LenNout\Desktop\ОАиП\12\text.txt');
rewrite(filetext);
for i:=1 to 10 do
   writeln(filetext,i);
   close(filetext);
   assign(filetext,'C:\Users\LenNout\Desktop\ОАиП\12\text.txt');
reset(filetext);
for i:=1 to 10 do begin
    readln(filetext,a);
    writeln(a);
end;
close(filetext);
end.