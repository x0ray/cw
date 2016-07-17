///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   codesndu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   Sends a never ending sequence of random characters.
// History:   10Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit codesndu;

interface

uses
  Classes;

type
  TCodeSend = class(TThread)
  private
    { Private declarations }
  protected                    
    procedure DispLetter ;
    procedure Execute; override;
  end;

implementation

uses Windows, SysUtils, cwu ;

const
  MaxSize = 20000000 ;

procedure TCodeSend.DispLetter ;
begin
  Form1.LetterSent.Caption := Letter ;
end;

{ TCodeSend }

procedure TCodeSend.Execute;
var
  i,j: integer ;
begin
  FreeOnTerminate := True ;
  for i := 1 to MaxSize do  {do for ever}
    begin
      If Terminated then Break ;
      {generate random character}
      j := ord('A') + Trunc(Random(26)) ;
      {send character}
      SendChar(chr(j)) ;
      {display the letter for a short time}
      Letter := Chr(j) ;
      Synchronize(DispLetter) ;
      if Twice then
        begin
          Sleep(1000) ;
          {send character}
          SendChar(chr(j)) ;
          Sleep(1500) ;
        end
      else
        Sleep(2500) ;
      Letter := '' ;
      Synchronize(DispLetter) ;
    end ;
end;

end.
