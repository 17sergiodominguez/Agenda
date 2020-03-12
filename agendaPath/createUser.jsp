<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ page import="java.util.*" %>
<%!
public boolean comproveUP(String user, String password) {
if (user != null &&password != null){
    if (user.equals("Root")&&password.equals("sa3666sa")){
        return true;
    } else {
        return false;
    }
} else {
    return false;  
}
}
%>
<%!
public void doedTasksSetter(String userDir, String configDir, ArrayList<String> categories, String user) throws FileNotFoundException, IOException{
    String s = File.separator;
    String newLine = System.lineSeparator();
    String tasksDir = configDir + s + "tasques";
    String doedDir = userDir + s + "done.txt";
    File tasksFile = new File(tasksDir);
    ArrayList<String> tasksNames = new ArrayList<String>(Arrays.asList(tasksFile.list()));
    Date dateObj = new Date();
    String date= new SimpleDateFormat("yyyy-MM-dd").format(dateObj);
    FileWriter doedWrite = new FileWriter(doedDir);
    for (int i = 0; i < tasksNames.size(); i++){
     BufferedReader readTask = new BufferedReader(new FileReader(tasksDir + s + tasksNames.get(i)));
     readTask.readLine();
     readTask.readLine();
     readTask.readLine();
     String taskDate = readTask.readLine();
     if (taskDate.compareTo(date) < 0){
         doedWrite.write(tasksNames.get(i) + newLine);
     }
    }
    doedWrite.flush();
    doedWrite.close();
    
}
%>
<%!
public Boolean isNotNull(String s){
    return s != null;
}
%>
<%
String webAppRoot = System.getProperty( "catalina.base" );
String s = File.separator;
String newLine = System.lineSeparator();
String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
String usersDir = configDir + s + "46302jeikHJSN";
String user = request.getParameter("user");
String password = request.getParameter("password");
String nUser = request.getParameter("nUser");
String nPassword = request.getParameter("nPassword");
Boolean doed = isNotNull(request.getParameter("doed"));
Boolean Privat = isNotNull(request.getParameter("Privat"));
Boolean trA = isNotNull(request.getParameter("3rA"));
Boolean Alemany3r = isNotNull(request.getParameter("Alemany3r"));
Boolean prD = isNotNull(request.getParameter("1rD"));
if (comproveUP(user, password)){
String nUserDir = usersDir + s + nUser;
File nUserFile = new File (nUserDir);
if (nUserFile.mkdirs()){
    String pDir = nUserDir + s + "password.txt";
    FileWriter pWrite = new FileWriter(pDir);
    pWrite.write(nPassword);
    pWrite.flush();
    pWrite.close();
    ArrayList<String> categories = new ArrayList<String>();
    if (Privat) {
        categories.add("Privat");
    }
    if (trA) {
        categories.add("3rA");
    }
    if (Alemany3r) {
        categories.add("Alemany3r");
    }
    if (prD) {
        categories.add("1rD");
    }
    String cDir = nUserDir + s + "categories.txt";
    FileWriter cWriter = new FileWriter(cDir);
    if (categories.size() != 0){
        cWriter.write(categories.get(0));
    }
    for (int i = 1; i<categories.size(); i++){
        cWriter.write(newLine + categories.get(i));
    }
    cWriter.flush();
    cWriter.close();
    doedTasksSetter(nUserDir, configDir, categories, nUser);
} else {%>
    <script>
    alert("User is alredy created");
    </script>
<%}



} else {%>
    <script>
    window.onload = function(){
        alert("Please, fill with the correct user and password to create users");
    };
    </script>
<%}
%>
<h1>Create new users</h1>
<form method = post>
User: <input name = user value = '<%=user%>'><br>
Password: <input name = password type = password value = '<%=password%>'><br>
User to create: <input name = nUser><br>
Password of the new user: <input name = nPassword value = 12345 type = password><br>
<input type = checkbox checked = true name = doed value = true>All the previus task is doed.<br>
Categories:<br><br>
<input type = checkbox checked = true name = Privat value = true>Private<br>
<input type = checkbox name = 3rA value = true>3r A<br>
<input type = checkbox name = Alemany3r value = true>Alemany 3r<br>
<input type = checkbox name = 1rD value = true>1r D<br>
<input type = submit value = "Create user">
</form>

