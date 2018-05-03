using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Sensor as Snsr;

using Toybox.Attention as Att;

class MessageView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Update the view
    function onUpdate(dc) {
    	View.onUpdate(dc);
    	dc.clear();
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
    	
 		var string = Application.getApp().getProperty("Message");
 		
 		var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 4;
        
 		dc.drawText(x, y, Gfx.FONT_SYSTEM_MEDIUM, string, Gfx.TEXT_JUSTIFY_CENTER);
 		
 		if (Attention has :vibrate) {
    		var vibrations =
   			[
      			new Attention.VibeProfile(50, 2000), // (The strength of the vibration, Length of the vibration in milliseconds (ms))

    		];
    		Att.vibrate(vibrations);
		}
    }
}