///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   helpu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   This code displays a simple (non-standard) help window.
// History:   01Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit helpu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  THelp = class(TForm)
    HelpText: TRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Help: THelp;

implementation

{$R *.DFM}

end.
 