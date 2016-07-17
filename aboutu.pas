///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   aboutu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   Displays a dialog that allows the user to learn the
//            International Morse code.
// History:   10Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit aboutu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About: TAbout;

implementation

{$R *.DFM}

procedure TAbout.Button1Click(Sender: TObject);
begin
  About.Close ;
end;

end.
