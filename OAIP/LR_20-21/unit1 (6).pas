unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    DelLastSim: TButton;
    Six: TButton;
    One: TButton;
    Two: TButton;
    Three: TButton;
    Zero: TButton;
    Point: TButton;
    Division: TButton;
    Multiplication: TButton;
    Minus: TButton;
    Plus: TButton;
    ClearStr: TButton;
    Sqr: TButton;
    OneDivX: TButton;
    Equal: TButton;
    MinusX: TButton;
    Sqrt: TButton;
    Seven: TButton;
    Eight: TButton;
    Nine: TButton;
    Four: TButton;
    Five: TButton;
    Stroka: TEdit;
    procedure SixClick(Sender: TObject);
    procedure OneClick(Sender: TObject);
    procedure TwoClick(Sender: TObject);
    procedure ThreeClick(Sender: TObject);
    procedure ZeroClick(Sender: TObject);
    procedure PointClick(Sender: TObject);
    procedure SqrClick(Sender: TObject);
    procedure OneDivXClick(Sender: TObject);
    procedure EqualClick(Sender: TObject);
    procedure SqrtClick(Sender: TObject);
    procedure ClickZnak(Sender: TObject);
    procedure DelLastSimClick(Sender: TObject);
    procedure ClearStrClick(Sender: TObject);
    procedure MinusXClick(Sender: TObject);
    procedure SevenClick(Sender: TObject);
    procedure EightClick(Sender: TObject);
    procedure NineClick(Sender: TObject);
    procedure FourClick(Sender: TObject);
    procedure FiveClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  a, b, c: real;
  znak: string;
  errorstate: boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ClickZnak(Sender: TObject); // *, /, +, -
begin
  if errorstate then Exit;


  if (znak <> '') and (Stroka.Text <> '') and (Stroka.Text <> '-') then
  begin
    // Выполнение предыдущей операции автоматически, если не нажато =
    Button22Click(Sender);
    if errorstate then Exit;
  end;

  if (Stroka.Text = '') or (Stroka.Text = '-') then Exit;

  a := StrToFloat(Stroka.Text);
  Stroka.Clear;
  znak := (Sender as TButton).Caption;
end;

procedure TForm1.EqualClick(Sender: TObject);
begin
  if errorstate then Exit;
  if znak = '' then Exit;

  if (Stroka.Text = '') or (Stroka.Text = '-') then Exit;

  try
    b := StrToFloat(Stroka.Text);

    case znak of
      '+': a := a + b;
      '-': a := a - b;
      '/':
        begin
          if b = 0 then
            raise EDivByZero.Create('Деление на ноль');
          a := a / b;
        end;
      '*': a := a * b;
    end;

    Stroka.Text := FloatToStr(a);
    znak := '';

  except
    on E: EDivByZero do
    begin
      Stroka.Text := 'Ошибка: деление на 0';
      errorstate := True;
      znak := '';
    end;
    on E: Exception do
    begin
      Stroka.Text := 'Ошибка вычисления';
      errorstate := True;
      znak := '';
    end;
  end;
end;


procedure TForm1.OneClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '1';
end;

procedure TForm1.SixClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '6';
end;

procedure TForm1.TwoClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '2';
end;

procedure TForm1.ThreeClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '3';
end;

procedure TForm1.ZeroClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '0';
end;

procedure TForm1.PointClick(Sender: TObject);
var str: string;
begin
  if errorstate then Exit;
  str := Stroka.Text;
  if (pos(',', str) = 0) and (str <> '') and (str <> '-') then
  Stroka.Text := Stroka.Text + ',';
end;

procedure TForm1.SqrClick(Sender: TObject); // a^2
begin
  if errorstate then Exit;
  if (Stroka.Text = '') or (Stroka.Text = '-') then Exit;
  a := strtofloat(Stroka.Text);
  a := Division(a);
  Stroka.Text := floattostr(a);
  a := 0;
end;

procedure TForm1.OneDivXClick(Sender: TObject); // 1/a
begin
  if errorstate then Exit;
  if (Stroka.Text = '') or (Stroka.Text = '-') then Exit;
  a := strtofloat(Stroka.Text);
  try
  a := 1 / (a);
  Stroka.Text := floattostr(a);
  except
    on E: Exception do begin
      Stroka.Text := 'Ошибка: деление на 0';
      errorstate := True;
    end;
  end;
  a := 0;
end;


procedure TForm1.SqrtClick(Sender: TObject); // корень
begin
  if errorstate then Exit;
  if (Stroka.Text = '') or (Stroka.Text = '-') then Exit;
  a := strtofloat(Stroka.Text);
  try
    a := sqrt(a);
    Stroka.Text := floattostr(a);
  except
    on E: Exception do begin
      Stroka.Text := 'Ошибка: отрицательное число';
      errorstate := True;
    end;
  end;
end;



procedure TForm1.DelLastSimClick(Sender: TObject); // удаление последнего символа в строке
var
str: string;
begin
 if errorstate then begin
 Stroka.Text := '';
 errorstate := False;
 end;
 str := Stroka.Text;
 if str <> '' then
 delete(str, length(str), 1);
 Stroka.Text := str;
end;

procedure TForm1.ClearStrClick(Sender: TObject); // очистка строки
begin
 Stroka.Text := '';
 a := 0;
 b := 0;
 c := 0;
 errorstate := False;
end;

procedure TForm1.MinusXClick(Sender: TObject); // - у числа
begin
  if errorstate then Exit;
  if Stroka.Text = '' then
  begin
    Stroka.Text := '-';
    Exit;
  end;
  if (Stroka.Text[1] = '-') then
    Exit;
  if (Stroka.Text <> '-') then
    Stroka.Text := '-' + Stroka.Text;
end;

procedure TForm1.SevenClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '7';
end;

procedure TForm1.EightClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '8';
end;

procedure TForm1.NineClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '9';
end;

procedure TForm1.FourClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '4';
end;

procedure TForm1.FiveClick(Sender: TObject);
begin
  if errorstate then Exit;
  Stroka.Text := Stroka.Text + '5';
end;



end.

