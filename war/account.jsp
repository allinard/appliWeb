<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>Nant'Alertes</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/theme.css" rel="stylesheet">
	
	<link href="css/typeahead.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
	<script type="text/javascript">
    	  function init() {
		  
			<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			%>
    	  }
	</script>

  </head>

  <body onload="document.getElementById('basicMap').style.height=((document.getElementById('sidebar').offsetHeight-document.getElementById('navbar').offsetHeight)+'px');init();" onresize="document.getElementById('basicMap').style.height=((document.getElementById('sidebar').offsetHeight-document.getElementById('navbar').offsetHeight)+'px');">

   <div id="navbar" class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="box-shadow: -5px 5px 8px grey;">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/map.action" style="color:rgb(140,184,224);"><img height="40px" style="margin-top:-10px;" src="img/logo.png"></a>
        </div>
        <div class="navbar-collapse collapse">
		  
          <form class="navbar-form navbar-right">
          	<s:if test="user==null">
		    <a href="<%=userService.createLoginURL("/map.action")%>" class="btn btn-success">Connexion</a>
          	</s:if>
          	<s:else>
		    <a href="<%= userService.createLogoutURL("/map.action")%>" class="btn btn-danger">D&eacute;connexion</a>
          	</s:else>
            <!--<input type="text" class="form-control" placeholder="Search...">-->
          </form>
		  
          <ul class="nav navbar-nav navbar-right">
            <li>
	            <s:if test="user==null">
				    <a href="#" data-toggle="modal" data-target="#myModal">Signaler un probl&egrave;me</a>
				    <!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					        <h4 class="modal-title" id="myModalLabel">Signaler un probl&egrave;me</h4>
					      </div>
					      <div class="modal-body">
					        Afin d'ajouter une alerte, vous devez vous connecter
					      </div>
					      <div class="modal-footer">
					        <a href="#" class="btn btn-default" data-dismiss="modal">Fermer</a>
							<a href="<%=userService.createLoginURL("/map.action")%>" class="btn btn-success">Se Connecter</a>
					      </div>
					    </div>
					  </div>
					</div>
	          	</s:if>
	          	<s:else>
		          	<a href="/add.action">Signaler un probl&egrave;me</a>
	          	</s:else>
            </li>
            <li><a href="/liste.action">Liste des Alertes</a></li>
            <li><a href="/about.action">A Propos</a></li>
            <s:if test="user!=null">
              <li class="active_link"><a href="/account.action"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<%=user%></a></li>
          	</s:if>
          </ul>
		  
        </div>
      </div>
    </div>

    <div class="container">
		<div class="page-header">
			<h1>Restez inform&eacute;</h1>
		</div>
		<div class="lead">
			<center>Recevez par e-mail les alertes post&eacute;es dans votre quartier,<br>
			ou sur votre trajet quotidien en vous abonnant &agrave; certaines rues.</center>
		</div>
		<br>
		
		<div class="row">
			<div class="col-md-4">
				<h2>S'abonner</h2>
				<s:form cssClass="navbar-form" theme="simple">
					<label for="area_descr">Adresse</label><br>
					<s:textfield name="adresse" id="in_txt_adresse" required="true" cssClass="form-control" size="100%" placeholder="Boulevard Michelet, NANTES" label="Adresse" labelposition="top" labelSeparator=""/>
					<br><br>
				    
				    <center>
				    	<s:submit method="execute" value="Ajouter" align="center" cssClass="btn btn-success" />
					</center>
				</s:form>
			</div>
			
			<div class="col-md-8"><br>
				<div class="panel panel-default">
				  <!-- Default panel contents -->
				  <div class="panel-heading">
				  	<center>Liste de vos abonnements</center>
				  </div>
				
				  <!-- Table -->
				  <table class="table">
				  <s:iterator value="listeAbonnements" var="abonnement">
			  		<tr>
			  			<td>
							<s:property value='adresse'/>
			  			</td>
			  			<td>
			  				<span class="glyphicon glyphicon-remove" onclick="window.location.href='/account.action?abonnementId=<s:property value="id"/>'"></span>
			  			</td>
			  		</tr>
			  		</s:iterator>
				  </table>
				</div>
								
			</div>
		</div> <!-- end row -->
		
		<p>
			<br>
			<hr>
			<center>
			Adeline GRANET, Alexis LINARD, Carl GOUBEAU - <a href="http://www.dpt-info.univ-nantes.fr/1326208903095/0/fiche___pagelibre/" target="_blank">Master ATAL</a> - <a href="http://univ-nantes.fr" target="_blank">Universit&eacute; de Nantes</a><br>
			Code source de l'application disponible sur <a target="_blank" href="https://github.com/allinard/appliWeb">GitHub</a>
			</center>
		</p>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
   	<script src="js/jquery.js"></script>
	<script src="js/typeahead.js"></script>
   <script>
   function getFileFromServer(url, doneCallback) {
    var xhr;

    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = handleStateChange;
    xhr.open("GET", url, true);
    xhr.send();

    function handleStateChange() {
        if (xhr.readyState === 4) {
            doneCallback(xhr.status == 200 ? xhr.responseText : null);
        }
    }
}
   function getLonLat(s, text){
		var jsonObj = $.parseJSON(text);
		 
		for (var i = 0; i < jsonObj.length; i++) {
			if(jsonObj[i].ADRESSE == s){
				return new OpenLayers.LonLat(jsonObj[i].LONG_WGS84,jsonObj[i].LAT_WGS84).transform(
				new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
				map.getProjectionObject());
			}
		}
		alert("nop");
		return null;
   }
   
   getFileFromServer("data/data.json", function(text) {
    if (text != null) {
		var jsonObj = $.parseJSON(text);
		var sourceArr = [];
		 
		for (var i = 0; i < jsonObj.length; i++) {
		   sourceArr.push(jsonObj[i].ADRESSE);
		}
		
		$("#in_txt_adresse").typeahead({
		   local: sourceArr,
		   items : 5,
		   minLength : 1
		}).on('typeahead:selected', function (obj, datum) {
		 
			var zoom=16;
			
			map.setCenter (getLonLat(this.value, text), zoom);
		});
		
    }
	});
   
   </script>
  </body>
</html>
