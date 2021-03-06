using Toybox.WatchUi as Ui;
using Toybox.ActivityMonitor;
using Toybox.Graphics as Gfx;
using Toybox.Timer;
using Toybox.Application;

class PasView extends Ui.View {

	var pas; //variable pour le logo nombre de pas
		
	function initialize() {
        View.initialize();
        //Initialise l'image pas
        
        pas = new Ui.Bitmap({	:rezId=>Rez.Drawables.pas,
        						:locX=>75,
        						:locY=>10}
        );
        
        var appbase = Application.getApp();
        //Incr�mente de 1 le nombre de consultation
		appbase.userActuel.jourActuel.addConsultation();
    }
    
    // Update the view
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        
        pas.draw(dc); // affiche l'image
        
       	var nbPasActuel = ActivityMonitor.getInfo().steps; //nb pas
       	var stepsPercent = (nbPasActuel.toFloat() / 10000); //percent of 10000 steps
       	var stringPercent = (stepsPercent*100).format("%.f");
       	
        drawBar( // fonction qui affiche la bar de progression
        // drawBar(dc, titre de la bar ici "% sur 10000", emplacement selon y, color de l'int�rieur ici vert)
        	dc, 
        	stringPercent + "%" + " de " + 10000, 
        	(dc.getHeight()/2)+10, 
        	stepsPercent, 
        	Gfx.COLOR_GREEN
        );
        
       	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
       	
       	dc.drawText(	// Affiche le nombre de pas
       		dc.getWidth() / 2, 
       		dc.getHeight() - 4 * Gfx.getFontHeight(Gfx.FONT_LARGE) + 61, 
       		Gfx.FONT_NUMBER_HOT, 
       		nbPasActuel.toString(), 
       		Gfx.TEXT_JUSTIFY_CENTER
       	);

        
    }

    // fonction qui affiche la bar de progression 
    function drawBar(dc, string, y, percent, color) { 
        var width = dc.getWidth() / 5 * 4;
        var x = dc.getWidth() / 10;

        if (percent > 1) {
            percent = 1.0;
        }

        dc.setColor(color, color);
        dc.fillRectangle(x, y, width * percent, 10);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawRectangle(x, y, width, 10);
        dc.setPenWidth(1);

        var font = Gfx.FONT_MEDIUM;

        dc.drawText(x, y - Gfx.getFontHeight(font) - 3, font, string, Gfx.TEXT_JUSTIFY_LEFT);
    }
    
}

class PasDelegate extends Ui.BehaviorDelegate {
	
    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onBack () {
    	Ui.popView(SLIDE_RIGHT);
    	return true;
    }
    
}