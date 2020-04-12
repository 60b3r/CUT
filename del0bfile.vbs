Option Explicit

If (WScript.Arguments.Count <> 1) Then
   WScript.Echo("Usage: cscript DeleteEmptyFolders.vbs {path}")
   WScript.Quit(1)
End If

Dim strPath : strPath = WScript.Arguments(0)
Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")
Dim objFolder : Set objFolder = fso.GetFolder(strPath)
Dim sDelList, sDelErr, sFilePath
Dim iCnt
iCnt = 0

DeleteZeroByteFiles objFolder

Sub DeleteZeroByteFiles(folder)
   Dim subfolder, file

   On Error Resume Next
   'Skip errors when accessing Junctions, etc.
   For Each subfolder In folder.SubFolders
      DeleteZeroByteFiles subfolder
   Next
   On Error Goto 0
   
   For Each file In folder.files
      If file.size = 0 Then
      sFilePath = file.Path
      On Error Resume Next
      fso.DeleteFile file, True
      If Err.number <> 0 Then
         sDelErr = sDelErr & Err.number & ": " & Err.description & _
         	vbCrLf & sFilePath & vbCrLf & vbCrLf
      Else
         sDelList = sDelList & vbCrLf & sFilePath
	 iCnt  = iCnt + 1
      End If		
      On Error Goto 0
   End If	
   Next
End Sub

If sDelList = "" And sDelErr = "" Then
   WScript.Echo "No Empty files found under the " & _
	"""" & strPath & """" & " tree"
   WScript.Quit
End If

If sDelList <> "" then sDelList = "List of empty files deleted" & vbCrLf _
   & String(38,"-") & vbCrLf & sDelList & vbCrLf & _
	vbCrLf  & "Total: " & iCnt & " files deleted."

If sDelErr <> "" then sDelErr = "These files could not be deleted" & _
   vbCrLf & String(45,"-") & vbCrLf & sDelErr

WScript.Echo sDelList & vbCrLf & vbCrLf & sDelErr