///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   beeperu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   This code runs in a seperate thread and beeps the
//            PC speaker until the thread is terminated. The
//            thread is started and terminated by cwu.pas
// History:   01Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit beeperu;

interface

uses
  Classes;

type
  Beeper = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

uses SysUtils, cwu ;

const
  MaxSize = 20000000 ;

{ Beeper }

procedure Beeper.Execute; 
var
  i: integer ;
begin
  FreeOnTerminate := True ;
  for i := 1 to MaxSize do
    begin
      If Terminated then Break ;  
      MyBeep(freq,30) ;
    end ;
end;

end.
