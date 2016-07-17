///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   sendtxtu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   Sends a string of text and allows the user to cancel
//            the sending of the text at any time.
// History:   10Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit sendtxtu;

interface

uses
  Classes;

type
  TSendText = class(TThread)
  private
    { Private declarations }
  protected     
    procedure DspSendText ;
    procedure DspEndText ;
    procedure Execute; override;
  end;

implementation 

uses Windows, SysUtils, StdCtrls, cwu ;


procedure TSendText.DspSendText ;
var
  mc: string ;
  k: integer ;
begin
  {this routine accepts two global variables as parameters: DspText DspPos}
  k := length(Form1.MsgText.Text) ;
  mc := Codes[ord(DspChar)] ;  {look up code for character}
  if Form1.DcCheckBox.State = cbChecked then
    Form1.Code.Caption := DspChar+' = '+mc ;
  Form1.CurPOs.Caption := RepStr(DspPos-1,'-')+DspChar+RepStr(k-DspPos,'-') ;
  Form1.Update ;
end ;

procedure TSendText.DspEndText ;
begin
  Form1.Code.Caption := '' ;
  Form1.CurPOs.Caption := '' ;
end ;

{ TSendText }

procedure TSendText.Execute;
var
  i: integer ;
begin
  FreeOnTerminate := True ;
  {send the text one character at a time}
  for i := 1 to length(DspText) do
    begin
      If Terminated then Break ;  
      {update the status display}
      DspPos := i ;
      DspChar := DspText[i] ;
      Synchronize(DspSendText) ;
      {send the character as code}
      SendChar(DspText[i]) ;
    end ;  
  Sleep(iws*cpm) ;
  Synchronize(DspEndText) ;
end;

end.
