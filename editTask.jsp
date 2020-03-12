<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
String webAppRoot = System.getProperty( "catalina.base" );
String s = File.separator;
String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
String usersDir = configDir + s + "46302jeikHJSN";
String tasquesDir = configDir + s + "tasques";
String categoriesDir = configDir + s + "categories";
String user = request.getParameter("user");
String password = request.getParameter("password");
String titul = request.getParameter("titul");
String categoria = request.getParameter("categoria");
String data = request.getParameter("data");
String comentaris = request.getParameter("comentaris");
String taskToEditName = request.getParameter("taskToEdit");
String userRealPassword = new BufferedReader(new FileReader(usersDir + s + user + s + "password.txt")).readLine();
String taskToEditDir = tasquesDir + s + taskToEditName;
String newLine = System.lineSeparator();
BufferedReader readTaskToEdit = new BufferedReader(new FileReader(taskToEditDir));
readTaskToEdit.readLine();
String autor = readTaskToEdit.readLine();
if (autor.equals(user) && userRealPassword.equals(password)){
FileWriter tascaFileWrite = new FileWriter(taskToEditDir);
tascaFileWrite.write(categoria + newLine);
tascaFileWrite.write(user + newLine);
tascaFileWrite.write(titul + newLine);
tascaFileWrite.write(data + newLine);
tascaFileWrite.write(comentaris);
tascaFileWrite.flush();
tascaFileWrite.close();
   %>
   <script>
setTimeout(function() {window.close();}, 1);
</script>
   <% 
} else {
   %>L'autor i el editor no &eacutes la mateixa persona. Nom&eacutes pot editar les tasques l'autor. <br>Si estas aqu&iacute per error, <a href = "mailto:agendaColaborativaSDoAl@gmail.com?Subject=Error%20en%20agenda_editar_tasca" target = "_blank"> envia un mail a agendaColaborativaSDoAl@gmail.com y explica com has entrat </a>. Gracias per ajudar a millorar l'ajenda.<% 
}%>