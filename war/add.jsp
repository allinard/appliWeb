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
	
	<link href="css/typeahead.css" rel="stylesheet">

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
          <a class="navbar-brand" href="map.jsp" style="color:rgb(140,184,224);"><strong>Nant' Alertes</strong></a>
        </div>
        <div class="navbar-collapse collapse">
		  
          <form class="navbar-form navbar-right">
		    <button type="button" class="btn btn-danger">D&eacute;connexion</button>
            <!--<input type="text" class="form-control" placeholder="Search...">-->
          </form>
		  
          <ul class="nav navbar-nav navbar-right">
            <li class="active_link"><a href="#">Signaler un probl&egrave;me</a></li>
            <li><a href="/liste.action">Liste des Alertes</a></li>
            <li><a href="about.html">A Propos</a></li>
          </ul>
		  
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div id="sidebar" style="box-shadow: 5px 5px 8px #aaa;" class="col-sm-4 col-md-3 sidebar">
		  
		  <ul class="nav nav-sidebar">
            <li class="active" style="box-shadow: 8px 8px 8px #bbb;"><a href="#"><h4><strong>Signaler un Probl&egrave;me</strong></h4></a></li>
			<li>
			
				<s:actionerror />
				<s:form action="add.action" method="post" class="login active">
					<s:select list="listeCat"/>
					<s:textfield name="adresse" value="Adresse" size="20" />
					<s:textfield name="description" value="Description" size="20" />
				    <s:submit method="execute" value="Signaler" align="center"  />
				</s:form>
			
			<!-- 
			  <form class="navbar-form" method="post" role="form" action="">

					<label for="sel_type">Cat&eacute;gorie&nbsp;&nbsp;</label><br>
					<select width="100%" class="form-control">
						<option>Arr&ecirc;t d&eacute;t&eacute;rior&eacute; (Bus/Tram)&nbsp;&nbsp;&nbsp;</option>
						<option>Chauss&eacute;e endommag&eacute;e</option>
						<option>D&eacute;bris sur la voie</option>
						<option>Eclairage public d&eacute;faillant</option>
						<option>Inondation</option>
						<option>Probl&egrave;me de signalisation</option>
						<option>Tags / Graffiti</option>
						<option>Autre</option>
					</select>
				
				<br><br>
					<label for="in_txt_adresse">Adresse&nbsp;&nbsp;&nbsp;&nbsp;</label><br>
					<input type="txt" class="form-control" id="in_txt_adresse" size="100%" placeholder="Boulevard Michelet, Nantes">
					<p class="help-block">Saisissez une adresse ou cliquez sur la carte pour localiser le probl&egrave;me</p>
				
				
				<br><br>
					<label for="area_descr">Description</label><br>
					<textarea class="form-control" rows="6" id="area_descr"></textarea>					
				

				
				<br><br>
				<hr>
				<div class="form-group">
					<button type="submit" class="btn btn-success">&nbsp;&nbsp;&nbsp;Signaler&nbsp;&nbsp;&nbsp;</button>
				</div>
			  </form>
			  
			   -->
			</li>
		  </ul>

        </div>

		
        <div id="basicMap" style="overflow:hidden; padding: 0px; margin-left: 25%px;" class="col-sm-8 col-sm-offset-4 col-md-9 col-md-offset-3 main">


        </div>
      </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
	<script src="js/jquery.js"></script>
<script src="js/bootstrap.min.js"></script>
   	<script src="js/jquery.js"></script>
	<script src="js/typeahead.js"></script>
   <script>
	$('#in_txt_adresse').typeahead({
	  name: 'adresse',
	  local: ["test", "test 2", "this is a test"]
	});
   </script>
  </body>
</html>