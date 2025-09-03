unit Edit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  Buttons, ExtCtrls;

type

  { TfEdit }

  TfEdit = class(TForm)
    bSave: TBitBtn;
    bCancel: TBitBtn;
    eBR: TComboBox;
    ePeople: TEdit;
    ePrice: TEdit;
    eNation: TComboBox;
    eName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure eBRChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  fEdit: TfEdit;

implementation

{$R *.lfm}

{ TfEdit }

procedure TfEdit.FormShow(Sender: TObject);
begin
  eName.SetFocus;
end;

procedure TfEdit.eBRChange(Sender: TObject);
begin

end;

end.

