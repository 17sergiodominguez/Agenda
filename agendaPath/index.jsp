<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
public class TascaClass {
    private String user;
    private String name;
    private String categoria;
    private String autor;
    private String titul;
    private String data;
    private String comentaris;
    private Boolean doed = false;
    private Boolean allowed;
    TascaClass(String categoria, String autor, String user, String titul, String data, String comentaris, ArrayList<String> categories) throws FileNotFoundException, IOException{
        this.categoria = categoria;
        this.autor = autor;
        this.titul = titul;
        this.data = data;
        this.comentaris = comentaris;
        this.allowed = user.equals(categoria);
        for (int i = 0; i < categories.size(); i++){
            if (categoria.equals(categories.get(i))){
                this.allowed = true;
            }
        }
    }
    TascaClass(String user, String tascaLocation, ArrayList<String> categories) throws FileNotFoundException, IOException{
        this.name = new File(tascaLocation).getName();
        BufferedReader readTasca = new BufferedReader(new FileReader(tascaLocation));
        this.user = user;
        this.categoria = readTasca.readLine();
        this.autor = readTasca.readLine();
        this.titul = readTasca.readLine();
        this.data = readTasca.readLine();
        this.comentaris = readTasca.readLine();
        this.allowed = user.equals(this.categoria);
        for (int i = 0; i < categories.size(); i++){
            if (this.categoria.equals(categories.get(i))){
                this.allowed = true;
            }
        }
        String webAppRoot = System.getProperty( "catalina.base" );
        String s = File.separator;
        String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
        String usersDir = configDir + s + "46302jeikHJSN";
        String userDir = usersDir + s + user;
        String doedsFileDir = userDir  + s + "done.txt";
        String readStrHelp;
        BufferedReader readDoeds = new BufferedReader(new FileReader(doedsFileDir));
        while ((readStrHelp = readDoeds.readLine()) != null){
            if(this.name.equals(readStrHelp)){
                this.doed = true;
            }
        }
    }
    public String getData(){
        return this.data;
    }
    public String printTasca(int i, Boolean isFirstList){
        String result = "";
        if (this.allowed){
            if (isFirstList && !this.doed) {
            result += "<tr id = 'parent" + i + "' >";
            result += "<td class = 'buttonsTd'><button class = listButton id = button" + i + " onclick = showChild(" + i + ")><img width = 15px height = 15px src = 'https://image.flaticon.com/icons/png/512/17/17340.png'></img></button>";
            result += "<button class = listButton id = buttonSet" + i + " onclick = "+'"'+"setTask('" + this.name + "', 'add'); setTimeout(function() {location.reload();}, 500);"+'"'+" ><img width = 15px height = 15px src = 'http://www.tallereshaizea.com/images/icon-auditorias-energeticas'></img></button>";
            if (this.user.equals(this.autor)){
                result += "<button class = listButton onclick = " + '"' + "editTask('" + this.name + "', '" + this.data + "', '" + this.categoria + "', " + i + ")" + '"' + "><img width = 15px height = 15px src = 'https://image.flaticon.com/icons/png/512/12/12912.png'></img></button>";
            }
            result += "</td>";
            result += "<th id = titul" + i + " style = 'overflow:scroll;max-width:850px;' >" + this.titul + "</th>";
            result += "<td>" + this.data + "</td>";
            result += "<td> Visible per a: " + this.categoria + "</td>";
            result += "<td>" + this.autor + "</td>";
            result += "</tr><tr id = 'child" + i + "' style = 'display:none;' class = childRow >";
            result += "<td colspan = 5 id = comentaris" + i + " >" + this.comentaris + "</td>";
            result += "</tr>";
            } 
            if(!isFirstList && this.doed) {
            result += "<tr id = 'parent" + i + "' >";
            result += "<td class = 'buttonsTd'><button class = listButton id = button" + i + " onclick = showChild(" + i + ")><img width = 15px height = 15px src = 'https://image.flaticon.com/icons/png/512/17/17340.png'></img></button>";
            result += "<button class = listButton id = buttonSet" + i + " onclick = "+'"'+"setTask('" + this.name + "', 'delete'); setTimeout(function() {location.reload();}, 500); "+'"'+" ><img width = 15px height = 15px src = './cruz.png'></img></button>";
            if (this.user.equals(this.autor)){
                result += "<button class = listButton onclick = " + '"' + "editTask('" + this.name + "', '"  + this.data + "', '" + this.categoria + "', " + i + ")" + '"' + "><img width = 15px height = 15px src = 'https://image.flaticon.com/icons/png/512/12/12912.png'></img></button>";
            }
            result += "</td>";
            result += "<th id = titul" + i + " style = 'overflow:scroll;max-width:850px;' >" + this.titul + "</th>";
            result += "<td>" + this.data + "</td>";
            result += "<td> Visible per a: " + this.categoria + "</td>";
            result += "<td>" + this.autor + "</td>";
            result += "</tr><tr id = 'child" + i + "' style = 'display:none;'class = childRow >";
            result += "<td colspan = 5 id = comentaris" + i + " >" + this.comentaris + "</td>";
            result += "</tr>";
            }
        }
        return result;
    }
}
%>
<%!
ArrayList<TascaClass> TasquesList(String user, String tasquesDir, ArrayList<String> categories, Boolean bool) throws FileNotFoundException, IOException {
 String s = File.separator;
 ArrayList<TascaClass> TasquesArray = new ArrayList<TascaClass>();
 File tasquesDirFile = new File(tasquesDir);
 ArrayList<String> tasquesNames = new ArrayList<String>(Arrays.asList(tasquesDirFile.list()));
 ArrayList<File> tasquesFiles = new ArrayList<File>();
 for (int i = 0; i < tasquesNames.size(); i++){
     TasquesArray.add(new TascaClass(user, tasquesDir + s + tasquesNames.get(i), categories));
 }
 if (!bool){
 Collections.sort(TasquesArray, new Comparator<TascaClass>() {
    @Override
    public int compare(TascaClass o1, TascaClass o2) {
        return (o1.getData().compareTo(o2.getData()) * -1);
    }
});
} else {
   Collections.sort(TasquesArray, new Comparator<TascaClass>() {
    @Override
    public int compare(TascaClass o1, TascaClass o2) {
        return o1.getData().compareTo(o2.getData());
    }
}); 
}
 return TasquesArray;
}
%>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="./textEditor/site.css">
        <link rel="stylesheet" href="./textEditor/richtext.min.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script type="text/javascript" src="./textEditor/jquery.richtext.js"></script>
        <title>Agenda</title>

