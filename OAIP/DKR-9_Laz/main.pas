unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, Grids, Edit;

type
  Tank = record
    Name: string[50];
    Nation: string[50];
    Price: integer;
    BR: string[10];
    People: integer;
  end;
  { TfMain }

  TfMain = class(TForm)
    cbSort: TComboBox;
    Panel1: TPanel;
    dAdd: TSpeedButton;
    bEdit: TSpeedButton;
    bDel: TSpeedButton;
    bSort: TSpeedButton;
    SG: TStringGrid;
    procedure bDelClick(Sender: TObject);
    procedure bEditClick(Sender: TObject);
    procedure bAddClick(Sender: TObject);
    procedure bSortClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  fMain: TfMain;
  adres: string;
implementation

{$R *.lfm}

{ TfMain }

procedure TfMain.bAddClick(Sender: TObject);
begin
  //очищаем поля, если там что-то есть:
  fEdit.eName.Text:= '';
  fEdit.eNation.Text:= '';
  //устанавливаем ModalResult редактора в mrNone:
  fEdit.ModalResult:= mrNone;
  //теперь выводим форму:
  fEdit.ShowModal;
  //если пользователь ничего не ввел - выходим:
  if (fEdit.eName.Text= '') or (fEdit.eNation.Text= '') then exit;
  //если пользователь не нажал "Сохранить" - выходим:
  if fEdit.ModalResult <> mrOk then exit;
  //иначе добавляем в сетку строку, и заполняем её:
  SG.RowCount:= SG.RowCount + 1;
  SG.Cells[0, SG.RowCount-1] := fEdit.eName.Text;
  SG.Cells[1, SG.RowCount-1] := fEdit.eNation.Text;
  SG.Cells[2, SG.RowCount-1] := fEdit.ePrice.Text;
  SG.Cells[3, SG.RowCount-1] := fEdit.eBR.Text;
  SG.Cells[4, SG.RowCount-1] := fEdit.ePeople.Text;

end;

procedure TfMain.bSortClick(Sender: TObject);
begin
  if SG.RowCount = 1 then exit;
  if cbSort.ItemIndex = 0 then
  SG.SortColRow(true, 0);
  if cbSort.ItemIndex = 1 then
  SG.SortColRow(true, 1);
  if cbSort.ItemIndex = 2 then
  SG.SortColRow(true, 2);
  if cbSort.ItemIndex = 3 then
  SG.SortColRow(true, 3);
  if cbSort.ItemIndex = 4 then
  SG.SortColRow(true, 4);
end;


procedure TfMain.bEditClick(Sender: TObject);
begin
    // если нет выбранной строки или только заголовок — выходим
    if (SG.RowCount = 1) or (SG.Row = 0) then exit;

    // заполняем форму текущими значениями из таблицы
    fEdit.eName.Text   := SG.Cells[0, SG.Row];
    fEdit.eNation.Text  := SG.Cells[1, SG.Row];
    fEdit.ePrice.Text := SG.Cells[2, SG.Row];
    fEdit.eBR.Text   := SG.Cells[3, SG.Row];
    fEdit.ePeople.Text  := SG.Cells[4, SG.Row];

    // устанавливаем ModalResult редактора в mrNone:
    fEdit.ModalResult := mrNone;

    // показываем форму редактирования
    fEdit.ShowModal;

    // если пользователь нажал "Сохранить", сохраняем изменения
    if fEdit.ModalResult = mrOk then
    begin
      SG.Cells[0, SG.Row] := fEdit.eName.Text;
      SG.Cells[1, SG.Row] := fEdit.eNation.Text;
      SG.Cells[2, SG.Row] := fEdit.ePrice.Text;
      SG.Cells[3, SG.Row] := fEdit.eBR.Text;
      SG.Cells[4, SG.Row] := fEdit.ePeople.Text;
    end;
  end;

procedure TfMain.bDelClick(Sender: TObject);
begin
  //если данных нет - выходим:
  if SG.RowCount = 1 then exit;
  //иначе выводим запрос на подтверждение:
  if MessageDlg('Требуется подтверждение',
                'Вы действительно хотите удалить данную модель? "' +
                SG.Cells[0, SG.Row] + '"?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
         SG.DeleteRow(SG.Row);
end;


procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  MyCont: Tank; //для очередной записи
  f: file of Tank; //файл данных
  i: integer; //счетчик цикла
begin
  //если строки данных пусты, просто выходим:
  if SG.RowCount = 1 then exit;
  //иначе открываем файл для записи:

    AssignFile(f, adres + 'tanks.dat');
    Rewrite(f);
    //теперь цикл - от первой до последней записи сетки:
    for i:= 1 to SG.RowCount-1 do begin
      //получаем данные текущей записи:
      MyCont.Name  := SG.Cells[0, i];
      MyCont.Nation  := SG.Cells[1, i];
      MyCont.Price := StrToIntDef(SG.Cells[2, i], 0);
      MyCont.BR  := SG.Cells[3, i];
      MyCont.People := StrToIntDef(SG.Cells[4, i], 0);

      //записываем их:
      Write(f, MyCont);
    end;
    CloseFile(f);
  end;

procedure TfMain.FormCreate(Sender: TObject);
var
  MyCont: Tank; //для очередной записи
  f: file of Tank; //файл данных
  i: integer; //счетчик цикла
begin
  //сначала получим адрес программы:
  adres:= ExtractFilePath(ParamStr(0));
  //настроим сетку:
  SG.Cells[0, 0]:= 'Название';
  SG.Cells[1, 0]:= 'Нация';
  SG.Cells[2, 0]:= 'Цена';
  SG.Cells[3, 0]:= 'Боевой рейтинг';
  SG.Cells[4, 0]:= 'Экипаж';
  SG.ColWidths[0] := 200;
  SG.ColWidths[1] := 100;
  SG.ColWidths[2] := 100;
  SG.ColWidths[3] := 150;
  SG.ColWidths[4] := 120;
  //если файла данных нет, просто выходим:
  if not FileExists(adres + 'tanks.dat') then exit;
  //иначе файл есть, открываем его для чтения и
  //считываем данные в сетку:
  try
    AssignFile(f, adres + 'tanks.dat');
    Reset(f);
    //теперь цикл - от первой до последней записи сетки:
    while not Eof(f) do begin
      //считываем новую запись:
      Read(f, MyCont);
      //добавляем в сетку новую строку, и заполняем её:
      SG.RowCount := SG.RowCount + 1;
      SG.Cells[0, SG.RowCount - 1] := MyCont.Name;
      SG.Cells[1, SG.RowCount - 1] := MyCont.Nation;
      SG.Cells[2, SG.RowCount - 1] := IntToStr(MyCont.Price);
      SG.Cells[3, SG.RowCount - 1] := MyCont.BR;
      SG.Cells[4, SG.RowCount - 1] := IntToStr(MyCont.People);

    end;
  finally
    CloseFile(f);
  end;
end;
end.
