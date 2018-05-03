using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class tempsPasseView extends Ui.View {

	var minutesPas=0;
	var secondesPas=0;
	var milliSecsPas=0;
	
	var minutesCoeur=0;
	var secondesCoeur=0;
	var milliSecsCoeur=0;
	
	function initialize()
    {
        View.initialize();
    }
    
	function onUpdate(dc)
	{
	        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
	        dc.clear();
	        
	        var secPas = Application.getApp().getProperty("NbTempsPasseViewPas");
	        var secCoeur = Application.getApp().getProperty("NbTempsPasseViewCoeur");
	        
	        
	        dc.drawText(dc.getWidth()/2, dc.getHeight()/4, Gfx.FONT_MEDIUM, "Temps passe sur\n interface pas : " + secPas 
	        + "\nTemps passe sur\n interface frequence\n cardiaque : " + secCoeur, Gfx.TEXT_JUSTIFY_CENTER);
	}

}


class tempsPasseDelegate extends Ui.BehaviorDelegate {
	
    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    
}
