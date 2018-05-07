using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor;

using Toybox.Attention as Att;

class MessageView extends Ui.View {
	
	var mVibration = false;
	var nbPasActuel = 0;

    function initialize(vibration) {
    	if (vibration){
    		mVibration = true;
    	}
        View.initialize();
        nbPasActuel = ActivityMonitor.getInfo().steps;
    }

    // Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	dc.clear();
    	
    	nbPasActuel = ActivityMonitor.getInfo().steps; //nb pas
       	var stepsPercent = (nbPasActuel.toFloat() / 10000); //percent of 10000 steps
       	var stringPercent = (stepsPercent*100).format("%.f");
       	
 		var message = Application.getApp().getProperty("Message");
 		
        
 		drawBarMessage( // fonction qui affiche la bar de progression
        // drawBar(dc, titre de la bar ici "% sur 10000", emplacement selon y, color de l'intérieur ici vert)
        	dc, 
        	stringPercent + "%" + " de " + 10000,
        	stepsPercent,
        	message
        );
 		
 		if (mVibration){
 		
	 		if (Attention has :vibrate) {
	    		var vibrations =
	   			[
	      			new Attention.VibeProfile(50, 2000), // (The strength of the vibration, Length of the vibration in milliseconds (ms))
	
	    		];
	    		Att.vibrate(vibrations);
			}
		}
    }
    
    // fonction qui affiche la bar de progression 
    function drawBarMessage(dc, text, percent, message) { 
        var width = dc.getWidth() / 5 * 4;
        var x = dc.getHeight() / 10;
		var y = 45;
        if (percent > 1) {
            percent = 1.0;
        }

        dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);
        dc.fillRectangle(x, y, width * percent, 10);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawRectangle(x, y, width, 10);
        dc.setPenWidth(1);

        var font = Gfx.FONT_SMALL;

        dc.drawText(dc.getWidth()/2, y - Gfx.getFontHeight(font) - 3, font, text, Gfx.TEXT_JUSTIFY_CENTER);
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        
        dc.drawText(dc.getWidth()/2, y + 10, Gfx.FONT_SYSTEM_MEDIUM, message, Gfx.TEXT_JUSTIFY_CENTER);
    }
    
}