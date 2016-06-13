unit ServerDataSnap;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBXJSON,JSON,
  Vcl.StdCtrls, Vcl.DBCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure Memo1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ServerContainerUnit1;

procedure TForm1.Memo1Change(Sender: TObject);
var
Value : TJSONString;
begin
 Value := TJSONString.Create(Memo1.Lines.Text);
 ServerContainer1.DSServer1.BroadcastMessage('MemoChannel', Value);

end;

end.

