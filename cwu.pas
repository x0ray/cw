///////////////////////////////////////////////////////////////////////////
// Project:   CW
// Program:   cwu.pas
// Language:  Object Pascal - Delphi ver 3.0
// Support:   David Fahey
// Date:      01Oct97
// Purpose:   Displays a dialog that allows the user to learn the
//            International Morse code.
// History:   01Oct97  Initial coding                              DAF
//            02Oct97  Modified code to work with Windows95 and NT DAF  
//            13Oct98  Rebuilt using Delphi Ver 4                  DAF    
//            13Oct98  Rebuilt using Delphi 2006                   DAF
// Notes:     None
///////////////////////////////////////////////////////////////////////////

unit cwu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Tabnotbk, beeperu, codedspu, codesndu, helpu, copycdeu,
  sendtxtu, aboutu, lightplu, ExtCtrls ;

const
  NCodes = 128 ;     {number of codes}
  dit = 1 ;          {duration of dit}
  dah = 3 ;          {duration of dah}

  AvgWdLen = 5 ;     {average word length (characters) }
  AvgCodeLen = 8 ;   {average code length (dits) }

type
  TForm1 = class(TForm)
    TabbedNotebook1: TTabbedNotebook;
    MsgText: TEdit;
    SendButton: TButton;
    Code: TLabel;
    CurPos: TLabel;
    ExitButton: TButton;
    Label1: TLabel;
    CpmBox: TComboBox;
    Label2: TLabel;
    IcsBox: TComboBox;
    Label3: TLabel;
    IwsBox: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    MorseKeyButton: TButton;
    GroupBox1: TGroupBox;
    DispChar: TLabel;
    ViewCodes: TMemo;
    CodeGroupBox: TComboBox;
    Label6: TLabel;
    SendCharButton: TButton;
    DisplayCodeCheckBox: TCheckBox;
    DisplayCode: TLabel;
    GroupBox2: TGroupBox;
    Answer: TLabel;
    Choice1Button: TButton;
    Choice2Button: TButton;
    Choice3Button: TButton;
    Choice4Button: TButton;
    Choice5Button: TButton;
    Label7: TLabel;
    FreqBox: TComboBox;
    Label8: TLabel;
    RepeatButton: TButton;
    Shape1: TShape;
    HelpButton: TButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DcCheckBox: TCheckBox;
    BeginSendingButton: TButton;
    LetterSent: TLabel;
    StopSendingButton: TButton;
    SendTwiceCheckBox: TCheckBox;
    Shape2: TShape;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    CopySendButton: TButton;
    CopyEdit: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    ActualEdit: TEdit;
    Label18: TLabel;
    CorrectLabel: TLabel;
    CopyStopButton: TButton;
    Button1: TButton;
    Button2: TButton;
    Light: TShape;
    SendWithLight: TCheckBox;
    SendWithSound: TCheckBox;
    Msg: TLabel;
                
    procedure DCode(sel: string; n: integer) ;
    function RCode(sel: string; n: integer):string ;
    procedure SendButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SendText(s: string) ;
    procedure ExitButtonClick(Sender: TObject);
    procedure CpmBoxChange(Sender: TObject);
    procedure IcsBoxChange(Sender: TObject);
    procedure IwsBoxChange(Sender: TObject);
    procedure MorseKeyButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MorseKeyButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FreqBoxChange(Sender: TObject);
    procedure SendCharButtonClick(Sender: TObject);
    procedure Choice1ButtonClick(Sender: TObject);
    procedure Choice2ButtonClick(Sender: TObject);
    procedure Choice3ButtonClick(Sender: TObject);
    procedure Choice4ButtonClick(Sender: TObject);
    procedure Choice5ButtonClick(Sender: TObject);
    procedure RepeatButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure CodeGroupBoxChange(Sender: TObject);
    procedure DisplayCodeCheckBoxClick(Sender: TObject);
    procedure BeginSendingButtonClick(Sender: TObject);
    procedure StopSendingButtonClick(Sender: TObject);
    procedure SendTwiceCheckBoxClick(Sender: TObject);
    procedure CopySendButtonClick(Sender: TObject);
    procedure CopyStopButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabbedNotebook1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure SendWithSoundClick(Sender: TObject);
    procedure SendWithLightClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  TCodes = array[1..128] of string ;  
  TSpecNames = array[1..5] of string ;

