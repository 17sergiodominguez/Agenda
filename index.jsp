<title>Inici de sesi&oacute;: Agenda</title>
<style>
$ruler: 16px;
$color-red: #AE1100;
$color-bg: #EBECF0;
$color-shadow: #BABECC;
$color-white: #FFF;

body, html {
  background-color:#EBECF0;
}

body, p, input, select, textarea, button {
    font-family: 'Montserrat', sans-serif;
    letter-spacing: -0.2px;
    font-size: 16px;
}
div, p {
  color: #BABECC;
  text-shadow: 1px 1px 1px #FFF;
}


form {
  padding:  16px;
  width: 320px;
  margin: 0 auto;
}

.segment {
  padding: 32 0;
  text-align: center;
}

button, input {
  border: 0;
  outline: 0;
  font-size: 16px;
  border-radius: 320px;
  padding: 16px;
  background-color:#EBECF0;
  text-shadow: 1px 1px 0 #FFF;
}

label {
  display: block;
  margin-bottom: 24px;
  width: 100%;
}

input {
  margin-right: 8px;
  box-shadow:  inset 2px 2px 5px #BABECC, inset -5px -5px 10px #FFF;
  width: 100%;
  box-sizing: border-box;
  transition: all 0.2s ease-in-out;
  appearance: none;
  -webkit-appearance: none;

  &:focus {
    box-shadow:  inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
  }
}

button {
  color:#61677C;
  font-weight: bold;
  box-shadow: -5px -5px 20px #FFF,  5px 5px 20px #BABECC;
  transition: all 0.2s ease-in-out;
  cursor: pointer;
  font-weight: 600;
  
  &:hover {
    box-shadow: -2px -2px 5px #FFF, 2px 2px 5px #BABECC;
  }
  
  &:active {
    box-shadow: inset 1px 1px 2px #BABECC, inset -1px -1px 2px #FFF;
  }
  
  .icon {
    margin-right: 8px;
  }
  
  &.unit {
    border-radius: 8px;
    line-height: 0;
    width: 48px;
    height: 48px;
    display:inline;
    justify-content: center;
    align-items:center;
    margin: 0px 8px;
    font-size: 19.2px;
    
    .icon {
      margin-right: 0; 
    }
  }
  
  &.red {
    display: block;
    width: 100%;
    color: #AE1100;
  }
}

.input-group {
  display: flex;
  align-items: center;
  justify-content: flex-start;
  
  label {
    margin: 0;
    flex: 1;
  }
}
</style>
<script>
function send() {
    var form = document.getElementById("form");
    document.getElementById("sendUser").value = document.getElementById("user").value;
    document.getElementById("sendPassword").value = document.getElementById("password").value;
    form.submit()
}
window.onload = function() {
document.querySelector('#password').addEventListener('keypress', function (e) {
    if (e.key === 'Enter') {
        send()
    }
});
}
</script>
<form action = "./agendaPath/" id = "form" method="post">
<input type = text id = "sendUser" name = user style = display:none; />
<input type = password id = "sendPassword" name = password style = display:none; />
</form>
<form id = "enterData">  
  <div class="segment">
    <h1>Entra a agenda</h1>
  </div>
  
  <label>
    <input type="text" id = "user" placeholder="Usuari"/>
  </label>
  <label>
    <input type="password" id = "password" placeholder="Contrasenya"/>
  </label>
  <button class="red" type = "button" placehotder="Entra!" onclick = "send()"><i class="icon ion-md-lock"></i>Entra!</button>
</form>