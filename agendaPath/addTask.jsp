<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
public String proposedName(int pN) {
    int cifras = 5;
    String proposedName = "";
    int length = String.valueOf(pN).length();
    for (int i = 0; i < cifras - length; i++) {
        proposedName += "0";
    }
    proposedName += String.valueOf(pN);
    proposedName += ".txt";
    return proposedName;
} 
%><%!
public Boolean searchStrInArrayList(ArrayList<String> arr, String str) {
    for (int i = 0; i < arr.size(); i++) {
        if (arr.get(i).equals(str)){
            return true;
        }
    }
    return false;
}
%>
<%!
public String createTaskName(ArrayList<String> tasquesNames){
    int proposedNum = 0;
    while (searchStrInArrayList(tasquesNames, proposedName(proposedNum))){
        proposedNum++;
    }
    return proposedName(proposedNum);
}
%>
<%
String webAppRoot = System.getProperty( "catalina.base" );
String s = File.separator;
String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
String usersDir = configDir + s + "46302jeikHJSN";
String tasquesDir = configDir + s + "tasques";
String categoriesDir = configDir + s + "categories";
File users = new File(usersDir);
String[] usersList = users.list();
String user = request.getParameter("user");
String password = request.getParameter("password");
String titul = request.getParameter("titul");
String categoria = request.getParameter("categoria");
String data = request.getParameter("data");
String comentaris = request.getParameter("comentaris");
File tasquesDirFile = new File(tasquesDir);
ArrayList<String> tasquesNames = new ArrayList<String>(Arrays.asList(tasquesDirFile.list()));
Collections.sort(tasquesNames);

%><%=createTaskName(tasquesNames)%><%


Boolean userExist = false;
int i = 0;
while (i != usersList.length){
    if (usersList[i].equals(user)){
        userExist = true;
        break;
    } else {
        i++;
    }
}
Boolean userIsDir = false;
if (userExist) {
File userDir = new File(usersDir + s + user);
userIsDir = userDir.isDirectory();
//out.print("<br> " + user + " is a directory?: " + String.valueOf(userIsDir));
} else {
//out.print("<br> " + user + " is a directory?: " + String.valueOf(userIsDir));
}
if (userIsDir) {
String userRealPassword;
userRealPassword = new BufferedReader(new FileReader(usersDir + s + user + s + "password.txt")).readLine();
if (password.equals(userRealPassword)) {
String categoriesFilePlace = usersDir + s + user + s + "categories.txt";
BufferedReader categoriesRead = new BufferedReader(new FileReader(categoriesFilePlace));
String strCurrentLine;
ArrayList<String> categories = new ArrayList<String>();
while ((strCurrentLine = categoriesRead.readLine()) != null) {    
categories.add(strCurrentLine);
}
Boolean categoriaIsAllowed = false;
%>
OK, allowed categories:
<%for (int e = 0; e < categories.size(); e++) {%>
<br>
<% if (categoria.equals(categories.get(e))) {
    categoriaIsAllowed = true;
    out.print("This: ");
   }%>
<%=categories.get(e)%>
<%}%>
<%for (int e = 0; e < tasquesNames.size(); e++) {%>
<br>
<%=tasquesNames.get(e)%>
<%}%>
<h1 style = "display:inline;">Tasca</h1>{
<br>Titul<%=titul%>
<br><%=categoria%>
<br><%=data%>
<br><%=comentaris%>
<%
if (categoriaIsAllowed){
    String tascaName = createTaskName(tasquesNames);
    String tascaPlace = tasquesDir + s + tascaName;
    File tascaFile = new File(tascaPlace);
    tascaFile.createNewFile();
    String newLine = System.lineSeparator();
    FileWriter tascaFileWrite = new FileWriter(tascaFile);
    if(categoria.equals("Privat")){
        tascaFileWrite.write(user + newLine);
    } else {
        tascaFileWrite.write(categoria + newLine);
    }
    tascaFileWrite.write(user + newLine);
    tascaFileWrite.write(titul + newLine);
    tascaFileWrite.write(data + newLine);
    tascaFileWrite.write(comentaris);
    tascaFileWrite.flush();
    tascaFileWrite.close();
    %><%=tascaName%><%
}}}%>
<script>
setTimeout(function() {window.close();}, 1);
</script>
