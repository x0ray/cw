program cwp;

uses
  Forms,
  cwu in 'cwu.pas' {Form1},
  beeperu in 'beeperu.pas',
  codedspu in 'codedspu.pas',
  helpu in 'helpu.pas' {Help},
  codesndu in 'codesndu.pas',
  copycdeu in 'copycdeu.pas',
  sendtxtu in 'sendtxtu.pas',
  aboutu in 'aboutu.pas' {About},
  lightplu in 'lightplu.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(THelp, Help);
  Application.CreateForm(TAbout, About);
  Application.Run;
end.
