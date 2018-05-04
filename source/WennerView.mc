using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.Math;

class WennerView extends Ui.View { // Vue principale : celle où il y a l'heure et celle qui gère les messages pour l'instant

	/* Trois tableaux contenant le chemin vers les ressources Strings*/
	var promotions = {
		"grpA" => [Rez.Strings.proA1, Rez.Strings.proA1, Rez.Strings.proA7, Rez.Strings.proA8],
        "grpB" => [Rez.Strings.proB7, Rez.Strings.proB4, Rez.Strings.proB8],
		"grpC" => [Rez.Strings.proC8, Rez.Strings.proC7, Rez.Strings.proC3],
		"grpD" => [Rez.Strings.proD1, Rez.Strings.proD6],
		"grpE" => [Rez.Strings.proE4, Rez.Strings.proE2, Rez.Strings.proE3]
	};
	
	var preventions = {
		"grpA" => [Rez.Strings.preA1, Rez.Strings.preA2, Rez.Strings.preA8, Rez.Strings.preA9 ],
	    "grpB" => [Rez.Strings.preB4, Rez.Strings.preB5, Rez.Strings.preB8],
		"grpC" => [Rez.Strings.preC2, Rez.Strings.preC3, Rez.Strings.preC4, Rez.Strings.preC6],
		"grpD" => [Rez.Strings.preD4, Rez.Strings.preD6, Rez.Strings.preD10, Rez.Strings.preD11],
		"grpE" => [Rez.Strings.preE2, Rez.Strings.preE3]
	};
	
	var aleatoires = {
		"grpA" => [Rez.Strings.proA1, Rez.Strings.proA1, Rez.Strings.proA7, Rez.Strings.proA8, Rez.Strings.preA1, Rez.Strings.preA2, Rez.Strings.preA8, Rez.Strings.preA9 ],
	    "grpB" => [Rez.Strings.proB7, Rez.Strings.proB4, Rez.Strings.proB8, Rez.Strings.preB4, Rez.Strings.preB5, Rez.Strings.preB8],
		"grpC" => [Rez.Strings.proC8, Rez.Strings.proC7, Rez.Strings.proC3, Rez.Strings.preC2, Rez.Strings.preC3, Rez.Strings.preC4, Rez.Strings.preC6],
		"grpD" => [Rez.Strings.proD1, Rez.Strings.proD6, Rez.Strings.preD4, Rez.Strings.preD6, Rez.Strings.preD10, Rez.Strings.preD11],
		"grpE" => [Rez.Strings.proE4, Rez.Strings.proE2, Rez.Strings.proE3, Rez.Strings.preE2, Rez.Strings.preE3]
	};
	
	/***********Heure des messages définit en absolu***********/ 
	var messageEntreeHeure = 6;
	var messageEntreeMinute = 30;
	
	var message1Heure = 8;
    var message1Minute = 00;
    
    var message2Heure = 10;
    var message2Minute = 00;
    
	var message3Heure = 15; 
    var message3Minute = 00;
    
    var message4Heure = 17; 
    var message4Minute = 30;
    
    var messageSortieHeure = 21;
    var messageSortieMinute = 00;
    /**********************************************************/
    // Variables globales
    var condition; 		// Pour récupérer le type de condition de l'utilisateur
	var tabCondition;	// Pour récup le tableau selon la condition
	
   	var timer; 			// Timer 
	var sec = 0;		// Compteur pour refresh la page chaque seconde
	var nbPasActuel;	// var Nombre de pas courant
	var today;			// var pour récup l'heure, la minute et la seconde courantes
	
	/*******************************/
		
    function initialize() {
        View.initialize();
        
		// Récup de la condition + du tableau correspondant *****************
		//<!-- prevention, promotion, aleatoire -->
    	condition = Ui.loadResource(Rez.Strings.condition);		
    	if (condition.equals("prevention")){
    		tabCondition = preventions;
    	}
    	else if (condition.equals("promotion")){
    		tabCondition = promotions;
    	}
    	else if (condition.equals("aleatoire")){
    		tabCondition = aleatoires;
    	}
    	//***************************************************************
    	
    	timer = new Timer.Timer();
    	timer.start(method(:incsec),1000, true);  // appelle de la fonction innsec() toute les secondes
    }


    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	timer.start(method(:incsec),1000, true);
    	Ui.requestUpdate();
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
		var myTime = System.getClockTime(); 		// ClockTime object : pour afficher l'heure
		var myStats = System.getSystemStats();		// Pour afficher le % de la batterie
		today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);	// Pour afficher la date
		nbPasActuel = ActivityMonitor.getInfo().steps;		// nombre de pas actuel
		
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
    
    function incsec() { // Fonction appelé toute les secondes
		sec += 1;		// incrémente le compteur
       	System.println(sec);
       	if (sec%60 == 0){		// Toute les minutes cette partie vérifie si un message doit être affiché
    		today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM); // récupère l'heure, la minute et la seconde courantes
			
			if (messageEntreeHeure.toNumber()==today.hour.toNumber()  // message d'entrer
			&& messageEntreeMinute.toNumber()==today.min.toNumber()) {
				timer.stop();
    			var messageAenvoyer = Ui.loadResource(Rez.Strings.messageEntree);
    		
    			Application.getApp().setProperty("Message", messageAenvoyer);
       			Ui.switchToView(new MessageView(), new MessageViewDelegate(), Ui.SLIDE_IMMEDIATE);
       		}
       		
       		if (message1Heure.toNumber()==today.hour.toNumber() 	// 1er message
			&& message1Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe C");
				envoyerMessageAleaGroupe(tabCondition["grpC"]);
       		}
       		
       		if (message2Heure.toNumber()==today.hour.toNumber() 	// 2eme message
			&& message2Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe C");
				envoyerMessageAleaGroupe(tabCondition["grpC"]);
       		}
       		
       		if (message3Heure.toNumber()==today.hour.toNumber() 	//3eme message
			&& message3Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe Entrer D");
				envoyerMessageAleaGroupe(tabCondition["grpD"]);
       		}
       		
       		if (message4Heure.toNumber()==today.hour.toNumber() 	//4eme message
			&& message4Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe B");
				envoyerMessageAleaGroupe(tabCondition["grpB"]);
       		}
       		
       		if (messageSortieHeure.toNumber()==today.hour.toNumber() 	//message de sortie
			&& messageSortieMinute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe Sortie");
				if (nbPasActuel >= 10000){
					envoyerMessageAleaGroupe(tabCondition["grpA"]);
				}
				else {
					System.println(tabCondition["grpE"]);
					envoyerMessageAleaGroupe(tabCondition["grpE"]);
				}
       		}
       }
       	//Kick the display update
       	Ui.requestUpdate();
	}
	
    
    /* Fonction qui envoie le message selon le groupe choisi */
    function envoyerMessageAleaGroupe(groupe){
		var random = Math.rand()%(groupe.size()); //To generate a random number between min and max => rand()%(max-min + 1) + min;
    	var messageId = groupe[random]; // Récupère un Id au hassard dans le groupe (tableau)
    	System.println(messageId);
    	var messageAenvoyer = Ui.loadResource(messageId);
    	System.println(messageAenvoyer);
    	Application.getApp().setProperty("Message", messageAenvoyer); //affiche le message dans la classe messageView
       	Ui.pushView(new MessageView(), new MessageViewDelegate(), Ui.SLIDE_IMMEDIATE);
	}

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	sec = 0;
    	timer.stop();
    }

}
