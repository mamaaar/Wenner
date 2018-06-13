using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Act;
using Toybox.Application;

class HistoryView extends Ui.View {
	
	var appbase = Application.getApp();
	
    // Constructor
    function initialize() {
        View.initialize();
		//Application.getApp().userActuel.addJour();
        makeRequest();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.HistoryLayout(dc));
    }

    // Handle the update event
    function onUpdate(dc) {
        View.onUpdate(dc);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var actHistArray = Act.getHistory();
        var padding = 10;
        var string = "";
        var fontHeight = Gfx.getFontHeight(Gfx.FONT_TINY);

        if (null != actHistArray && actHistArray.size() > 0) {
            // Loop through array of history items
            for (var i = 0; i < actHistArray.size(); i += 1) {
                dc.drawText((dc.getWidth() / 4), padding +  fontHeight * (i+2), Gfx.FONT_TINY, (i+1).toString(), Gfx.TEXT_JUSTIFY_CENTER);
                // Validate that each element is non-null
                if (null != actHistArray[i] && null != actHistArray[i].steps) {
                    string = actHistArray[i].steps.toString();
                    dc.drawText((dc.getWidth() / 4*3), padding + fontHeight * (i+2), Gfx.FONT_TINY, string, Gfx.TEXT_JUSTIFY_CENTER);
                }
            }
        }
    }
    
    
    function makeRequest() {  		
       	var url = Ui.loadResource(Rez.Strings.URL_dataRegister);	// set the url

		var idParticipant = appbase.userActuel.idParticipant.toNumber();
		var tablignes = appbase.userActuel.affichage();
		var nbJours = appbase.userActuel.tabJours.size().toNumber();
		       	
       	var params = {                                              // set the parameters
              "idParticipant" => idParticipant,
              "lignes" => tablignes
       	};
       	
        var headers = {
          "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
          // accept responses that are reported as json-compatible
          "Accept" => "application/json" 
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



class HistoryDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }
    
}