function RepStr(i:integer; c: char): string ;
function NTBeep(dwFreq, dwDuration: DWORD): BOOL; stdcall;
procedure MyBeep(dwFreq, dwDuration: DWORD) ;
procedure SendChar(c: char) ;

var
  Form1: TForm1;

  Codes: TCodes ;    {morse code sequence for characters}  
  freq:  integer ;   {frequency of sound}
  cpm:   integer ;   {characters per minute duration (m/s) }
  ics:   integer ;   {duration of inter character space}
  iws:   integer ;   {duration of inter word space}
  st:    integer ;   {morse key start time}       
  et:    integer ;   {morse key end time}

  {Global Variables}
  CodeStr: string ;  {current code string from morse key}
  CCode: string ;    {character code sent in code recognition}
  Letter: string ;   {character sent in random codes}
  Twice: boolean ;   {random codes sent twice}
  Actual: string ;   {copy code actual phrase}   
  DspText: string ;  {text to send for send text}
  DspChar: char ;    {sent char for send text}
  DspPos: integer ;  {current char pos for send text}
  LightOn: boolean ; {status of the light}
  SendSound: boolean ;  {send with sound}

  SpecNames: TSpecNames ;    {names of special characters}

  CodeDspStarted: boolean ;  {code display thread started flag}
  
  BeepThread: Beeper ;
  CodeDspThread: TCodeDsp ;
  CodeSendThread: TCodeSend ;
  CopyCodeThread: TCopyCode ;
  SendTextThread: TSendText ;  
  LightPolThread: TLightPol ;

  Win32Platform: Integer = 0;
  Win32MajorVersion: Integer = 0;
  Win32MinorVersion: Integer = 0;
  Win32BuildNumber: Integer = 0;

implementation

function NTBeep; external kernel32 name 'Beep';

{$R *.DFM}

function RepStr(i:integer; c: char): string ;
var j: integer ;
    s: string ;
begin
  s := '' ;
  for j := 1 to i do
    s := s + c ;
  result := s ;
end ;

procedure InitPlatformId ;
var
  OSVersionInfo: TOSVersionInfo ;
begin
  OSVersionInfo.dwOSVersionInfoSize := SizeOf(OSVersionInfo) ;
  if GetVersionEx(OSVersionInfo) then
    with OSVersionInfo do
    begin
      Win32Platform := dwPlatformId ;
      Win32MajorVersion := dwMajorVersion ;
      Win32MinorVersion := dwMinorVersion ;
      Win32BuildNumber := dwBuildNumber ;
    end ;
end ;

procedure StartSound(dwFreq: DWORD) ; 
const
  FOscillator = 1193180 ;
var
  freq: integer ;
  freqh,freql: byte ;
begin
  if SendSound then
    begin
      freq := dwFreq ;
      { massage the frequency for the 8254 chip }
      freq := FOscillator div freq ;
      freqh := freq div 256 ;
      freql := freq mod 256 ;
      { Start a tone on the 8254 timer chip }
      asm
        { set the frequency in the 8254 }
        mov al,10110110b    { counter 2, low-order and high-order counter byte }
                            { mode 3, binary counnting }
        out 43h,al          { write control register }
        mov al,freql        { transfer low-order counter byte to al }
        out 42h,al          { output low-order counter byte }
        mov al,freqh        { transfer high-order counter byte to al }
        out 42h,al          { output high-order counter byte }
        { turn on the speaker }
        in al,61h           { read old value of port B }
        or al,00000011b     { set bits 0 and 1, bits 2-7 unchanged }
        out 61h,al          { output byte with set bits 0 and 1 to port B }
      end ;
    end ;
end ;

procedure EndSound ;
begin   
  asm
    { turn off the speaker }
    in al,61h           { read old value of port B }
    and al,11111100b    { turn bits 0 and 1 off, bits 2-7 unchanged }
    out 61h,al          { output byte with cleared bits 0 and 1 to port B }
  end ;
end ;

procedure MyBeep(dwFreq, dwDuration: DWORD) ;
begin
  LightOn := True ;
  if Win32Platform = VER_PLATFORM_WIN32_NT then  { on windows NT }
    begin
      if SendSound then
        NTBeep(dwFreq,dwDuration)       { let winNT make a noise }
      else
        Sleep(dwDuration) ;     { do a system wait }
    end
  else  { on windows95... or win3.1 - we have to make the noise ourselves }
    begin  { ENTERING THE TWILIGHT ZONE }
      StartSound(dwFreq) ;
      Sleep(dwDuration) ;     { do a system wait }
      EndSound ;
    end ;
  LightOn := False ;
