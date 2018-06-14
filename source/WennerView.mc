using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;

class WennerView extends Ui.View { // Vue qui affiche l'heure

	/***********Heure des messages définit en absolu***********/ 

	var messageEntreeHeure 		= 10;
	var messageEntreeMinute 	= 31;
	var message1Heure 			= 9;
    var message1Minute 			= 0;
    var message2Heure 			= 12;
    var message2Minute 			= 0;
	var message3Heure 			= 15;
    var message3Minute 			= 0;
    var message4Heure 			= 18;
    var message4Minute 			= 0;
    var messageSortieHeure		= 21;
    var messageSortieMinute		= 0;
    
    /*
    var messageEntreeHeure 		= 6;
	var messageEntreeMinute 	= 0;
	var message1Heure 			= 9;
    var message1Minute 			= 0;
    var message2Heure 			= 12;
    var message2Minute 			= 0;
	var message3Heure 			= 15;
    var message3Minute 			= 0;
    var message4Heure 			= 18;
    var message4Minute 			= 0;
    var messageSortieHeure		= 21;
    var messageSortieMinute		= 0;
    */

    /**********************************************************/
    var tabMessages;	// Pour récup le tableau des messages selon la condition
    
	var today;			// var pour récup l'heure, la minute et la seconde courantes
	var timer; 			// Timer
	
	var userActuel = Application.getApp().userActuel;
	
	// ----- Sauvegarde dans le fichier de logs ----- //
	var heureRecord = 23;
	var minuteRecord = 45;
	
	// ----- Valeur de la batterie critique ----- //
	var minBattery = 5.0;
	var saveLowBattery = false;
	