<script>
function setTask(name, action){
    var path = document.doed;
    path.taskToSet.value = name;
    path.action.value = action;
    path.submit();
}
</script>
<style>
body {
    background-color: white;
}
#title {
    border-radius: 30px;
    box-shadow: 4px 6px 12px grey;
    display:inline;
    font-size: 50px;
}
.menu {
    background-color: white;
    border-radius: 8px 8px 8px 8px;
    text-align: center;
}
.hidden {
    visibility: hidden;
}
.section {
    display:inline;
    border-radius: 20px;
    box-shadow: 2px 3px 6px grey;
    transition: box-shadow 2s;
    font-size: 25px;
    margin: 10px;
}
.section:hover {
    box-shadow:1px 1px 3px grey;
    transition: box-shadow 2s;
}
.sectionActive:hover {
    box-shadow: inset -1px -1px 3px grey;
    transition: box-shadow 2s;
    font-size: 25px;
    margin: 10px;
}
.sectionActive {
    display:inline;
    border-radius: 20px;
    box-shadow: inset 2px 2px 4px grey;
    transition: box-shadow 2s;
    font-size: 25px;
    margin: 10px;
}
.page {
    background-color: #f0f0f0;
}
td, th {
    width: auto;
    text-align: center;
}
td.buttonsTd{
    text-align: left;
}
thead {
    background-color:lightgrey;
}
td, th {
    height: 30px;
    border-style: solid;
    border-color: black;
    border-width: 0px;
    border-top-width: 1px;
    border-collapse: collapse;
}
.childRow td{
    border-top-width: 0px;
    text-align: left;
}
table{
    width: 100%;
    border-style: solid;
    border-color: black;
    border-width: 1px 0px 1px 0px;
    border-collapse: collapse;
}
.listButton {
    appearance: none;
    -webkit-appearance: none;
    background-color:#f0f0f0;
    border-width:0px;
    margin: 2px;
    border-radius: 20px;
    box-shadow: 2px 2px 4px grey;
    padding: 3px;
    transition: box-shadow 1s;
}
.listButton:hover {
    box-shadow: 1px 1px 2px grey;
    transition: box-shadow 1s;
}
.selectedListButton:hover {
    box-shadow: inset -1px -1px 2px grey;   
    transition: box-shadow 1s;
}
.selectedListButton {
    appearance: none;
    -webkit-appearance: none;
    background-color:#f0f0f0;
    border-width:0px;
    margin: 2px;
    border-radius: 20px;
    box-shadow: inset 2px 2px 3px grey;
    padding: 3px;
    transition: box-shadow 1s;
}
#degradado {
    background-image: linear-gradient(white, #f0f0f0);
}
#close {
    background-image: linear-gradient(to top, white, #f0f0f0);
}
input, select {
    border-style:none;
    background-color:#f0f0f0;
    box-shadow: inset 2px 2px 3px grey;
    border-radius: 30px;
    padding: 2px 10px;
    outline: none;
    margin: 3px;
    font-size: 16px;
}
input[type=submit]{
    box-shadow: 3px 2px 4px grey;
}
input:focus {
    outline: none;
}
</style><script>
window.onload = function(){
    resizeIframes();
}
function resizeIframes() {
    var div = document.getElementsByClassName("menu");
    var iframes = document.getElementsByTagName("IFRAME");
    var i = 0;
    while (i<iframes.length) {
        iframes[i].height = window.heigth - div.heigth;
        console.log(window.height);
    }
}
function changeSection(objectId) {
    console.log("section changed " + objectId);
    var id = document.getElementsByClassName("sectionActive")[0].id + "Div";
    document.getElementById(id).style = "display:none;";
    id = objectId + "Div";
    document.getElementById(id).style = "";
    document.getElementsByClassName("sectionActive")[0].className = "section";
    document.getElementById(objectId).className = "sectionActive";
}

