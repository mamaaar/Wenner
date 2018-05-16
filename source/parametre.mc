using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application;

class paramView extends Ui.View {

	function initialize() {
        View.initialize();
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
       	
       	Application.getApp().userActuel.toString();
    }
}

class paramDelegate extends Ui.BehaviorDelegate {
	
    function initialize() {
        BehaviorDelegate.initialize();
    }
}
