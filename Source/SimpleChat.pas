 {
 Please don't be a dick and take the credit as your own.
 I worked hard on it... Sorta...
 }

unit SimpleChat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ExtDlgs, System.Win.ScktComp,
  uUsers, Vcl.Menus,
  ShellAPI,
  uStrings,
  winsock;

type
  TForm1 = class(TForm)
    pgc1: TPageControl;
    tsconnect: TTabSheet;
    tshost: TTabSheet;
    pnl1: TPanel;
    pnl2: TPanel;
    mmoconnectchat: TMemo;
    edtip: TEdit;
    edtport: TEdit;
    lblfdshgf: TLabel;
    btnconnectconnect: TButton;
    btnconnectDisconnect: TButton;
    grp1: TGroupBox;
    edtconnectusername: TEdit;
    btn5: TButton;
    btn4: TButton;
    lblconnectionstatus: TLabel;
    dlgFont1: TFontDialog;
    edtconnectchatsend: TEdit;
    btnconnectsend: TButton;
    svtxtfldlg1: TSaveTextFileDialog;
    clntsckt1: TClientSocket;
    pnl3: TPanel;
    pnl4: TPanel;
    mmohost: TMemo;
    edthostchat: TEdit;
    btnhostsend: TButton;
    edthostport: TEdit;
    grp2: TGroupBox;
    chkhostlogchat: TCheckBox;
    edthostusername: TEdit;
    lbl1: TLabel;
    lblhoststatus: TLabel;
    btnhoststart: TButton;
    btnhoststop: TButton;
    chkhostlogip: TCheckBox;
    pnl5: TPanel;
    lbl2: TLabel;
    lblconnectedusercount: TLabel;
    srvrsckt1: TServerSocket;
    mm1: TMainMenu;
    File1: TMenuItem;
    Update1: TMenuItem;
    Exit1: TMenuItem;
    GithubPage1: TMenuItem;
    About1: TMenuItem;
    chkconnectsendonenter: TCheckBox;
    chkhostsendonenter: TCheckBox;
    ReportaIssue1: TMenuItem;
    btnsave: TButton;
    btn1: TButton;
    btndns: TButton;
    lbl4: TLabel;
    Help1: TMenuItem;
    Cannotconnect1: TMenuItem;
    procedure btn4Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btnconnectconnectClick(Sender: TObject);
    procedure clntsckt1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure clntsckt1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure clntsckt1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnconnectDisconnectClick(Sender: TObject);
    procedure clntsckt1Connecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnconnectsendClick(Sender: TObject);
    procedure clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure srvrsckt1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure srvrsckt1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure btnhostsendClick(Sender: TObject);
    procedure btnhoststartClick(Sender: TObject);
    procedure srvrsckt1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure btnhoststopClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure OpenURL (url : string);
    procedure GithubPage1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure mmohostChange(Sender: TObject);
    procedure edthostchatKeyPress(Sender: TObject; var Key: Char);
    procedure edtconnectchatsendKeyPress(Sender: TObject; var Key: Char);
    procedure ReportaIssue1Click(Sender: TObject);
    procedure btnsaveClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    function GetIP(const HostName: string): string;
    procedure btndnsClick(Sender: TObject);
    procedure lbl4Click(Sender: TObject);
    procedure Cannotconnect1Click(Sender: TObject);
  private
    usercount, userid : Integer;
    IPNULL : string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnconnectconnectClick(Sender: TObject);
begin
  if (UpperCase(edtconnectusername.Text) = 'SERVER') or (UpperCase(edtconnectusername.Text) = 'ADMIN') or (UpperCase(edtconnectusername.Text) = 'HOST')  then
    ShowMessage('Only the host can use this name...')
  else
  begin
    if (Trim(edtip.Text) <> '') and (Trim(edtport.Text) <> '') and (Trim(edtconnectusername.Text) <> '') then
      begin
        clntsckt1.Address := edtip.Text;
        clntsckt1.Port := StrToInt(edtport.Text);
        clntsckt1.Active := True;
        mmoconnectchat.Clear;
      end
    else
      ShowMessage('Please make sure that there is a IP, Port and a Username');
  end;
end;

procedure TForm1.btnconnectDisconnectClick(Sender: TObject);
begin
  clntsckt1.Active := False;
end;