</script>
<%
String webAppRoot = System.getProperty( "catalina.base" );
String s = File.separator;
String configDir = webAppRoot + s + "webapps" + s + "Agenda" + s + "agendaPath" ;
String usersDir = configDir + s + "46302jeikHJSN";
String tasquesDir = configDir + s + "tasques";
File users = new File(usersDir);
String[] usersList = users.list();
String user = request.getParameter("user");
String password = request.getParameter("password");
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
%>

<div class = menu><br>
<h1 id = title>&nbsp;Agenda de <%=user%>&nbsp;</h1><br><br>

<div onclick = "changeSection(this.id)" id = tasques class = sectionActive>
&nbsp;Quins deures hi ha?&nbsp;
</div><div onclick = "changeSection(this.id)" id = afegeix class = section>
&nbsp;Afegeix una tasca.&nbsp;
</div><div onclick = "changeSection(this.id)" id = usuari class = section>
&nbsp;Configuraci&oacute d'usuari i perfil.&nbsp;
</div><br/><br/></div>
<div id = degradado ><br></div>
<div id = tasquesDiv class = page style = "">
<script>
function showChild(num) {
    var parent = document.getElementById("parent" + num);
    var child = document.getElementById("child" + num);
    var button = document.getElementById("button" + num);
    button.setAttribute("class", "selectedListButton");
    button.innerHTML = "<img width = 15px height = 15px src = 'https://image.flaticon.com/icons/png/512/17/17940.png'></img>"
    child.style = "";
    button.setAttribute("onclick", "hideChild(" + num + ");")
}
function hideChild(num) {
    var parent = document.getElementById("parent" + num);
    var child = document.getElementById("child" + num);
    var button = document.getElementById("button" + num);
    button.setAttribute("class", "listButton");
    button.innerHTML = "<img width = 15px height = 15px src = 'https://image.flaticon.com/icons/png/512/17/17340.png'></img>";
    child.style = "display:none;"
    button.setAttribute("onclick", "showChild(" + num + ");")
}
function editTask(name, data, categoria, id){
    document.getElementById('edit').style = '';
    document.getElementById("taskToEdit").value = name;
    document.getElementById("editTitul").value = document.getElementById('titul' + id).innerHTML;
    document.getElementById("editData").value = data;
    document.getElementById("editCategoria").innerHTML = categoria;
    document.getElementById("sendCategoria").value = categoria;
    document.getElementById("EditComents").value = document.getElementById('comentaris' + id).innerHTML;
    document.getElementsByClassName("richText-editor")[0].innerHTML = document.getElementById('comentaris' + id).innerHTML;
}
</script>
<form name = doed target = "_blank" action = "./doed.jsp" method = post style = "display:none;">
 <input type = text name = taskToSet></input>
 <input type = text name = action></input>
 <input type = text value = '<%=user%>' name = user>
 <input type = password value = '<%=password%>' name = password>
 </form>
<div id = edit style = "display:none;">
<div class="page-wrapper box-content">
            
            <form method = post target = blank action = editTask.jsp>
            <h2>Editar la tasca</h2>
            T&iacute;tol:
            <input id = editTitul type = text name = "titul"/><br>
            Categoria: <p id = editCategoria style = "display:inline;"></p><input type = text id = sendCategoria name = "categoria" style = "display:none;"></input>
            <br>
            Data: <input type=date id=editData name = data>
<br>
            Comentaris: <textarea class="content" name="comentaris" id = "EditComents"></textarea>
            <input type = text value = '<%=user%>' name = user style = "display:none;">
            <input type = password value = '<%=password%>' name = password style = "display:none;">
            <input id = taskToEdit type = text name = taskToEdit style = "display:none;"></input>
            <input type = Submit onclick = "setTimeout(function() {location.reload();}, 500)" value = "Afegir"/>
            </form>
        </div>
