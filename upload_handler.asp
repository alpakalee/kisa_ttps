<%@ Language=VBScript %>
<%
' 웹루트 안 uploads 폴더
Dim savePath
savePath = Server.MapPath("uploads")

' 업로드된 바이너리 전체 읽기
Dim binData
binData = Request.BinaryRead(Request.TotalBytes)

' 바이너리를 텍스트로 변환
Dim stream, body
Set stream = Server.CreateObject("ADODB.Stream")
stream.Type = 1 ' binary
stream.Open
stream.Write binData
stream.Position = 0
stream.Type = 2 ' text
stream.Charset = "iso-8859-1"
body = stream.ReadText
stream.Close
Set stream = Nothing

' boundary 추출
Dim boundary
boundary = "--" & Split(Request.ServerVariables("CONTENT_TYPE"), "boundary=")(1)

' 파일 시작 부분 추출
Dim parts, i
parts = Split(body, boundary)
For i = 0 To UBound(parts)
  If InStr(parts(i), "filename=") > 0 Then
    ' 원본 파일명
    Dim filename
    filename = Trim(Mid(parts(i), InStr(parts(i), "filename=")+9))
    filename = Replace(filename, """", "")
    If InStrRev(filename, "\") > 0 Then filename = Mid(filename, InStrRev(filename, "\") + 1)
    
    ' 파일 데이터 추출
    Dim dataStart, dataEnd, fileContent
    dataStart = InStr(parts(i), vbCrLf & vbCrLf) + 4
    fileContent = Mid(parts(i), dataStart)
    fileContent = Left(fileContent, Len(fileContent) - 2) ' \r\n 제거

    ' 저장
    Set stream = Server.CreateObject("ADODB.Stream")
    stream.Type = 2
    stream.Charset = "iso-8859-1"
    stream.Open
    stream.WriteText fileContent
    stream.Position = 0
    stream.Type = 1
    stream.SaveToFile savePath & "\" & filename, 2
    stream.Close
    Set stream = Nothing

    Response.Write "업로드 완료: " & filename
    Response.End
  End If
Next

Response.Write "업로드 실패"
%>