end ;

procedure SendChar(c: char) ;
var
  j: integer ; 
  mc: string ;
begin   
  mc := Codes[ord(c)] ;  {look up code for character}
  for j := 1 to length(mc) do
    begin
      if mc[j] = '-' then
        begin
          MyBeep(freq,dah*cpm) ;
          Sleep(dit*cpm) ;  {sleep after tone}
        end
      else if mc[j] = '.' then
        begin
          MyBeep(freq,dit*cpm) ;
          Sleep(dit*cpm) ;  {sleep after tone}
        end
      else
        Sleep(iws*cpm) ;    {sleep during inter word space}
    end ;
  Sleep(ics*cpm) ;  {sleep during inter character space}
end ;

procedure SendStr(s: string) ;
var
  i: integer ;
begin
  for i := 1 to length(s) do
    SendChar(s[i]) ;
end ;

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer ;
begin
  freq := 1000 ;  {initial frequency of sound}
  cpm := 60000 div (6*((AvgWdLen*AvgCodeLen)+1)) ; {chars/min duration (m/s) }
  ics := 3 ;   {duration of inter character space}
  iws := 5 ;   {duration of inter word space}
  CodeStr := '' ;
  CodeDspStarted := False ;
  Twice := False ;   
  SendSound := True ;   {send with sound}

  Codes[ord('a')] := '.-' ;
  Codes[ord('A')] := '.-' ;
  Codes[ord('b')] := '-...' ;
  Codes[ord('B')] := '-...' ;
  Codes[ord('c')] := '-.-.' ;
  Codes[ord('C')] := '-.-.' ;
  Codes[ord('d')] := '-..' ;
  Codes[ord('D')] := '-..' ;
  Codes[ord('e')] := '.' ;
  Codes[ord('E')] := '.' ;
  Codes[ord('f')] := '..-.' ;
  Codes[ord('F')] := '..-.' ;
  Codes[ord('g')] := '--.' ;
  Codes[ord('G')] := '--.' ;
  Codes[ord('h')] := '....' ;
  Codes[ord('H')] := '....' ;
  Codes[ord('i')] := '..' ;
  Codes[ord('I')] := '..' ;
  Codes[ord('j')] := '.---' ;
  Codes[ord('J')] := '.---' ;
  Codes[ord('k')] := '-.-' ;
  Codes[ord('K')] := '-.-' ;
  Codes[ord('l')] := '.-..' ;
  Codes[ord('L')] := '.-..' ;
  Codes[ord('m')] := '--' ;
  Codes[ord('M')] := '--' ;
  Codes[ord('n')] := '-.' ;
  Codes[ord('N')] := '-.' ;
  Codes[ord('o')] := '---' ;
  Codes[ord('O')] := '---' ;
  Codes[ord('p')] := '.--.' ;
  Codes[ord('P')] := '.--.' ;
  Codes[ord('q')] := '--.-' ;
  Codes[ord('Q')] := '--.-' ;
  Codes[ord('r')] := '.-.' ;
  Codes[ord('R')] := '.-.' ;
  Codes[ord('s')] := '...' ;
  Codes[ord('S')] := '...' ;
  Codes[ord('t')] := '-' ;
  Codes[ord('T')] := '-' ;
  Codes[ord('u')] := '..-' ;
  Codes[ord('U')] := '..-' ;
  Codes[ord('v')] := '...-' ;
  Codes[ord('V')] := '...-' ;
  Codes[ord('w')] := '.--' ;
  Codes[ord('W')] := '.--' ;
  Codes[ord('x')] := '-..-' ;
  Codes[ord('X')] := '-..-' ;
  Codes[ord('y')] := '-.--' ;
  Codes[ord('Y')] := '-.--' ;
  Codes[ord('z')] := '--..' ;
  Codes[ord('Z')] := '--..' ;
  Codes[ord('1')] := '.----' ;
  Codes[ord('2')] := '..---' ;
  Codes[ord('3')] := '...--' ;
  Codes[ord('4')] := '....-' ;
  Codes[ord('5')] := '.....' ;
  Codes[ord('6')] := '-....' ;
  Codes[ord('7')] := '--...' ;
  Codes[ord('8')] := '---..' ;
  Codes[ord('9')] := '----.' ;
  Codes[ord('0')] := '-----' ;
  Codes[ord('.')] := '.-.-.-' ;
  Codes[ord(',')] := '--..--' ;
  Codes[ord('?')] := '..--..' ;
  Codes[ord('/')] := '-..-.' ;

  {special codes are userping these characters}
  Codes[ord('[')] := '.-...' ;  {wait AS}
  Codes[ord('\')] := '-...-' ;  {pause BT}
  Codes[ord(']')] := '.-.-.' ;  {end of message AR}
  Codes[ord('^')] := '...-.-' ; {end of work VA}
  Codes[ord('_')] := '-.-' ;    {invitation to transmit K}

  SpecNames[1] := 'Wait-AS' ;
  SpecNames[2] := 'Pause-BT' ;
  SpecNames[3] := 'End message-AR' ;
  SpecNames[4] := 'End of work-VA' ;
  SpecNames[5] := 'Transmit-K' ;

  {blank character indicates inter word gap}
  Codes[ord(' ')] := ' ' ;

  {set up view codes memo area}
  for i := 1 to NCodes do
    begin
      if (Codes[i] <> '') and (Codes[i] <> ' ') and (i < ord('[')) then
        ViewCodes.Lines.Add(chr(i)+' = '+Codes[i]) ;
    end ;
  ViewCodes.Lines.Add('Wait (AS) = '+Codes[ord('[')]) ;
  ViewCodes.Lines.Add('Pause (BT) = '+Codes[ord('\')]) ;
  ViewCodes.Lines.Add('End of message (AR) = '+Codes[ord(']')]) ;
  ViewCodes.Lines.Add('End of work (VA) = '+Codes[ord('^')]) ;     
  ViewCodes.Lines.Add('Invitation to transmit (K) = '+Codes[ord('_')]) ;
  
  InitPlatformId ;  
  DCode('SEHI ',4) ;
  Randomize ;
end;

procedure TForm1.SendText(s: string) ;
var
  i: integer ;
  k: integer ;
  mc: string ;
begin
  k := length(s) ;
  for i := 1 to k do
    begin
      mc := Codes[ord(s[i])] ;  {look up code for character}
      if DcCheckBox.State = cbChecked then
        Code.Caption := s[i]+' = '+mc ;
      CurPOs.Caption := RepStr(i-1,'-')+s[i]+RepStr(k-i,'-') ;
      Form1.Update ;
      SendChar(s[i]) ;
    end ;
end ;

procedure TForm1.SendButtonClick(Sender: TObject);
begin
  Code.Caption := '' ;
  CurPOs.Caption := '' ;
  {start a thread to send the text}
  DspText := MsgText.Text ;
  SendTextThread := TSendText.Create(False) ;
end;

procedure TForm1.ExitButtonClick(Sender: TObject);
begin
  Form1.Close ;
end;

procedure TForm1.CpmBoxChange(Sender: TObject);
begin
  cpm := 60000 div (StrToInt(CpmBox.Text)*((AvgWdLen * AvgCodeLen)+1) ) ;
end;

procedure TForm1.IcsBoxChange(Sender: TObject);
begin
  ics := StrToInt(IcsBox.Text) ;
end;

procedure TForm1.IwsBoxChange(Sender: TObject);
begin
  iws := StrToInt(IwsBox.Text) ;
end;

procedure TForm1.MorseKeyButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Hour, Min, Sec, MSec: word ;
begin
  DecodeTime(Time,Hour,Min,Sec,MSec) ;
  st := (Sec*1000)+MSec ;
  
  if Win32Platform = VER_PLATFORM_WIN32_NT then  { on windows NT ?}
    BeepThread := Beeper.Create(False)   {WinNT}
  else
    begin
      if SendWithLight.State = cbChecked then
        LightOn := True ;
      StartSound(freq) ;                 {Win95}
    end ;

  if not(CodeDspStarted) then
    begin
      CodeDspStarted := True ;
      CodeStr := '' ;
      CodeDspThread := TCodeDsp.Create(False) ;
    end ;
end;

procedure TForm1.MorseKeyButtonMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Hour, Min, Sec, MSec: word ;
  ft: integer ;
begin
  DecodeTime(Time,Hour,Min,Sec,MSec) ;
  et := (Sec*1000)+MSec ;

  if Win32Platform = VER_PLATFORM_WIN32_NT then  { on windows NT ?}
    BeepThread.Terminate  {WinNT}
  else
    begin  
      if SendWithLight.State = cbChecked then
        LightOn := False ;
      EndSound ;          {Win95}
    end ;

  if st <= et then
    ft := et - st
  else
    ft := et + (60000 - st) ;
  if ft > (2*cpm) then   {dah}
    CodeStr := CodeStr + '-'
  else {dit}      
    CodeStr := CodeStr + '.' ;
  DispChar.Caption := CodeStr ;
end;

procedure TForm1.FreqBoxChange(Sender: TObject);
begin 
  freq := StrToInt(FreqBox.Text) ;
end;

procedure TForm1.DCode(sel: string; n: integer) ;
var
  i: integer ;
  p: integer ;
begin     
  Choice1Button.Caption := '' ;
  Choice2Button.Caption := '' ;
  Choice3Button.Caption := '' ;
  Choice4Button.Caption := '' ;
  Choice5Button.Caption := '' ;
  for i := 1 to n do
    begin
      p := ord(sel[i]) - ord('[') + 1 ;
      if (p >= 1) and (p <= 5) then  {its a special character}
        begin
          case i of
            1: Choice1Button.Caption := SpecNames[p] ;
            2: Choice2Button.Caption := SpecNames[p] ;
            3: Choice3Button.Caption := SpecNames[p] ;
            4: Choice4Button.Caption := SpecNames[p] ;
            5: Choice5Button.Caption := SpecNames[p] ;
          end ;
        end
      else
        begin
          case i of
            1: Choice1Button.Caption := copy(sel,1,1) ;
            2: Choice2Button.Caption := copy(sel,2,1) ;
            3: Choice3Button.Caption := copy(sel,3,1) ;
            4: Choice4Button.Caption := copy(sel,4,1) ;
            5: Choice5Button.Caption := copy(sel,5,1) ;
          end ;
        end ;
    end ;
end ;

function TForm1.RCode(sel: string; n: integer):string ;
var
  cc: string ;
  i: integer ;
begin
  i := Trunc(Random(n+1)) ;
  cc := copy(sel,i,1) ;
  {start a thread to send the randomly selected character}
  DspText := cc ;
  SendTextThread := TSendText.Create(False) ;
  {return randomly selected character}
  result := cc ;
end ;

procedure TForm1.SendCharButtonClick(Sender: TObject);
begin  
  Choice1Button.Enabled := True ;
  Choice2Button.Enabled := True ;
  Choice3Button.Enabled := True ;
  Choice4Button.Enabled := True ;
  Choice5Button.Enabled := True ;
  Answer.Caption := '' ;
  Randomize ;

  if CodeGroupBox.Text[1] = 'E' then
    CCode := RCode('SEHI ',4)
  else if CodeGroupBox.Text[1] = 'T' then
    CCode := RCode('TMOR ',4)
  else if CodeGroupBox.Text[1] = 'A' then
    CCode := RCode('AWJK ',4)
  else if CodeGroupBox.Text[1] = 'U' then
    CCode := RCode('UVFL ',4)
  else if CodeGroupBox.Text[1] = 'N' then
    CCode := RCode('NDBG ',4)
  else if CodeGroupBox.Text[1] = 'C' then
    CCode := RCode('CYQX ',4)
  else if CodeGroupBox.Text[1] = 'Z' then
    CCode := RCode('ZP   ',2)
  else if CodeGroupBox.Text[1] = '1' then
    CCode := RCode('12345',5)
  else if CodeGroupBox.Text[1] = '6' then
    CCode := RCode('67890',5)
  else if CodeGroupBox.Text[1] = 'P' then  {punctuation}
    CCode := RCode('.,?/ ',4)
  else if CodeGroupBox.Text[1] = 'S' then  {special codes}
    CCode := RCode('[\]^_',5) ;

  if cbChecked = DisplayCodeCheckBox.State then
    DisplayCode.Caption := 'Code: '+Codes[ord(CCode[1])]
  else
    DisplayCode.Caption := '' ;
end;

function Ans(cb,cc: string): string ;
var
  p: integer ;
begin   
  p := ord(cc[1]) - ord('[') + 1 ;
  if (p >= 1) and (p <= 5) then  {last char was a special character}
    begin
      if cb = SpecNames[p] then
        result := 'Correct'
      else   
        result := 'Wrong, code was '+SpecNames[p]+', try another.'
    end
  else   {last char was an ascii char}
    begin
      if cb = cc then
        result := 'Correct'
      else
        result := 'Wrong, code was '+cc+', try another.' ;
    end ;
end ;

procedure TForm1.Choice1ButtonClick(Sender: TObject);
begin
  Answer.Caption := Ans(Choice1Button.Caption,CCode) ;
end;

procedure TForm1.Choice2ButtonClick(Sender: TObject);
begin
  Answer.Caption := Ans(Choice2Button.Caption,CCode) ;
end;

procedure TForm1.Choice3ButtonClick(Sender: TObject);
begin
  Answer.Caption := Ans(Choice3Button.Caption,CCode) ;
end;

procedure TForm1.Choice4ButtonClick(Sender: TObject);
begin                                          
  Answer.Caption := Ans(Choice4Button.Caption,CCode) ;
end;

procedure TForm1.Choice5ButtonClick(Sender: TObject);
begin                                    
  Answer.Caption := Ans(Choice5Button.Caption,CCode) ;
end;

procedure TForm1.RepeatButtonClick(Sender: TObject);
begin           
  SendStr(CCode) ;
end;

procedure TForm1.HelpButtonClick(Sender: TObject);
begin
  Help.ShowModal ;
end;

procedure TForm1.CodeGroupBoxChange(Sender: TObject);
begin
  if CodeGroupBox.Text[1] = 'E' then
    DCode('SEHI ',4)
  else if CodeGroupBox.Text[1] = 'T' then
    DCode('TMOR ',4)
  else if CodeGroupBox.Text[1] = 'A' then
    DCode('AWJK ',4)
  else if CodeGroupBox.Text[1] = 'U' then
    DCode('UVFL ',4)
  else if CodeGroupBox.Text[1] = 'N' then
    DCode('NDBG ',4)
  else if CodeGroupBox.Text[1] = 'C' then
    DCode('CYQX ',4)
  else if CodeGroupBox.Text[1] = 'Z' then
    DCode('ZP   ',2)
  else if CodeGroupBox.Text[1] = '1' then
    DCode('12345',5)
  else if CodeGroupBox.Text[1] = '6' then
    DCode('67890',5)
  else if CodeGroupBox.Text[1] = 'P' then  {punctuation}
    DCode('.,?/ ',4)
  else if CodeGroupBox.Text[1] = 'S' then  {special codes}
    DCode('[\]^_',5) ;

  DisplayCode.Caption := '' ;
  Answer.Caption := '' ;
end;

procedure TForm1.DisplayCodeCheckBoxClick(Sender: TObject);
begin
  if cbChecked = DisplayCodeCheckBox.State then
    DisplayCode.Caption := 'Code: '+Codes[ord(CCode[1])]
  else
    DisplayCode.Caption := '' ;
end;

procedure TForm1.BeginSendingButtonClick(Sender: TObject);
begin
  CodeSendThread := TCodeSend.Create(False) ;
end;

procedure TForm1.StopSendingButtonClick(Sender: TObject);
begin
  CodeSendThread.Terminate ;
end;

procedure TForm1.SendTwiceCheckBoxClick(Sender: TObject);
begin
  if SendTwiceCheckBox.State = cbChecked then
    Twice := True
  else
    Twice := False ;
end;

procedure TForm1.CopySendButtonClick(Sender: TObject);
begin
  CopyEdit.Text := '' ;
  ActualEdit.Text := '' ;
  CorrectLabel.Caption := '' ;
  CopyCodeThread := TCopyCode.Create(False) ;
end;

procedure TForm1.CopyStopButtonClick(Sender: TObject);
begin
  CopyCodeThread.Terminate ;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SendTextThread.Terminate ;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  About.ShowModal ;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then  { Not windows NT ?}
    EndSound ;    {On Win95, do just in case}
end;

procedure TForm1.TabbedNotebook1Change(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
  Choice1Button.Enabled := False ;
  Choice2Button.Enabled := False ;
  Choice3Button.Enabled := False ;
  Choice4Button.Enabled := False ;
  Choice5Button.Enabled := False ;
end;

procedure TForm1.SendWithSoundClick(Sender: TObject);
begin
  if SendWithSound.State = cbChecked then
    SendSound := True
  else
    SendSound := False ;
end;

procedure TForm1.SendWithLightClick(Sender: TObject);
begin
  if SendWithLight.State = cbChecked then
    LightPolThread := TLightPol.Create(False)
  else
    LightPolThread.Terminate ;
end;

end.
  