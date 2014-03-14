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
	
	<link href="css/typeahead.css" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy this line! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script src="js/OpenLayers.js"></script>
	<script type="text/javascript">

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
	var size = new OpenLayers.Size(70,70);
	var offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
	var icon = new OpenLayers.Icon('img/marker3.png', size, offset);
	 
	var markers = new OpenLayers.Layer.Markers( "Markers" );
	marker = new OpenLayers.Marker(lonLat,icon) ;
	markers.addMarker(marker);
	map.addLayer(markers);
	
	map.events.register("click", map , function(e){
	var opx = map.getLayerPxFromViewPortPx(e.xy) ;
	marker.map = map ;
	marker.moveTo(opx) ;
	var position = map.getLonLatFromViewPortPx(e.xy).transform(new OpenLayers.Projection("EPSG:900913"), new OpenLayers.Projection("EPSG:4326"));
	document.getElementById("lat").value=position.lat;
	document.getElementById("lon").value=position.lon;
	document.getElementById('alert_pos').innerHTML='Alerte localis&eacute;e';
	});

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
				  pathMarker="img/marker2.png";
			  }
			  else{
				  pathMarker="img/marker.png";
			  }
		  }
		  else{
			  pathMarker="img/marker.png";
		  }
		  %>
	 var feature = new OpenLayers.Feature.Vector(
          new OpenLayers.Geometry.Point(<%=alerte.getLongitude()%>,<%=alerte.getLatitude()%>).transform(epsg4326, projectTo),
          {description:'<center><strong><%=alerte.getType()%></strong><br><i><%=alerte.getAdresse()%></i></center><br>Posté le <%=alerte.getDate()%> <br><b>Description : </b><%=alerte.getDescription()%>'} ,
          {externalGraphic: '<%=pathMarker%>', graphicHeight: 70, graphicWidth: 70, graphicXOffset:-35, graphicYOffset:-70  }
      );    
  vectorLayer.addFeatures(feature);
  
  		<%} %>
  
  map.addLayer(vectorLayer);

  
  //Add a selector control to the vectorLayer with popup functions
  var controls = {
    selector: new OpenLayers.Control.SelectFeature(vectorLayer, { onSelect: createPopup, onUnselect: destroyPopup })
  };

  function createPopup(feature) {
    feature.popup = new OpenLayers.Popup.FramedCloud("pop",
        feature.geometry.getBounds().getCenterLonLat(),
        null,
        '<div class="markerContent">'+feature.attributes.description+'</div>',
        null,
        true,
        function() { controls['selector'].unselectAll(); }
    );
    //feature.popup.closeOnMove = true;
    map.addPopup(feature.popup);
  }

  function destroyPopup(feature) {
    feature.popup.destroy();
    feature.popup = null;
  }
  
  map.addControl(controls['selector']);
  controls['selector'].activate();
    
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
		    <a href="<%=userService.createLoginURL("/add.action")%>" class="btn btn-success">Connexion</a>
          	</s:if>
          	<s:else>
		    <a href="<%= userService.createLogoutURL("/map.action")%>" class="btn btn-danger">D&eacute;connexion</a>
          	</s:else>
            <!--<input type="text" class="form-control" placeholder="Search...">-->
          </form>
		  
          <ul class="nav navbar-nav navbar-right">
            <li class="active_link">
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
					        Afin d'ajouter un alerte, vous devez vous connecter
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
            <li><a href="/liste.action">Liste des Alertes</a></li>
            <li><a href="about.html">A Propos</a></li>
            <s:if test="user!=null">
              <li><a href="#"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<%=user%></a></li>
          	</s:if>
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
				<s:form action="add.action" method="post" cssClass="navbar-form" theme="simple">
					<label for="sel_type">Cat&eacute;gorie&nbsp;&nbsp;</label><br>
					<s:select list="listeCat" name="type" cssClass="form-control" label="Categorie" labelposition="top" labelSeparator=""/>
					<br><br>
					
					<label for="area_descr">Adresse</label><br>
					<s:textfield name="adresse" id="in_txt_adresse" required="true" cssClass="form-control" size="100%" placeholder="Boulevard Michelet, Nantes" label="Adresse" labelposition="top" labelSeparator=""/>
					<br><span id="alert_pos">Saisissez une adresse puis cliquez sur la carte pour localiser votre alerte</span><br><br>


					<label for="area_descr">Description</label><br>
					<s:textarea name="description" required="true" placeholder="Description" cssClass="form-control" rows="6" label="Description" labelposition="top" labelSeparator=""/>
					<br><br>		    
					<!-- 
					<div class="row">
					
					<div class="col-sm-6 col-md-6">
					<label for="area_descr">Latitude</label><br>
				    <s:textfield name="latitude" required="true" depends="required" cssClass="form-control" size="100%" placeholder="automatique" label="Latitude" labelposition="top" labelSeparator=""/>
					
					
					</div>
					<div class="col-sm-6 col-md-6">
				    
				    <label for="area_descr">Longitude</label><br>
				    <s:textfield name="longitude" required="true" depends="required" cssClass="form-control" size="100%" placeholder="automatique" label="Longitude" labelposition="top" labelSeparator=""/>
					
					</div>
				    </div>
				     -->
				     
				    <s:hidden name="latitude" id="lat" value=""/>
				    <s:hidden name="longitude" id="lon" value=""/>
				    
				    
				    
				    <label for="hiddenfile">Image&nbsp;&nbsp;&nbsp;&nbsp;</label><br>
					<s:file id="hiddenfile" style="display:none" name="file" onChange="getvalue();"/>
					<div class="btn btn-default"  onclick="getfile();" width="100%">
						<input type="button" class="btn btn-sm btn-primary" value="Parcourir..." onclick="getfile();"/>&nbsp;
						<span id="selectedfile">
							Aucun fichier
						</span>
					</div>
				    <br><br><br>
				    
				    <!-- 
				    <label for="area_descr">Image</label><br>
					<s:file name="image" cssClass="form-control" size="100%" placeholder="Cliquez ici pour sélectionner une image" label="Image" labelposition="top" labelSeparator=""/>
										 
					<br><br><br>
				     -->
				    
				    <center>
				    	<s:submit method="execute" value="Signaler" align="center" cssClass="btn btn-success" />
					</center>
				</s:form>
			
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
    <script src="js/bootstrap.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
   	<script src="js/jquery.js"></script>
	<script src="js/typeahead.js"></script>
   <script>
   function getfile(){
       document.getElementById('hiddenfile').click();
   }
   function getvalue(){
       document.getElementById('selectedfile').innerHTML=document.getElementById('hiddenfile').value;
   }
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
