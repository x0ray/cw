�
 TFORM1 0$  TPF0TForm1Form1Left#ToplCaptionCW TestClientHeight]ClientWidthkColor	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 	Icon.Data
�             �     (       @         �                        �  �   �� �   � � ��  ��� ���   �  �   �� �   � � ��  ���                                                                       	���           	�����         	�������        ��������       	���������      ����������     	�����������    	�� ��������    	�	�	�������    �����		�		��    �����		�		��    �����	���	��    �����	���	��    ��	� �������    	�� ���	����    	�����������    	�����������     ����������      	���������       ��������        	�������         	�����           	���                                                                                      ��������������������������  ��  �  ?�  �  �  �  �  �  �  �  �  �  �  �  ?�  �  ������������������������������OldCreateOrder	OnClose	FormCloseOnCreate
FormCreatePixelsPerInch`
TextHeight TShapeLightLefthTopWidth�HeightQBrush.ColorclYellow	Pen.Width ShapestRoundRectVisible  TLabelMsgLeft`TopHWidthHeight  TTabbedNotebookTabbedNotebook1LeftTopWidthYHeight� TabFont.CharsetDEFAULT_CHARSETTabFont.Color	clBtnTextTabFont.Height�TabFont.NameMS Sans SerifTabFont.Style TabOrder OnChangeTabbedNotebook1Change TTabPage LeftTopCaptionTest To Code TLabelCodeLeftTop`Width
HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont  TLabelCurPosLeftTopHWidth
HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont  TShapeShape1LeftTop@WidthAHeight9Brush.StylebsClear  TLabelLabel9LeftTopWidth�HeightCaption^Enter text below and then use the send button to generate the code and play it on the  speaker  TEditMsgTextLeftTop WidthAHeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder   TButton
SendButtonLeftTop� Width� HeightCaptionSend text as code nowTabOrderOnClickSendButtonClick  	TCheckBox
DcCheckBoxLeft�Top� WidthaHeightCaptionDisplay codeTabOrder  TButtonButton1LeftTop� Width� HeightCaptionCancel sending textTabOrderOnClickButton1Click   TTabPage LeftTopHelpContextCaptionUse Morse Key TLabelLabel10Left`TopHWidth� HeightCaption,NOTE:  Key in one character then wait half a  TLabelLabel11Left�TopXWidth� HeightCaption'second for the computer to identify the  TLabelLabel12Left�TophWidthPHeightCaptionkeyed character.  TButtonMorseKeyButtonLeftTopWidthAHeight� Caption,Use left mouse click over this button to keyFont.CharsetDEFAULT_CHARSET
Font.ColorclAquaFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontTabOrder OnMouseDownMorseKeyButtonMouseDown	OnMouseUpMorseKeyButtonMouseUp  	TGroupBox	GroupBox1LeftXTopWidth� Height1CaptionCharacter SentTabOrder TLabelDispCharLeftTopWidth
HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont    TTabPage LeftTopHelpContextCaptionCode Recognition TLabelLabel6LeftTopWidth� HeightCaption*Choose code group to send characters from:  TLabelDisplayCodeLeftTopPWidth
HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFont  TLabelAnswerLeftTop� WidthHeight  	TComboBoxCodeGroupBoxLeft� TopWidth� Height
ItemHeightTabOrder TextE,I,S.HOnChangeCodeGroupBoxChangeItems.StringsE,I,S,HT,M,O,RA,W,J,KU,V,F,LN,D,B,GC,Y,Q,XZ,P	1,2,3,4,5	6,7,8,9,0Punctuation  .  ,  ?  /Special  AS  BT  AR  VA  K   TButtonSendCharButtonLeftTopHWidth� HeightCaptionSend random characterTabOrderOnClickSendCharButtonClick  	TCheckBoxDisplayCodeCheckBoxLeft� TopPWidthaHeightCaptionDisplay CodeTabOrderOnClickDisplayCodeCheckBoxClick  	TGroupBox	GroupBox2LeftToppWidth9HeightACaptionIdentify character just sentTabOrder TButtonChoice1ButtonLeftTopWidthYHeightTabOrder OnClickChoice1ButtonClick  TButtonChoice2ButtonLeft� TopWidthYHeightTabOrderOnClickChoice2ButtonClick  TButtonChoice3ButtonLeft� TopWidthYHeightTabOrderOnClickChoice3ButtonClick  TButtonChoice4ButtonLeft`TopWidthYHeightTabOrderOnClickChoice4ButtonClick  TButtonChoice5ButtonLeft�TopWidthYHeightTabOrderOnClickChoice5ButtonClick   TButtonRepeatButtonLeftTopHWidth3HeightCaptionRepeatTabOrderOnClickRepeatButtonClick   TTabPage LeftTopHelpContextCaptionRandom Codes TLabel
LetterSentLeft� Top0WidthHeightoFont.CharsetANSI_CHARSET
Font.ColorclRedFont.Height�	Font.NameArial
Font.StylefsBold 
ParentFont  TShapeShape2LeftTopWidth�Height� Brush.StylebsClear  TButtonBeginSendingButtonLeft�TopWidth[HeightCaptionBegin SendingTabOrder OnClickBeginSendingButtonClick  TButtonStopSendingButtonLeft�Top� Width[HeightCaptionStop SendingTabOrderOnClickStopSendingButtonClick  	TCheckBoxSendTwiceCheckBoxLeft�Top0WidthIHeightCaption
Send twiceTabOrderOnClickSendTwiceCheckBoxClick   TTabPage LeftTopHelpContextCaption	Copy Text TLabelLabel13LeftTopWidth�HeightCaption^Use the send button to send a random text string, and key in the characters you recognize. If   TLabelLabel14LeftTopWidth�HeightCaption]you  do not recognize a character have a guess at it, as this will make the comparason at the  TLabelLabel15LeftTop(Width� HeightCaptionend of sending the text better.  TLabelLabel16LeftTopHWidth;HeightCaptionCopyed text:  TLabelLabel17LeftTophWidth5HeightCaptionActual text:  TLabelLabel18LeftTop� Width!HeightCaptionResult:  TLabelCorrectLabelLeftXTop� WidthHeight  TButtonCopySendButtonLeft�TopWidthKHeightCaption	Send textTabOrderOnClickCopySendButtonClick  TEditCopyEditLeftPTop@Width�HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontTabOrder   TEdit
ActualEditLeftPTop`Width�HeightFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	TabOrder  TButtonCopyStopButtonLeft�Top� WidthKHeightCaptionStop sendingTabOrderOnClickCopyStopButtonClick   TTabPage LeftTopHelpContextCaptionView All Codes TMemo	ViewCodesLeft@TopWidth�Height� Font.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameCourier New
Font.Style 
ParentFontReadOnly	
ScrollBars
ssVerticalTabOrder    TTabPage LeftTopHelpContextCaptionSet Options TLabelLabel1LeftTopWidthjHeightCaptionCharacters per minute:  TLabelLabel2LeftTop8Width� HeightCaptionInter character spacing (dits):  TLabelLabel3LeftTop`WidthsHeightCaptionInter word spacing (dits):  TLabelLabel4Left� Top8WidthLHeightCaption(default value 3)  TLabelLabel5Left� Top`WidthLHeightCaption(default value 5)  TLabelLabel7LeftTop� WidthqHeightCaptionSet tone (BFO freq)  Hz:  TLabelLabel8Left� Top� Width8HeightCaptionBNOTE: These settings are not saved at the end of this application.ColorclYellowParentColor  	TComboBoxCpmBoxLeft� TopWidthAHeight
ItemHeightTabOrder Text6OnChangeCpmBoxChangeItems.Strings3456789101112131415161718192021222324252627282930   	TComboBoxIcsBoxLeft� Top0WidthAHeight
ItemHeightTabOrderText3OnChangeIcsBoxChangeItems.Strings3456789   	TComboBoxIwsBoxLeft� TopXWidthAHeight
ItemHeightTabOrderText5OnChangeIwsBoxChangeItems.Strings5678910111213   	TComboBoxFreqBoxLeft� Top� WidthAHeight
ItemHeightTabOrderText1000OnChangeFreqBoxChangeItems.Strings40060080010001200140016001800200022002400260028003000   	TCheckBoxSendWithLightLeft�Top0WidthqHeightCaptionSend using lightTabOrderOnClickSendWithLightClick  	TCheckBoxSendWithSoundLeft�TopWidthyHeightCaptionSend using soundChecked	State	cbCheckedTabOrderOnClickSendWithSoundClick    TButton
ExitButtonLeftTop8WidthKHeightCaptionExitTabOrderOnClickExitButtonClick  TButton
HelpButtonLeftTopWidthKHeightCaptionHelpTabOrderOnClickHelpButtonClick  TButtonButton2LeftTop8WidthKHeightCaptionAboutTabOrderOnClickButton2Click   