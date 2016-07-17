///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   copycdeu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   Sends the text of randomly selected phrases allowing the
//            user to type the copied text. At the end it compares
//            the sent and copied text, noting the errors.
// History:   10Oct97  Initial coding                              DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit copycdeu;

interface

uses
  Classes;

type
  TCopyCode = class(TThread)
  private
    { Private declarations }
  protected     
    procedure DispActual ;    
    procedure CompareActual ;
    procedure Execute; override;
  end;


implementation  

uses Windows, SysUtils, cwu ;

function GetPhrase(n: integer): string ;
var
  i: integer ;
begin
  case n of
   -1: begin
         result := '' ;
         for i := 1 to 35 do
           result := result + Chr(ord('A') + Trunc(Random(26))) ;
       end ;                                           
    0:  result := 'How many roads must a man walk down' ;
    1:  result := 'In what frequency range does sky wave propagation often occur' ;
    2:  result := 'What is a parasitic beam antenna' ;
    3:  result := 'How is a yagi antenna constructed' ;
    4:  result := 'What causes splatter interference' ;
    5:  result := 'What is the name for packet radio emissions' ;
    6:  result := 'How is tone modulated morse code produced' ;
    7:  result := 'What does a capacitor do' ;
    8:  result := 'How do you find a resistors value' ;
    9:  result := 'What determines the inductance of a coil' ;
    10: result := 'What are the most common resistor types' ;
    11: result := 'What is the basic unit of capacitance' ;
    12: result := 'Why would you use a dummy antenna' ;
    13: result := 'How is a marker generator used' ;
    14: result := 'What is the main component of a dummy antenna' ;
    15: result := 'How can the range of a voltmeter be increased' ;
    16: result := 'When is the ionosphere most ionized' ;
    17: result := 'When does ionospheric absorbsion of radio signals occur' ;
    18: result := 'What is one meaning of the Q signal QSY' ;
    19: result := 'How should you give a signal report over a repeater' ;
    20: result := 'What causes a repeater to time out' ;
    21: result := 'When may an amateur transmit unidentified communications' ;
    22: result := 'When may you send a distress call on any frequency' ;
    23: result := 'What is an amateur space station' ;
    24: result := 'When is an amateur station permitted to transmit music' ;
    25: result := 'When mus an amateur station have a control operator' ;
    26: result := 'What is your responsibility as a station licensee' ;
    27: result := 'What age must you be to hold an amateur license' ;
    28: result := 'Who can become an amateur licensee in the US' ;
    29: result := 'What is the definition of an amateur operator' ;
    30: result := 'What does an amateur license allow you to control' ;
  else
    result := 'This is the standard message' ;
  end ;
end ;

procedure TCopyCode.DispActual ;
begin
  Form1.ActualEdit.Text := Actual ;
end;

procedure TCopyCode.CompareActual ;
var
  i,j: integer ;
  bad: integer ;
  temp: string ;
begin
  if UpperCase(Form1.CopyEdit.Text) = UpperCase(Actual) then
    begin
      Form1.CorrectLabel.Caption := 'All correct' ;
      Form1.ActualEdit.Text := Actual ;
    end
  else
    begin
      bad := 0 ;
      temp := Form1.CopyEdit.Text ;
      {get the smaller length}
      if length(Actual) <= length(temp) then
        j := length(Actual)
      else
        j := length(temp) ;
      {compare the common characters only}
      for i := 1 to j do
        begin
          if UpperCase(temp[i]) = UpperCase(Actual[i]) then
            temp[i] := '-'
          else
            bad := bad + 1 ;
        end ;
      Form1.CopyEdit.Text := temp ;
      Form1.ActualEdit.Text := Actual ; 
      Form1.CorrectLabel.Caption := IntToStr(bad)+' errors, see copy text.' ;
    end ;
end;

{ TCopyCode }

procedure TCopyCode.Execute ;
var
  i: integer ;
  s: string ;
begin
  FreeOnTerminate := True ;
  Actual := '' ;
  {get a random phrase to send}
  s := GetPhrase(Trunc(Random(30))) ;
  {send the phrase one character at a time}
  for i := 1 to length(s) do
    begin
      If Terminated then Break ;
      SendChar(s[i]) ;
      {display the letter for a short time}
      Actual := Actual +'-' ;
      Synchronize(DispActual) ;
    end ;      
  Sleep(2500) ;
  Actual := s ;
  Synchronize(CompareActual) ;
end ;

end.
