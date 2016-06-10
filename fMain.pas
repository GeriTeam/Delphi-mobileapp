unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, Datasnap.DSCommon,
  Data.DB, Data.SqlExpr, DBXJSON, JSON, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient;

type
  TmemoCallback = class(TDBXCallback)
    public
    constructor Create;
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;
  TForm1 = class(TForm)
    CornerButton1: TCornerButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SQLCunnection1: TSQLConnection;
    ChannelManager: TDSClientCallbackChannelManager;
    procedure CornerButton1Click(Sender: TObject);
  private
    CallBackID : String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.iPhone47in.fmx IOS}
{$R *.iPhone55in.fmx IOS}
{$R *.iPhone4in.fmx IOS}
{$R *.Windows.fmx MSWINDOWS}

procedure TForm1.CornerButton1Click(Sender: TObject);
begin
  if not SQLCunnection1.Connected  then
    begin
      SQLCunnection1.Open;
      CallbackID := DateTimeToStr(Now);
    end;


  ChannelManager.RegisterCallback(CallBackID, TMemoCallback.Create());
end;

{ TmemoCallback }

constructor TmemoCallback.Create;

begin

end;

function TmemoCallback.Execute(const Arg: TJSONValue): TJSONValue;
var MessageStr: String;
begin
   Result := TJSONTrue.Create;
   if arg is TJSONString then
   begin
     MessageStr := TJSONString(Arg).Value;

     TThread.Synchronize(nil,
     procedure
     begin
     Form1.Memo1.Lines.Text := MessageStr;
     end);
   end;
end;

end.
