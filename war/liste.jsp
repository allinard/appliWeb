<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.nantalertes.bean.Alerte"%>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>   

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
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
	<script type="text/javascript">
	var feature;
	var lastFeature = null;
	  function init() {

			<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			%>
		
	map = new OpenLayers.Map({
      div: "basicMap",
      controls: [
			new OpenLayers.Control.TouchNavigation({
              dragPanOptions: {
                  enableKinetic: true
              }
          }),
          new OpenLayers.Control.Zoom(),
			new OpenLayers.Control.Navigation({mouseWheelOptions: {interval: 400}})],
		fractionalZoom: true
  });
  map.addLayer(new OpenLayers.Layer.OSM());

  var lonLat = new OpenLayers.LonLat(-1.5533581,47.2183506).transform(
          new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
          map.getProjectionObject() // to Spherical Mercator Projection
        );

  var zoom=13;

  map.addControls([
	new OpenLayers.Control.PanPanel(),
	new OpenLayers.Control.ZoomPanel()/*,
          new OpenLayers.Control.Navigation(),
          new OpenLayers.Control.PanZoomBar(null, null, 100, 50)*/
  ]);
	
	
  map.setCenter (lonLat, zoom);
	    var vectorLayer = new OpenLayers.Layer.Vector("Overlay");
  
  epsg4326 =  new OpenLayers.Projection("EPSG:4326"); //WGS 1984 projection
  projectTo = map.getProjectionObject(); //The map projection (Spherical Mercator)
  // Define markers as "features" of the vector layer:
	  
  <%
  List<Alerte> listeAlertes = (List<Alerte>) request.getAttribute("listeAlertes");
	  String pathMarker;
	  for(Alerte alerte : listeAlertes){
		  if(null!=user){
			  if(alerte.getUser().toString().equals(user.toString())){
				  pathMarker="img/marker2.png";%>
				  popup_footer='<a href="/delete.action?alerteId=<%=alerte.getId()%>" style="color:grey;"><span class="glyphicon glyphicon-remove"></span>&nbsp;Supprimer</a>';
				  <%
			  }
			  else{
				  pathMarker="img/marker.png"; %>
				  popup_footer ='<a href="#" style="color:grey;"><span class="glyphicon glyphicon-thumbs-up"></span>&nbsp;Je confirme</a>';
				  <%
			  }
		  }
		  else{
			  pathMarker="img/marker.png"; %>
			  popup_footer='';
			  <%
		  }
		  %>
		  
	 popup_footer=popup_footer+'<span class="badge pull-right" style="background-color:#428BCA;"><span class="glyphicon glyphicon-thumbs-up"></span> 2</span>';
	 var feature = new OpenLayers.Feature.Vector(
	      new OpenLayers.Geometry.Point(<%=alerte.getLongitude()%>,<%=alerte.getLatitude()%>).transform(epsg4326, projectTo),
	      {description:'<center><strong><%=alerte.getType()%>&nbsp;</strong><span style="color:DarkRed;cursor:pointer;" class="pull-right" onclick="destroyPopup(lastFeature);">&times;</span><br><i><%=alerte.getAdresse()%></i></center><br>Posté <%=alerte.getDate()%><br><b>Description : </b><%=alerte.getDescription()%><br><br>'+popup_footer} ,
	      {externalGraphic: '<%=pathMarker%>', graphicHeight: 70, graphicWidth: 70, graphicXOffset:-35, graphicYOffset:-70  }
	  );       
 feature.data.id = '<%=alerte.getId()%>';
 feature.data.lat = '<%=alerte.getLatitude()%>';
 feature.data.lon = '<%=alerte.getLongitude()%>';
vectorLayer.addFeatures(feature);

		<%} %>
  
  map.addLayer(vectorLayer);

  
  //Add a selector control to the vectorLayer with popup functions
  var controls = {
    selector: new OpenLayers.Control.SelectFeature(vectorLayer, { onSelect: createPopup, onUnselect: destroyPopup })
  };

  
  map.addControl(controls['selector']);
  controls['selector'].activate();
    
	  }

	  function getFeature(features, id){
		  var i = 0;
		  for(i=0; i<features.length; i++){
			  
			  if(features[i].data.id==id){

				  return features[i];
			  }
		  }

		  return null;
	  }
	  
	  function centerMap(feature){
		  var lonLat = new OpenLayers.LonLat(parseFloat(feature.data.lon),parseFloat(feature.data.lat)).transform(
		          new OpenLayers.Projection("EPSG:4326"), // transform from WGS 1984
		          map.getProjectionObject() // to Spherical Mercator Projection
		        );

		  var zoom=15;

		  map.setCenter (lonLat, zoom);
	  }
	  
	  function createPopup(feature) {
		if(lastFeature!=null){
			destroyPopup(lastFeature);
		}
	    feature.popup = new OpenLayers.Popup.FramedCloud("pop",
	        feature.geometry.getBounds().getCenterLonLat(),
	        null,
	        '<div class="markerContent">'+feature.attributes.description+'</div>',
	        null,
	        true,
	        function() { controls['selector'].unselectAll(); }
	    );
	    lastFeature = feature;
	    //feature.popup.closeOnMove = true;
	    map.addPopup(feature.popup);
	  }

	  function destroyPopup(feature) {
		lastFeature = null;
	    feature.popup.destroy();
	    feature.popup = null;
	  }	
	</script>
  </head>

  <body onload="document.getElementById('basicMap').style.height=((document.getElementById('sidebar').offsetHeight-document.getElementById('navbar').offsetHeight)+'px');init();document.getElementById('scroll_liste').style.height=(document.getElementById('basicMap').offsetHeight-130)+'px'; document.getElementById('scroll_liste').style.overflow='auto';" onresize="document.getElementById('basicMap').style.height=((document.getElementById('sidebar').offsetHeight-document.getElementById('navbar').offsetHeight)+'px');document.getElementById('scroll_liste').style.height=(document.getElementById('basicMap').offsetHeight-130)+'px';">

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
		    <a href="<%=userService.createLoginURL("/liste.action")%>" class="btn btn-success">Connexion</a>
          	</s:if>
          	<s:else>
		    <a href="<%= userService.createLogoutURL("/liste.action")%>" class="btn btn-danger">D&eacute;connexion</a>
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
							<a href="<%=userService.createLoginURL("/add.action")%>" class="btn btn-success">Se Connecter</a>
					      </div>
					    </div>
					  </div>
					</div>
	          	</s:if>
	          	<s:else>
		          	<a href="/add.action">Signaler un probl&egrave;me</a>
	          	</s:else>
            </li>
            <li class="active_link" ><a href="/liste.action">Liste des Alertes</a></li>
            <li><a href="/about.action">A Propos</a></li>
            <s:if test="user!=null">
              <li><a href="/account.action"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<%=user%></a></li>
          	</s:if>
          </ul>
		  
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div id="sidebar" style="box-shadow: 5px 5px 8px #aaa;" class="col-sm-6 col-md-4 sidebar">
			
          <ul class="nav nav-sidebar">
            <li class="active" style="box-shadow: 8px 8px 8px #bbb;"><a href="#"><h4><strong>Liste des Alertes</strong></h4></a></li>
          </ul>
          <ul class="nav nav-sidebar" id="scroll_liste">
            <s:set name="testsListeAlertes" value="listeAlertes"/>
            <s:if test="%{#testsListeAlertes.isEmpty()}">
            	<li><center><span style="color:#115077;"><strong><i>Pas d'alertes signalées en cours</i></strong></span></center></li>
            </s:if>
            <s:else>
			    <s:iterator value="listeAlertes" var="alerte">
			    	<li><a href="#" name=<s:property value='id'/> onclick="feat=getFeature(map.layers[1].features, this.attributes['name'].value);centerMap(feat);createPopup(feat);">
			    	<s:if test="#alerte.removable">
			    		<span style="color:#115077;" class="glyphicon glyphicon-remove" onclick="window.location.href='/delete.action?alerteId=<s:property value="id"/>'">&nbsp;&nbsp;</span>
			    	</s:if>
			    	<s:else>
			    		<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			    	</s:else>
				    <s:if test="#alerte.type == 'Innondation'">
				    	<span style="color:#115077;" class="glyphicon glyphicon-tint">&nbsp;</span>
	   				</s:if>
	   				<s:elseif test="#alerte.type == 'Déchets'">
	   					<span style="color:#115077;" class="glyphicon glyphicon-trash">&nbsp;</span>
	   				</s:elseif>
	   				<s:elseif test="#alerte.type == 'Tags/Graffitis'">
	   					<span style="color:#115077;" class="glyphicon glyphicon-pencil">&nbsp;</span>
	   				</s:elseif>
	   				<s:elseif test="#alerte.type == 'Chaussée endommagée'">
	   					<span style="color:#115077;" class="glyphicon glyphicon-road">&nbsp;</span>
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
    <script src="js/bootstrap.js"></script>
    <script src="js/transition.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
  </body>
</html>