procedure TForm1.btnconnectsendClick(Sender: TObject);
begin
  if Trim(edtconnectchatsend.Text) <> '' then
    begin
      clntsckt1.Socket.SendText(edtconnectusername.Text + ': ' + edtconnectchatsend.Text);
      //mmoconnectchat.Lines.Add('Me: ' + edtconnectchatsend.Text);
      edtconnectchatsend.Clear;
    end
  else
    ShowMessage('You cannot send nothing... Don''t be shy!');
end;

procedure TForm1.btnhostsendClick(Sender: TObject);
var
  client: TCustomWinSocket;
  I : Integer;
begin
  if Trim(edthostchat.Text) <> '' then
    begin
      for I := 0 to srvrsckt1.Socket.ActiveConnections-1 do
        begin
          srvrsckt1.Socket.Connections[I].SendText('[' + TimeToStr(Time) + '] ' + edthostusername.Text + ': ' + edthostchat.Text);
        end;
      mmohost.Lines.Add('[' + TimeToStr(Time) + '] ' + edthostusername.Text + ': ' + edthostchat.Text);
      edthostchat.Clear;
    end
  else
    ShowMessage('Even if you are the host. You cannot not send anything. Don''t be shy!');
end;

procedure TForm1.btnhoststartClick(Sender: TObject);
begin
  if (Trim(edthostport.Text) <> '') and (Trim(edthostusername.Text) <> '') then
    begin
      usercount := 0;
      srvrsckt1.Port := StrToInt(edthostport.Text);
      srvrsckt1.Active := True;

      lblhoststatus.Caption := 'Listening...';
      lblhoststatus.Font.Color := clLime;

      edthostport.Enabled := False;
      chkhostlogchat.Enabled := False;
      chkhostlogip.Enabled := False;
      edthostusername.Enabled := False;
      btnhoststart.Enabled := False;

      btnhoststop.Enabled := True;
      edthostchat.Enabled := True;
      btnhostsend.Enabled := True;
    end
  else
    ShowMessage('Please make sure there is a port and a Username');
end;

procedure TForm1.btnhoststopClick(Sender: TObject);
begin
  srvrsckt1.Active := False;

  lblhoststatus.Caption := 'Not Listening...';
  lblhoststatus.Font.Color := clRed;

  edthostport.Enabled := True;
  chkhostlogchat.Enabled := True;
  chkhostlogip.Enabled := True;
  edthostusername.Enabled := True;
  btnhoststart.Enabled := True;

  btnhoststop.Enabled := False;
  edthostchat.Enabled := False;
  btnhostsend.Enabled := False;
end;

procedure TForm1.btnsaveClick(Sender: TObject);
begin
  if (Trim(edtip.Text) <> '') and (Trim(edtport.Text) <> '') and (Trim(edtconnectusername.Text) <> '') then
    begin
      frmstrings.mmo1.Clear;
      frmstrings.mmo1.Lines.Add(edtconnectusername.Text);
      frmstrings.mmo1.Lines.Add(edtip.Text);
      frmstrings.mmo1.Lines.Add(edtport.Text);
      frmstrings.mmo1.Lines.SaveToFile('C:\Users\Public\Documents\simplechat.ini');
      ShowMessage('Settings saved!');
    end
  else
    ShowMessage('Please make sure that there is a IP, Port and a Username');
end;

procedure TForm1.Cannotconnect1Click(Sender: TObject);
begin
  ShowMessage('You need to Port-Forward the port you want to use. Google "How to port forward"');
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  ShowMessage('Simple chat by Adriaan Boshoff (Inforcer25)');
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  if dlgFont1.Execute then
    mmohost.Font := dlgFont1.Font;
end;

procedure TForm1.btndnsClick(Sender: TObject);
var
  ip, dns : string;
begin
  dns := inputbox('DNS to IP', 'Enter the dns eg. ''noip.ddns.net''','');
  ip := GetIP(dns);
  edtip.Text := ip;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
  if dlgFont1.Execute then
    mmoconnectchat.Font := dlgFont1.Font;
end;

procedure TForm1.btn5Click(Sender: TObject);
begin
  if svtxtfldlg1.Execute then
    mmoconnectchat.Lines.SaveToFile(svtxtfldlg1.FileName);
end;

procedure TForm1.clntsckt1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
  edtip.Enabled := False;
  edtport.Enabled := False;
  edtconnectusername.Enabled := False;
  edtconnectchatsend.Enabled := True;
  btnconnectsend.Enabled := True;
  lblconnectionstatus.Caption := 'Connected';
  lblconnectionstatus.Font.Color := clLime;
  btnconnectconnect.Enabled := False;
  btnconnectDisconnect.Enabled := True;
  btndns.Enabled := False;