    function initialize() {
        View.initialize();
        timer = new Timer.Timer();
    	timer.start(method(:callback),1000, true);
    	
        // Récup de la condition + du tableau correspondant *****************
		//<!-- prevention, promotion, aleatoire, sansCadrage -->
		
    	if (userActuel.condition.equals("prevention")){
    		tabMessages = {
    			"grpZ" => {"preEntree" => Rez.Strings.preEntree},
				"grpA" => {"preA1" => Rez.Strings.preA1, "preA2" => Rez.Strings.preA2, "preA8" => Rez.Strings.preA8, "preA9" => Rez.Strings.preA9},
			    "grpB" => {"preB4" => Rez.Strings.preB4, "preB5" => Rez.Strings.preB5, "preB8" => Rez.Strings.preB8},
				"grpC" => {"preC2" => Rez.Strings.preC2, "preC3" => Rez.Strings.preC3, "preC4" => Rez.Strings.preC4, "preC6" => Rez.Strings.preC6},
				"grpD" => {"preD4" => Rez.Strings.preD4, "preD6" => Rez.Strings.preD6, "preD10" => Rez.Strings.preD10, "preD11" => Rez.Strings.preD11},
				"grpE" => {"preE2" => Rez.Strings.preE2, "preE3" => Rez.Strings.preE3}
			};
    	}
    	else if (userActuel.condition.equals("promotion")){
    		tabMessages = {
				"grpZ" => {"proEntree" => Rez.Strings.proEntree},
				"grpA" => {"proA1" => Rez.Strings.proA1, "proA7" => Rez.Strings.proA7, "proA8" => Rez.Strings.proA8},
		        "grpB" => {"proB7" => Rez.Strings.proB7, "proB4" => Rez.Strings.proB4, "proB8" => Rez.Strings.proB8},
				"grpC" => {"proC8" => Rez.Strings.proC8, "proC7" => Rez.Strings.proC7, "proC3" => Rez.Strings.proC3},
				"grpD" => {"proD1" => Rez.Strings.proD1, "proD6" => Rez.Strings.proD6},
				"grpE" => {"proE4" => Rez.Strings.proE4, "proE2" => Rez.Strings.proE2, "proE3" => Rez.Strings.proE3}
			};
    	}
    	else if (userActuel.condition.equals("aleatoire")){
    		System.println("test");
    		tabMessages = {
				"grpZ" => {"preEntree" => Rez.Strings.preEntree, "proEntree" => Rez.Strings.proEntree},
				"grpA" => {"preA1" => Rez.Strings.preA1, "preA2" => Rez.Strings.preA2, "preA8" => Rez.Strings.preA8, "preA9" => Rez.Strings.preA9, "proA1" => Rez.Strings.proA1, "proA7" => Rez.Strings.proA7, "proA8" => Rez.Strings.proA8},
			    "grpB" => {"preB4" => Rez.Strings.preB4, "preB5" => Rez.Strings.preB5, "preB8" => Rez.Strings.preB8, "proB7" => Rez.Strings.proB7, "proB4" => Rez.Strings.proB4, "proB8" => Rez.Strings.proB8},
				"grpC" => {"preC2" => Rez.Strings.preC2, "preC3" => Rez.Strings.preC3, "preC4" => Rez.Strings.preC4, "preC6" => Rez.Strings.preC6, "proC8" => Rez.Strings.proC8, "proC7" => Rez.Strings.proC7, "proC3" => Rez.Strings.proC3},
				"grpD" => {"preD4" => Rez.Strings.preD4, "preD6" => Rez.Strings.preD6, "preD10" => Rez.Strings.preD10, "preD11" => Rez.Strings.preD11, "proD1" => Rez.Strings.proD1, "proD6" => Rez.Strings.proD6},
				"grpE" => {"preE2" => Rez.Strings.preE2, "preE3" => Rez.Strings.preE3, "proE4" => Rez.Strings.proE4, "proE2" => Rez.Strings.proE2, "proE3" => Rez.Strings.proE3}
			};
    	}
    	else if (userActuel.condition.equals("sansCadrage")){
    		tabMessages = {
    			"grpZ" => {"sansCadrageEntree" => Rez.Strings.sansCadrageEntree},
    			"grpA" => {"sansCadrageSortieAteint" => Rez.Strings.sansCadrageSortieAteint},
    			"grpE" => {"sansCadrageSortieNonAteint" => Rez.Strings.sansCadrageSortieNonAteint}
    		};
    	}
    	//***************************************************************
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
        
        //drawText(x, y, font, text, justification)
        dc.drawText( // Affichage de la date
        	dc.getWidth()/2, 
        	dc.getHeight()/4*3, 
        	Graphics.FONT_MEDIUM, 
        	today.day_of_week + " " + today.day, 
        	Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
        );
	    	
    }
	
