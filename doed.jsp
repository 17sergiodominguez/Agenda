<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
public void addTaskToList(String user, String password, String taskToSet) throws FileNotFoundException, IOException {
    String webAppRoot = System.getProperty( "catalina.base" );
    String s = File.separator;
    String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
    String usersDir = configDir + s + "46302jeikHJSN";
    String userDir = usersDir + s + user;
    String doneFileDir = userDir + s + "done.txt";
    ArrayList<String> ActualDone = new ArrayList<String>();
    BufferedReader readDoneFile = new BufferedReader(new FileReader(doneFileDir));
    String readStrHelp;
        while ((readStrHelp = readDoneFile.readLine()) != null){
            ActualDone.add(readStrHelp);
        }
    String newLine = System.lineSeparator();
    FileWriter doneFileWriter = new FileWriter(doneFileDir);
    doneFileWriter.write(taskToSet);
    for (int i = 0; i < ActualDone.size(); i++){
        doneFileWriter.write(newLine + ActualDone.get(i));
    }
    doneFileWriter.flush();
    doneFileWriter.close();
}
%>
<%!
public void deleteTaskFromList(String user, String password, String taskToSet) throws FileNotFoundException, IOException {
    String webAppRoot = System.getProperty( "catalina.base" );
    String s = File.separator;
    String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
    String usersDir = configDir + s + "46302jeikHJSN";
    String userDir = usersDir + s + user;
    String doneFileDir = userDir + s + "done.txt";
    ArrayList<String> ActualDone = new ArrayList<String>();
    BufferedReader readDoneFile = new BufferedReader(new FileReader(doneFileDir));
    String readStrHelp;
        while ((readStrHelp = readDoneFile.readLine()) != null){
            ActualDone.add(readStrHelp);
        }
    ActualDone.remove(taskToSet);
    String newLine = System.lineSeparator();
    FileWriter doneFileWriter = new FileWriter(doneFileDir);
    if(ActualDone.size() != 0){doneFileWriter.write(ActualDone.get(0));}
    for (int i = 1; i < ActualDone.size(); i++){
        doneFileWriter.write(newLine + ActualDone.get(i));
    }
    doneFileWriter.flush();
    doneFileWriter.close();
}
%>
<%
String user = request.getParameter("user");
String password = request.getParameter("password");
String taskToSet = request.getParameter("taskToSet");
String action = request.getParameter("action");
if (action.equals("add")){
    addTaskToList(user, password, taskToSet);
} else if (action.equals("delete")){
    deleteTaskFromList(user, password, taskToSet);
}
%>
User: <%=request.getParameter("user")%><br>
Password: <%=request.getParameter("password")%><br>
Tasca: <%=request.getParameter("taskToSet")%><br>
Acci&oacute: <%=request.getParameter("action")%>
<script>
setTimeout(function() {window.close();}, 1);
</script>