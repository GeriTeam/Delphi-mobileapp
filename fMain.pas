unit fMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, Datasnap.DSCommon,
  Data.DB, Data.SqlExpr, DBXJSON, JSON, Data.DBXDataSnap, Data.DBXCommon,
  IPPeerClient, FMX.Edit;

type
  TmemoCallback = class(TDBXCallback)
    public
    constructor Create;
    function Execute(const Arg: TJSONValue): TJSONValue; override;
  end;
  TForm1 = class(TForm)
    btnStart: TCornerButton;
    edtConversation: TMemo;
    edtChatText: TMemo;
    edtPeople: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SQLConnection1: TSQLConnection;
    ChannelManager: TDSClientCallbackChannelManager;
    btnStop: TCornerButton;
    edtAddress: TEdit;
    Label4: TLabel;
    btnSend: TButton;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
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
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TForm1.btnStartClick(Sender: TObject);
begin
//бутон start заповаме връзката
  if not SQLConnection1.Connected  then
    begin
      ChannelManager.DSHostname := edtAddress.Text;
      SQLConnection1.Open;
      CallbackID := DateTimeToStr(Now);
    end;

  edtAddress.Enabled := False;
  btnStart.Enabled := False;
  btnStop.Enabled := True;
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
     Form1.edtConversation.Lines.Text := MessageStr;
     end);
   end;
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
//бутон stop прекъсваме връзката и бутона стоп
  edtAddress.Enabled := True;
  btnStart.Enabled := True;
  btnStop.Enabled := False;
  ChannelManager.UnregisterCallback(CallBackID);

  if  SQLConnection1.Connected  then
    SQLConnection1.Close;

end;

end.