</div> 
 <h3>Pendents:</h3>
<table id = PendentsTable>
 <thead><tr>
    <th width = 10px></th><th>T&iacutetol</th><th>Data</th><th>Categoria</th><th>Autor</th>
 </tr></thead>
 <tbody>
    <%
try {
ArrayList<TascaClass> objTasquesList = TasquesList(user, tasquesDir, categories, true);
for (i = 0; i < objTasquesList.size(); i++){
    out.print(objTasquesList.get(i).printTasca(i, true));
}
} catch (FileNotFoundException e){
    
} catch (IOException e){
    
}

%>
 </tbody></table>
 <br><br><br>
  <h3>Fets:</h3>
<table id = FetsTable>
 <thead><tr>
    <th width = 10px></th><th>T&iacutetol</th><th>Data</th><th>Categoria</th><th>Autor</th>
 </tr></thead>
 <tbody>
    <%
try {
ArrayList<TascaClass> objTasquesList2 = TasquesList(user, tasquesDir, categories, false);
int o = i;
int d = 0;
for (i = 0; i < objTasquesList2.size(); i++){
    out.print(objTasquesList2.get(i).printTasca(i + o, false));
    if (objTasquesList2.get(i).doed){
        d++;
    }
    if (d >= 25){
        break;
    }
}
} catch (FileNotFoundException e){
    
} catch (IOException e){
    
}

%>
 </tbody></table>
 
<script>
$(document).ready( function () {
    $('#PendentsTable').DataTable();
} );
$(document).ready( function () {
    $('#FetsTable').DataTable();
} );
</script>

</div>
<div id = afegeixDiv class = page style = "display:none;">
<div class="page-wrapper box-content">
            <form method = post target = blank action = addTask.jsp>
            T&iacutetol:
            <input type = text name = "titul"/><br>
            Categoria:
            <select name = categoria>
            
<%for (int e = 0; e < categories.size(); e++) {%>
<option value = <%=categories.get(e)%> > <%=categories.get(e)%> </option>
<%}%>
            </select><br>
            Data: <input type=date id=e name = data>
<script>
document.getElementById('e').value = new Date().toISOString().substring(0, 10);
</script>
<br>
            Comentaris: <textarea id="content" name="comentaris"></textarea>
            <input type = text value = '<%=user%>' name = user style = "display:none;">
            <input type = password value = '<%=password%>' name = password style = "display:none;">
            <input type = Submit onclick = "setTimeout(function() {location.reload();}, 500);" value = "Afegir"/>
            </form>
        </div>
        <script>
        $(document).ready(function() {
            $('#EditComents').richText();
        });
        $(document).ready(function() {
            $('#content').richText();
        });
        </script>
</div>
<div id = categoriesDiv class = page style = "display:none;">
Categories
</div>
<div id = usuariDiv class = page style = "display:none;">

<h3>Canviar la contrasenya.</h3>
<small><samp>
Aquesta pagina no ha sigut creada per profesionals i no &eacutes el m&eacutes segur del m&oacuten. S'et recomana que posis una contrasenya nova 
per a aquesta p&agravegina i que no la repeteixis a cap altre compte. (per exemple <%=user%>1234) Si utilitzes la contrasenya d'aquest 
lloc per a altres coses ho fas sota el teu propi risc. (&Eacutes poc probable que hi entri un hacker, per&ograve si ho fes, podria  
fer-se amb la teva contrasenya)
</samp></small><br>
<h2>
Si vols canviar la contrasenya omple tots els camps del seguent formulari.
</h2>
<script>
function checkForm(){
    var newPassword = document.getElementById("changeNewPassword");
    var confirmPassword = document.getElementById("changeConfirmPassword");
    var checkBox = document.getElementById("changeCheckBox");
    if (newPassword.value == confirmPassword.value && checkBox.checked){
        setTimeout(function(){
            window.location.href = "http://pdominguez.mooo.com:8081/Agenda/";
        }, 500)
        return true;
    } else {
        return false;
    }
}
</script>
<form target = blank action = "./changePassword.jsp" method = post><br><br>
<input name = user value = '<%=user%>' style = 'display:none;'></input>
Contrasenya actual: <input id = changeActualPassword name = actualPassword type = password></input><br><br>
Nova contrasenya: <input id = changeNewPassword name = newPassword type = password></input><br><br>
Confirmar contraseya: <input id = changeConfirmPassword name = confirmPassword type = password></input><br><br>
He llegit el text del principi <input id = changeCheckBox name = confirm type = checkbox></input><br><br>
<input type = Submit onclick = "return checkForm()"></input><br><br><br>
</form>
</div>
<div id = close ><br></div>
<%} else {%>
  Password or username is wrong.
<%}}%>
