<%@ Language="VBScript" %>
<html>
<body>
  <h2>파일 업로드</h2>
  <form method="post" action="upload_handler.asp" enctype="multipart/form-data">
    <input type="file" name="file"><br><br>
    <input type="submit" value="업로드">
  </form>
</body>
</html>