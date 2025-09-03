var
  a,a1,a2:string;
  len,i,j,k:integer;
  T:boolean;
 begin
   writeln('Введите строку');
   readln(a);
   writeln('Введите подстроку');
   readln(a1);
   len := length(a1);
   for i:=1 to length(a)-len+1 do begin
     T:=False;
     if a[i] = a1[1] then begin
       j := i;
       for k:=1 to len do 
         if a1[k]=a[j] then
           j:=j+1
         else 
           break;
        if k = len then 
          T:=True;
        if T then begin
          j := i;
        for k:=len downto 1 do begin
           a[j]:=a1[k];
           j:=j+1;
           end;
        end;
       end; 
   end;
   writeln(a)
  end.