	function callback() { // Permet d'actualiser l'interface toute les secondes
       	
       	var today = System.getClockTime(); // récupère l'heure et la minute courante
       	var sec = today.sec.toNumber();
       	
       	if (sec == 0){
	    		
				if (messageEntreeHeure.toNumber()==today.hour.toNumber()  // message d'entrer
				&& messageEntreeMinute.toNumber()==today.min.toNumber()) {
	       			afficherMessage(tabMessages["grpZ"], 0);
	       		}
	       		
	       		if (message1Heure.toNumber()==today.hour.toNumber() 	// 1er message
				&& message1Minute.toNumber()==today.min.toNumber()) {
					if (userActuel.condition.equals("sansCadrage")){
	       				logPerfSansCadrage(1);
	       			}
	       			else {
	       				afficherMessage(tabMessages["grpC"], 1);
	       			}
	       		}
	       		
	       		if (message2Heure.toNumber()==today.hour.toNumber() 	// 2eme message
				&& message2Minute.toNumber()==today.min.toNumber()) {
	 				if (userActuel.condition.equals("sansCadrage")){
	       				logPerfSansCadrage(2);
	       			}
	       			else {
	       				afficherMessage(tabMessages["grpC"], 2);
	       			}
	       		}
	       		
	       		if (message3Heure.toNumber()==today.hour.toNumber() 	//3eme message
				&& message3Minute.toNumber()==today.min.toNumber()) {
					if (userActuel.condition.equals("sansCadrage")){
	       				logPerfSansCadrage(3);
	       			}	
	       			else {
	       				afficherMessage(tabMessages["grpD"], 3);
	       			}
	       		}
	       		
	       		if (message4Heure.toNumber()==today.hour.toNumber() 	//4eme message
				&& message4Minute.toNumber()==today.min.toNumber()) {
					if (userActuel.condition.equals("sansCadrage")){
	       				logPerfSansCadrage(4);
	       			}
	       			else {
	       				afficherMessage(tabMessages["grpB"], 4);
					}       		
	       		}
	       		
	       		if (messageSortieHeure.toNumber()==today.hour.toNumber() 	//message de sortie
				&& messageSortieMinute.toNumber()==today.min.toNumber()) {
					var nbPasActuel = ActivityMonitor.getInfo().steps;		// nombre de pas actuel
					if (nbPasActuel >= 10000){
						afficherMessage(tabMessages["grpA"], 5);
					}
					else {
						afficherMessage(tabMessages["grpE"], 5);
					}
	       		}
	       		
	       		if (23==today.hour.toNumber() && 59==today.min.toNumber()) {
	       			userActuel.jourActuel.nbPas = ActivityMonitor.getInfo().steps; 
					userActuel.addJour();
	       		}
	       		
	       		if (1==today.hour.toNumber() && 1==today.min.toNumber()) {
					userActuel.newJour();
	       		}
	    }
	    
	    // ----- Ajout écriture dans le fichier de backup ----- //
		if(today.hour.toNumber() == heureRecord && today.min.toNumber() == minuteRecord){
			//System.print("0 sansCadrage 4DY553278 Samedi 9 0 23 1 sansCadrage1 0 0 0 0 sansCadrageEntree 14916 0 0 2 sansCadrage2 0 171 171 3 sansCadrage3 0 4027 4027 4 sansCadrage4 0 4540 4540 5 sansCadrageSortieNonAteint 3 5931 5931" + "#");
			var u = Application.getApp().userActuel;
			System.print(u.idParticipant + "," + u.condition + "," + u.idMontre);
			System.print(u.afficherJourCourant() + "#");
		}
		// ----- Fin ajout écriture dans le fichier de backup ----- //
		
		// ----- Surveillance de la batterie ----- //
		// Si on atteint 5% de batteries, peu importe l'heure on fais une sauvegarde de tout ce qu'on a actuellement
		var myStats = System.getSystemStats();
		
		if(myStats.battery <= minBattery && !saveLowBattery){ // si la batterie est <= 5% et qu'on a pas déjà sauvegarder pour la batterie 
		
			// Sauvegarde
			var u = Application.getApp().userActuel;
			System.print(u.idParticipant + "," + u.condition + "," + u.idMontre + u.afficherJourCourant() + "#");
			saveLowBattery = true;
		}
       
       	//Kick the display update
       	Ui.requestUpdate();
	}
	
	/* Fonction qui envoie le message selon le groupe choisi */
    function afficherMessage(groupe, type){
		//generate a random number between min and max 
		//=> min = 0 and max = groupe.size()-1
		//=> rand()%(max-min + 1) + min;
		var random = Math.rand()%(groupe.size()); 
		var tabKeys = groupe.keys(); //Tableau contenant les clés du groupe
    	var messageCode = tabKeys[random]; // Récupère une clé au hassard
    	var messageId = groupe.get(messageCode); // Récupère le message de la clé
    	
       	Ui.pushView(
       		new MessageView(true, messageId), 
       		new MessageViewDelegate(messageCode, type), 
       		Ui.SLIDE_IMMEDIATE
       	);
	}
	
	function logPerfSansCadrage(type){
		var appbase = Application.getApp();
		//addMessage(_type, _code, _tmps)
		var log = ActivityMonitor.getInfo().steps;
		appbase.userActuel.addMessage(type, "sansCadrage"+type, 0, log, log);
	}
	
}