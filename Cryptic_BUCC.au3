#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Crypt.au3>

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=
Global $Form1 = GUICreate("Tanjim Reza ", 361, 180, -1, -1)
GUISetBkColor(0xA6CAF0)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
Global $Label1 = GUICtrlCreateLabel("  Cryptic_BUCC ", 87, 24, 176, 29, $SS_CENTER)
GUICtrlSetFont(-1, 16, 800, 0, "Georgia")
GUICtrlSetColor(-1, 0x000000)
GUICtrlSetBkColor(-1, 0xE3E3E3)
GUICtrlSetCursor (-1, 4)
GUICtrlSetOnEvent(-1, "Label1Click")
Global $Input1 = GUICtrlCreateInput("Enter your MasterKey", 65, 72, 225, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
GUICtrlSetOnEvent(-1, "Input1Change")
Global $Button1 = GUICtrlCreateButton("Encrypt", 48, 104, 113, 49)
GUICtrlSetFont(-1, 11, 800, 0, "Century Schoolbook")
GUICtrlSetBkColor(-1, 0x3FC04F)
GUICtrlSetOnEvent(-1, "Button1Click")
Global $Button2 = GUICtrlCreateButton("Decrypt", 194, 104, 113, 49)
GUICtrlSetFont(-1, 11, 800, 0, "Century Schoolbook")
GUICtrlSetBkColor(-1, 0xF55C4B)
GUICtrlSetOnEvent(-1, "Button2Click")
GUISetState(@SW_SHOW)
_Clear_Input()
#EndRegion ### END Koda GUI section ###

While 1
	Sleep(100)
WEnd

Func Button1Click()
   Local $phrase = InputBox("Encrypt text","Enter text to encrypt using your MasterKey.","","",300,180)
   Local $masterkey = GUICtrlRead($Input1)
   Local $dEncrypted = StringEncrypt(True, $phrase, $masterkey)
   MsgBox(0,"Encrypted Data:", $dEncrypted)
   ClipPut($dEncrypted)
   MsgBox(0,"Copied to Clipboard", "The Data has been copied to Clipboard. Save it somewhere.")
   GUICtrlSetData($Input1, "Encryption Completed!")


EndFunc
Func Button2Click()
   Local $masterkey = GUICtrlRead($Input1)
   Local $phrase = InputBox("Decrypt text","Enter Encrypted data to decrypt using your MasterKey.","","",300,180)
   Local $sDecrypted = StringEncrypt(False, $phrase, $masterkey)
   MsgBox($MB_SYSTEMMODAL, 'Decrypted Data', $sDecrypted)
   ClipPut($sDecrypted)
   MsgBox(0,"Copied to Clipboard", "Decrypted data has been copied to clipboard!")
   GUICtrlSetData($Input1, "Decryption Completed!")

EndFunc
Func Form1Close()
   Exit

EndFunc
Func Form1Maximize()

EndFunc
Func Form1Minimize()

EndFunc
Func Form1Restore()

EndFunc
Func Input1Change()

EndFunc
Func Label1Click()

EndFunc
Func _Clear_Input()

    GUISetState()

    While 1

        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                Exit
        EndSwitch

       Global $aInfo = GUIGetCursorInfo($Form1)
        If $aInfo[2] Then
            If $aInfo[4] = $Input1 Then GUICtrlSetData($Input1, "")

        EndIf

    WEnd

EndFunc;==>_Clear_Input


Func StringEncrypt($bEncrypt, $sData, $sPassword)
    _Crypt_Startup() ; Start the Crypt library.
    Local $vReturn = ''
    If $bEncrypt Then ; If the flag is set to True then encrypt, otherwise decrypt.
        $vReturn = _Crypt_EncryptData($sData, $sPassword, $CALG_RC4)
    Else
        $vReturn = BinaryToString(_Crypt_DecryptData($sData, $sPassword, $CALG_RC4))
    EndIf
    _Crypt_Shutdown() ; Shutdown the Crypt library.
    Return $vReturn
EndFunc   ;==>StringEncrypt

