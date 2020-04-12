Option Explicit

If (WScript.Arguments.Count <> 1) Then
   WScript.Echo("Usage: cscript DeleteEmptyFolders.vbs {path}")
   WScript.Quit(1)
End If

Dim strPath : strPath = WScript.Arguments(0)
Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")
Dim objFolder : Set objFolder = fso.GetFolder(strPath)
Dim sDelList, sDelErr, sFolderPath
Dim iCnt
iCnt = 0

DeleteEmptyFolders objFolder

Sub DeleteEmptyFolders(folder)
   Dim subfolder

   On Error Resume Next
   'Skip errors when accessing Junctions, etc.
   For Each subfolder In folder.SubFolders
      DeleteEmptyFolders subfolder
   Next
   On Error Goto 0
   
   If folder.SubFolders.Count = 0 And folder.Files.Count = 0 Then
      sFolderPath = folder.Path
      On Error Resume Next
      fso.DeleteFolder folder.Path, True
      If Err.number <> 0 Then
         sDelErr = sDelErr & Err.number & ": " & Err.description & _
            vbCrLf & sFolderPath & vbCrLf & vbCrLf
      Else
         sDelList = sDelList & vbCrLf & sFolderPath
     iCnt  = iCnt + 1
      End If        
      On Error Goto 0
   End If    
End Sub

If sDelList = "" And sDelErr = "" Then
   WScript.Echo "No Empty folders found under the " & _
    """" & strPath & """" & " tree"
   WScript.Quit
End If

If sDelList <> "" then sDelList = "List of empty folders deleted" & vbCrLf _
   & String(38,"-") & vbCrLf & sDelList & vbCrLf & _
    vbCrLf  & "Total: " & iCnt & " folders deleted."

If sDelErr <> "" then sDelErr = "These folders could not be deleted" & _
   vbCrLf & String(45,"-") & vbCrLf & sDelErr

WScript.Echo sDelList & vbCrLf & vbCrLf & sDelErr