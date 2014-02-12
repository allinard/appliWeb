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
          <a class="navbar-brand" href="map.html" style="color:rgb(140,184,224);"><strong>Nant' Alertes</strong></a>
        </div>
        <div class="navbar-collapse collapse">
		  
          <form class="navbar-form navbar-right">
		    <button type="button" class="btn btn-success">Connexion</button>
            <!--<input type="text" class="form-control" placeholder="Search...">-->
          </form>
		  
          <ul class="nav navbar-nav navbar-right">
            <li><a href="add.html">Signaler un probl&egrave;me</a></li>
            <li><a href="liste.html">Liste des Alertes</a></li>
            <li><a href="about.html">A Propos</a></li>
          </ul>
		  
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div id="sidebar" style="box-shadow: 5px 5px 8px #aaa;" class="col-sm-3 col-md-2 sidebar">
			
          <ul class="nav nav-sidebar">
            <li class="active" style="box-shadow: 8px 8px 8px #bbb;"><a href="#"><h4><strong>Alertes r&eacute;centes</strong></h4></a></li>
            <li><a href="#"><span style="color:#115077;" class="glyphicon glyphicon-exclamation-sign">&nbsp;</span>Feux de Signalisation - <i>Bd Grabriel lauriol</i></a></li>
            <li><a href="#"><span style="color:#115077;" class="glyphicon glyphicon-trash">&nbsp;</span>D&eacute;ch&ecirc;ts - <i>Place Mangin</i></a></li>
            <li><a href="#"><span style="color:#115077;" class=" glyphicon glyphicon-tint">&nbsp;</span>Inondations - <i>P&eacute;riph&eacute;rique</i></a></li>
            <li><a href="#"><span style="color:#115077;" class=" glyphicon glyphicon-pencil">&nbsp;</span>Graffiti - <i>Gare SNCF</i></a></li>
			<li><a href="#" style="color:#115077;"><strong><i>afficher plus</i> &raquo;</strong></a></li>
		  </ul>
		  
		  <ul class="nav nav-sidebar">
            <li class="active" style="box-shadow: 8px 8px 8px #bbb;"><a href="#"><h4><strong>Dans votre quartier</strong></h4></a></li>
			<li>
			  <form class="navbar-form" method="post" action="truc.html">
				<input type="text" class="form-control" placeholder="Adresse..."><br><br>
				<button type="submit" class="btn btn-primary">Rechercher</button>
			  </form>
			</li>
		  </ul>

        </div>

		
        <div id="basicMap" style="overflow:hidden; padding: 0px; margin-left: 25%px;" class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">


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
