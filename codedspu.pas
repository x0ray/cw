///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   codedspu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   This code runs in a seperate thread. It monitors
//            the MorseKeyButton to determine when the user has
//            finished sending a character. Then it updates the
//            DispChar label to display the code that was keyed,
//            or an Error if the code was invalid.
//            This thread is started by cwp.pas and terminates
//            itself 1.5 seconds after the last morse key press.
// History:   01Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit codedspu;

interface

uses
  Classes;

type
  TCodeDsp = class(TThread)
  private
    { Private declarations }
  protected           
    procedure DispCode ;
    procedure Execute; override;
  end;

implementation  

uses Windows, SysUtils, cwu ;

const
  MaxSize = 20000000 ;

procedure TCodeDsp.DispCode ;
var
  i: integer ;
  letter: string ;
begin
  letter := 'Error' ;
  for i := 1 to NCodes do
    begin
      if CodeStr = Codes[i] then
        begin
          letter := chr(i) ;
          break ;
        end ;
    end ;
  Form1.DispChar.Caption := CodeStr+' = '+letter ;
  CodeStr := '' ;
end;

{ TCodeDsp }

procedure TCodeDsp.Execute;
var
  i: integer ;
  Hour, Min, Sec, MSec: word ;
  ct, ft: integer ;
begin
  FreeOnTerminate := True ;
  for i := 1 to MaxSize do
    begin
      If Terminated then Break ;
      Sleep(500) ;  {sleep longer than slowest dah}
      DecodeTime(Time,Hour,Min,Sec,MSec) ;
      ct := (Sec*1000)+MSec ;
      if st <= ct then
        ft := ct - st
      else
        ft := ct + (60000 - st) ;
      if ft > 1500 then
        begin
          Synchronize(DispCode) ;
          break ;
        end ;
    end ;
  CodeDspStarted := False ;
end;

end.
