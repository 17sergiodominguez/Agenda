<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
String webAppRoot = System.getProperty( "catalina.base" );
String s = File.separator;
String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
String usersDir = configDir + s + "46302jeikHJSN";
String user = request.getParameter("user");
String aPassword = request.getParameter("actualPassword");
String nPassword = request.getParameter("newPassword");
String rAPassword = new BufferedReader(new FileReader(usersDir + s + user + s + "password.txt")).readLine();
if (rAPassword.equals(aPassword)){
    FileWriter pFile = new FileWriter(usersDir + s + user + s + "password.txt");
    pFile.write(nPassword);
    pFile.flush();
    pFile.close();
    out.print("OK <br>");
}
    out.print("rAPassword = " + rAPassword  + ", <br> aPassword = " + aPassword + ", <br> nPassword = " + nPassword + ",");
%>
<script>
setTimeout(function(){window.close()}, 1);
</script>
