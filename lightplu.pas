///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   lightplu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   This code runs in a seperate thread. It monitors
//            the state of the light switch flag (LightOn)
//            If it changes it then updates the status of the light on
//            the main form.
// History:   16Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit lightplu;

interface

uses
  Classes;

type
  TLightPol = class(TThread)
  private
    { Private declarations }
  protected
    procedure DispLight ;
    procedure LightOff ;
    procedure Execute; override;
  end;

implementation 

uses Windows, SysUtils, cwu ;

const
  MaxSize = 20000000 ;

procedure TLightPol.DispLight ;
begin
  if LightOn then
    Form1.Light.Visible := True
  else     
    Form1.Light.Visible := False ;
  Form1.Update ;
end ;

procedure TLightPol.LightOff ;
begin
  Form1.Light.Visible := False ; 
  Form1.Update ;
end ;

{ TLightPol }

procedure TLightPol.Execute ;
var
  i: integer ;
  last: boolean ;
begin
  FreeOnTerminate := True ;  
  last := LightOn ;
  for i := 1 to MaxSize do
    begin
      If Terminated then Break ;
      Sleep(10) ;
      if LightOn <> last then
        Synchronize(DispLight) ;
      last := LightOn ;
    end ;
  Synchronize(LightOff) ;
end ;

end.
