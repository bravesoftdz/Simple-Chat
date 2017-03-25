program pSimpleChat;

uses
  Vcl.Forms,
  SimpleChat in 'SimpleChat.pas' {Form1},
  Vcl.Themes,
  Vcl.Styles,
  uUsers in 'uUsers.pas' {Form2},
  uStrings in 'uStrings.pas' {frmstrings};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Graphite');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(Tfrmstrings, frmstrings);
  Application.Run;
end.
