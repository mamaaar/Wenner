using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application;

class paramView extends Ui.View {
	
	var appbase = Application.getApp();
        
	function initialize() {
        View.initialize();
       	
       	appbase.userActuel.addJour();
       	
       	makeRequest();
       	System.println("");
    }

    // Update the view
    function onUpdate(dc) {
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
        dc.drawText(
       		dc.getWidth() / 2, 
       		dc.getHeight() /4*3, 
       		Gfx.FONT_MEDIUM, 
       		":)", 
       		Gfx.TEXT_JUSTIFY_CENTER
       	);
    }
    
    
    function makeRequest() {
   		System.println("Make web request");   		
       	var url = Ui.loadResource(Rez.Strings.URL_local);	// set the url
		
		var idParticipant = appbase.userActuel.idParticipant;
		var lignes = appbase.userActuel.affichage();
		var nbJours = appbase.userActuel.tabJours.size();
		
		System.println(idParticipant);
		System.println(lignes);
		System.println(nbJours);
		
       	var params = {                                              // set the parameters
              "idParticipant" => idParticipant,
              "lignes" => lignes,
              "nbJours" => nbJours
       	};

       	var headers = {

          "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
          // accept responses that are reported as json-compatible
          "Accept" => "application/json" //"text/plain"
        };
		
        var options = {
          :method => Communications.HTTP_REQUEST_METHOD_POST,
          :headers => headers,
          :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
        };

       // Make the Communications.makeWebRequest() call
       Communications.makeWebRequest(url, params, options, method(:onReceive));
  }
  
  // set up the response callback function
   function onReceive(responseCode, data) {
       if (responseCode == 200) {
           System.println("Request Successful");                    // print success
       }
       else {
           System.println("Response - sending failed: " + responseCode);            // print response code
       }

   }
  
}

class paramDelegate extends Ui.BehaviorDelegate {
	
    function initialize() {
        BehaviorDelegate.initialize();
    }
}