end;

procedure TForm1.clntsckt1Connecting(Sender: TObject; Socket: TCustomWinSocket);
begin
  lblconnectionstatus.Caption := 'Connecting...';
  lblconnectionstatus.Font.Color := clYellow;
end;

procedure TForm1.clntsckt1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  edtip.Enabled := True;
  edtport.Enabled := True;
  edtconnectusername.Enabled := True;
  edtconnectchatsend.Enabled := False;
  btnconnectsend.Enabled := False;
  lblconnectionstatus.Caption := 'Not Connected...';
  lblconnectionstatus.Font.Color := clRed;
  btnconnectconnect.Enabled := True;
  btnconnectDisconnect.Enabled := False;
  btndns.Enabled := true;
end;

procedure TForm1.clntsckt1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ShowMessage('Error connecting to ' + clntsckt1.Address);
end;

procedure TForm1.clntsckt1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  mmoconnectchat.Lines.Add(clntsckt1.Socket.ReceiveText);
end;

procedure TForm1.edtconnectchatsendKeyPress(Sender: TObject; var Key: Char);
begin
  if chkconnectsendonenter.Checked then
    begin
      if ord(Key) = VK_RETURN then
        begin
          Key := #0; // prevent beeping
          btnconnectsend.Click;
        end;
    end;
end;

procedure TForm1.edthostchatKeyPress(Sender: TObject; var Key: Char);
begin
  if chkhostsendonenter.Checked then
    begin
      if ord(Key) = VK_RETURN then
        begin
          Key := #0; // prevent beeping
          btnhostsend.Click;
        end;
    end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  sl: TStringList;
  username, ip : string;
  port : Integer;
begin
  Application.Title := 'Simple Chat';
  ShowMessage('This project is still in development and can change over time.');

  if FileExists('C:\Users\Public\Documents\simplechat.ini') then
    begin
      sl := TStringList.Create;
        try
          sl.LoadFromFile('C:\Users\Public\Documents\simplechat.ini');
          username := sl[0];
          ip := sl[1];
          port := StrToInt(sl[2]);

          edtconnectusername.Text := username;
          edtip.Text := ip;
          edtport.Text := IntToStr(port);
        finally
          sl.Free;
          ShowMessage('Loaded previous settings!');
        end;
    end;
end;

function TForm1.GetIP(const HostName: string): string;
var
  WSAData: TWSAData;
  R: PHostEnt;
  A: TInAddr;
begin
  Result := IPNULL;
  WSAStartup($101, WSAData);
  R := Winsock.GetHostByName(PAnsiChar(AnsiString(HostName)));
  if Assigned(R) then
  begin
    A := PInAddr(r^.h_Addr_List^)^;
    Result := WinSock.inet_ntoa(A);
  end;
end;

procedure TForm1.GithubPage1Click(Sender: TObject);
begin
  OpenURL('https://github.com/Inforcer25/Simple-Chat');
end;

procedure TForm1.lbl4Click(Sender: TObject);
begin
  OpenURL('https://www.noip.com/login');
end;

procedure TForm1.mmohostChange(Sender: TObject);
begin
  if chkhostlogchat.Checked then
    mmohost.Lines.SaveToFile('host.log');
end;

procedure TForm1.OpenURL(url: string);
begin
  ShellExecute(self.WindowHandle,'open',PChar(url),nil,nil, SW_SHOWNORMAL);
end;

procedure TForm1.ReportaIssue1Click(Sender: TObject);
begin
  ShowMessage('You will now be taken to the github issues page. Please report a issue as it''s important to me');
  OpenURL('https://github.com/Inforcer25/Simple-Chat/issues');
end;

procedure TForm1.srvrsckt1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  Inc(usercount);
  lblconnectedusercount.Caption := IntToStr(usercount);

  if chkhostlogip.Checked then
    Form2.lst1.Items.Add(socket.RemoteAddress);
    Form2.lst1.Items.SaveToFile('ip.log');
end;

procedure TForm1.srvrsckt1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
  usercount := usercount - 1;
  lblconnectedusercount.Caption := IntToStr(usercount);
end;

procedure TForm1.srvrsckt1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  I : Integer;
  msg : string;
begin
  msg := '[' + TimeToStr(Time) + '] ' + Socket.ReceiveText;
  mmohost.Lines.Add(msg);

  for I := 0 to srvrsckt1.Socket.ActiveConnections-1 do
  begin
    srvrsckt1.Socket.Connections[I].SendText(msg);
  end;
end;

end.
