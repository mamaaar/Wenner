using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;

class WennerView extends Ui.View { // Vue qui affiche l'heure

	var today;			// var pour récup l'heure, la minute et la seconde courantes
	var timer; 			// Timer 
	var sec;			// Compteur pour refresh la page chaque seconde
	
    function initialize() {
        View.initialize();
    	timer = new Timer.Timer();
    }
    
    function onShow() {
    	sec = 0;
    	timer.start(method(:incsec),1000, true);
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
		var myTime = System.getClockTime(); 		// ClockTime object : pour afficher l'heure
		var myStats = System.getSystemStats();		// Pour afficher le % de la batterie
		today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);	// Pour afficher la date
		
		dc.drawText( 				// Affichage du % de batterie
			dc.getWidth()/2, 		// x : au milieu
			dc.getHeight()/4, 					// y : vers le haut
			Graphics.FONT_MEDIUM, 	// police moyenne
			myStats.battery.format("%02d") + "% battery",
			Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
		);
		
	    dc.drawText( 				// Affichage de l'heure
	        dc.getWidth()/2,		
	        dc.getHeight()/2,
	        Graphics.FONT_NUMBER_HOT,	// En gros au milleu
	        myTime.hour.format("%02d") + ":" +
		    myTime.min.format("%02d") + ":" +
		    myTime.sec.format("%02d"),
	        Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
        
        dc.drawText( // Affichage de la date
        	dc.getWidth()/2, 
        	dc.getHeight()/4*3, 
        	Graphics.FONT_MEDIUM, 
        	today.day_of_week + " " + today.day, 
        	Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
	    	
    }
	
	function incsec() { // Permet d'actualiser l'interface toute les secondes
		sec += 1;
       	System.println("ViewHeure" + sec);
       	if (sec%60 == 0){
       		sec = 0;
       	}
       	//Kick the display update
       	Ui.requestUpdate();
	}
	
    function onHide(){
    	timer.stop();
    }
}
