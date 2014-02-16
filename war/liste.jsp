<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script src="js/OpenLayers.js"></script>
	<script src="js/map.js"></script>
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
          <a class="navbar-brand" href="/map.action" style="color:rgb(140,184,224);"><strong>Nant' Alertes</strong></a>
        </div>
        <div class="navbar-collapse collapse">
		  
          <form class="navbar-form navbar-right">
		    <button type="button" class="btn btn-success">Connexion</button>
            <!--<input type="text" class="form-control" placeholder="Search...">-->
          </form>
		  
          <ul class="nav navbar-nav navbar-right">
            <li><a href="/add.action">Signaler un probl&egrave;me</a></li>
            <li class="active_link" ><a href="/liste.action">Liste des Alertes</a></li>
            <li><a href="about.html">A Propos</a></li>
          </ul>
		  
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div id="sidebar" style="box-shadow: 5px 5px 8px #aaa;" class="col-sm-6 col-md-4 sidebar">
			
          <ul class="nav nav-sidebar">
            <li class="active" style="box-shadow: 8px 8px 8px #bbb;"><a href="#"><h4><strong>Liste des Alertes</strong></h4></a></li>
            <s:set name="testsListeAlertes" value="listeAlertes"/>
            <s:if test="%{#testsListeAlertes.isEmpty()}">
            	<li><center><span style="color:#115077;"><strong><i>Pas d'alertes signalées en cours</i></strong></span></center></li>
            </s:if>
            <s:else>
			    <s:iterator value="listeAlertes" var="alerte">
			    	<li><a href="#">
			    	<span style="color:#115077;" class="glyphicon glyphicon-remove-sign" onclick="window.location.href='/delete.action?alerteId=<s:property value="id"/>'">&nbsp;&nbsp;</span>
				    <s:if test="#alerte.type == 'Innondation'">
				    	<span style="color:#115077;" class="glyphicon glyphicon-tint">&nbsp;</span>
	   				</s:if>
	   				<s:elseif test="#alerte.type == 'Déchets'">
	   					<span style="color:#115077;" class="glyphicon glyphicon-trash">&nbsp;</span>
	   				</s:elseif>
	   				<s:elseif test="#alerte.type == 'Tags/Graffitis'">
	   					<span style="color:#115077;" class="glyphicon glyphicon-pencil">&nbsp;</span>
	   				</s:elseif>
	   				<s:else>
						 <span style="color:#115077;" class="glyphicon glyphicon-exclamation-sign">&nbsp;</span>		
	   				</s:else>
	   				<s:property value="type"/> - <i><s:property value="adresse"/></i>
	   				</a></li>
				</s:iterator>            
            </s:else>
		  </ul>
        </div>

		
        <div id="basicMap" style="overflow:hidden; padding: 0px; margin-left: 25%px;" class="col-sm-6 col-sm-offset-6 col-md-8 col-md-offset-4 main">


        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
  </body>
</html>
