using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Communications;

class User {
	var idParticipant = Ui.loadResource(Rez.Strings.idParticipant);
	var condition = Ui.loadResource(Rez.Strings.condition);
	var idMontre = Ui.loadResource(Rez.Strings.idMontre);
	var tabJours = [];
	
	var jourActuel;
	
	function initialize() {
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var stringToday = today.day_of_week + " " + today.day;
		
		self.jourActuel = new Jour(stringToday);
	}
	
	function addJour() {  // ajouter les données de la journée dans la base locale
		self.jourActuel.nbPas = ActivityMonitor.getInfo().steps;
		self.tabJours.add(jourActuel);
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var stringToday = today.day_of_week + " " + today.day;
		
		self.jourActuel = new Jour(stringToday);
	}
	
	function updateAvantMinuit() {  // ajouter les données de la journée dans la base locale
		self.jourActuel.nbPas = ActivityMonitor.getInfo().steps;
	}
	
	function addMessage(_type, _code, _tmps, _nbPas) { // ajouter les donénes du message envoyée dans la base locale
		jourActuel.addMessage(_type, _code, _tmps, _nbPas);
	}
	
	function toString() {
		System.println(idParticipant);
		System.println(condition);
		System.println(idMontre);
		System.println(tabJours);
	}
	
}

class Jour {
	var jour;
	var nbPas;
	var tabMessages = [];
	
	function initialize(_jour) {
		self.nbPas = ActivityMonitor.getInfo().steps;
		self.jour = _jour;
	}
	
	function addMessage(_type, _code, _tmps, _nbPas) {
		self.nbPas = ActivityMonitor.getInfo().steps;
		tabMessages.add(new Message(_type, _code, _tmps, _nbPas));
	}
}

class Message {
	var type; 		//0 pour le message d'entrer, 1 pour le 1er message ainsi de suite
	var code;	 	//code du message
	var tmps;		//temps passé sur le message
	var nbPas;
	
	function initialize(_type, _code, _tmps, _nbPas) {
		self.type = _type;
		self.code = _code;
		self.tmps = _tmps;
		self.nbPas = _nbPas;
	}
}

class WennerApp extends App.AppBase {
	
	/***********Heure des messages définit en absolu***********/ 
	var messageEntreeHeure;
	var messageEntreeMinute;
	var message1Heure;
	var message1Minute;
	var message2Heure;
	var message2Minute;
	var message3Heure;
	var message3Minute;
	var message4Heure;
	var message4Minute;
	var messageSortieHeure;
	var messageSortieMinute;
    /**********************************************************/
    // Variable globale
    var userActuel;
	var tabMessages;	// Pour récup le tableau des messages selon la condition
	
   	var timer; 			// Timer 
	var sec;			// Compteur pour refresh la page chaque seconde	
	/*******************************/
	function initialize() {
	
		userActuel = new User(); // Donnée que l'on va récuper à la fin de l'expérimentation
			
		messageEntreeHeure = Ui.loadResource(Rez.Strings.HeureMessageEntree).substring(0,2);
		messageEntreeMinute = Ui.loadResource(Rez.Strings.HeureMessageEntree).substring(3,5);
		
		message1Heure = Ui.loadResource(Rez.Strings.HeureMessage1).substring(0,2);
	    message1Minute = Ui.loadResource(Rez.Strings.HeureMessage1).substring(3,5);
	    
	    message2Heure = Ui.loadResource(Rez.Strings.HeureMessage2).substring(0,2);
	    message2Minute = Ui.loadResource(Rez.Strings.HeureMessage2).substring(3,5);
	    
		message3Heure = Ui.loadResource(Rez.Strings.HeureMessage3).substring(0,2); 
	    message3Minute = Ui.loadResource(Rez.Strings.HeureMessage3).substring(3,5);
	    
	    message4Heure = Ui.loadResource(Rez.Strings.HeureMessage4).substring(0,2); 
	    message4Minute = Ui.loadResource(Rez.Strings.HeureMessage4).substring(3,5);
	    
	    messageSortieHeure = Ui.loadResource(Rez.Strings.HeureMessageSortie).substring(0,2);
	    messageSortieMinute = Ui.loadResource(Rez.Strings.HeureMessageSortie).substring(3,5);
        
		// Récup de la condition + du tableau correspondant *****************
		//<!-- prevention, promotion, aleatoire -->
		
    	if (userActuel.condition.equals("prevention")){
    		tabMessages = {
				"grpA" => {"preA1" => Rez.Strings.preA1, "preA2" => Rez.Strings.preA2, "preA8" => Rez.Strings.preA8, "preA9" => Rez.Strings.preA9},
			    "grpB" => {"preB4" => Rez.Strings.preB4, "preB5" => Rez.Strings.preB5, "preB8" => Rez.Strings.preB8},
				"grpC" => {"preC2" => Rez.Strings.preC2, "preC3" => Rez.Strings.preC3, "preC4" => Rez.Strings.preC4, "preC6" => Rez.Strings.preC6},
				"grpD" => {"preD4" => Rez.Strings.preD4, "preD6" => Rez.Strings.preD6, "preD10" => Rez.Strings.preD10, "preD11" => Rez.Strings.preD11},
				"grpE" => {"preE2" => Rez.Strings.preE2, "preE3" => Rez.Strings.preE3}
			};
    	}
    	else if (userActuel.condition.equals("promotion")){
    		tabMessages = {
				"grpA" => {"proA1" => Rez.Strings.proA1, "proA7" => Rez.Strings.proA7, "proA8" => Rez.Strings.proA8},
		        "grpB" => {"proB7" => Rez.Strings.proB7, "proB4" => Rez.Strings.proB4, "proB8" => Rez.Strings.proB8},
				"grpC" => {"proC8" => Rez.Strings.proC8, "proC7" => Rez.Strings.proC7, "proC3" => Rez.Strings.proC3},
				"grpD" => {"proD1" => Rez.Strings.proD1, "proD6" => Rez.Strings.proD6},
				"grpE" => {"proE4" => Rez.Strings.proE4, "proE2" => Rez.Strings.proE2, "proE3" => Rez.Strings.proE3}
			};
    	}
    	else if (userActuel.condition.equals("aleatoire")){
    		tabMessages = {
				"grpA" => {"preA1" => Rez.Strings.preA1, "preA2" => Rez.Strings.preA2, "preA8" => Rez.Strings.preA8, "preA9" => Rez.Strings.preA9, "proA1" => Rez.Strings.proA1, "proA7" => Rez.Strings.proA7, "proA8" => Rez.Strings.proA8},
			    "grpB" => {"preB4" => Rez.Strings.preB4, "preB5" => Rez.Strings.preB5, "preB8" => Rez.Strings.preB8, "proB7" => Rez.Strings.proB7, "proB4" => Rez.Strings.proB4, "proB8" => Rez.Strings.proB8},
				"grpC" => {"preC2" => Rez.Strings.preC2, "preC3" => Rez.Strings.preC3, "preC4" => Rez.Strings.preC4, "preC6" => Rez.Strings.preC6, "proC8" => Rez.Strings.proC8, "proC7" => Rez.Strings.proC7, "proC3" => Rez.Strings.proC3},
				"grpD" => {"preD4" => Rez.Strings.preD4, "preD6" => Rez.Strings.preD6, "preD10" => Rez.Strings.preD10, "preD11" => Rez.Strings.preD11, "proD1" => Rez.Strings.proD1, "proD6" => Rez.Strings.proD6},
				"grpE" => {"preE2" => Rez.Strings.preE2, "preE3" => Rez.Strings.preE3, "proE4" => Rez.Strings.proE4, "proE2" => Rez.Strings.proE2, "proE3" => Rez.Strings.proE3}
			};
    	}
    	else if (userActuel.condition.equals("sansCadrage")){
    		tabMessages = {
    			"grpA" => {"sansCadrageSortieAteint" => Rez.Strings.sansCadrageSortieAteint},
    			"grpB" => {"sansCadrage4" => Rez.Strings.sansCadrage4},
    			"grpC" => {"sansCadrage1" => Rez.Strings.sansCadrage1, "sansCadrage2" => Rez.Strings.sansCadrage2},
    			"grpD" => {"sansCadrage3" => Rez.Strings.sansCadrage3},
    			"grpE" => {"sansCadrageSortieNonAteint" => Rez.Strings.sansCadrageSortieNonAteint}
    		};
    	}
    	//***************************************************************
    	sec = 0;
    	timer = new Timer.Timer();
    	timer.start(method(:incsec),1000, true);
        AppBase.initialize();
    }
    
    function incsec() { // Fonction appelé toute les secondes
    	
		sec += 1;		// incrémente le compteur
       	System.println("wennerView" + sec);
       	if (sec%60 == 0){		// Toute les minutes cette partie vérifie si un message doit être affiché
    		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM); // récupère l'heure, la minute et la seconde courantes
			
			if (messageEntreeHeure.toNumber()==today.hour.toNumber()  // message d'entrer
			&& messageEntreeMinute.toNumber()==today.min.toNumber()) {
       			Ui.switchToView(new MessageView(false, Rez.Strings.messageEntree), new MessageViewDelegate("messageEntrer", 0), Ui.SLIDE_IMMEDIATE);
       		}
       		
       		if (message1Heure.toNumber()==today.hour.toNumber() 	// 1er message
			&& message1Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe C");
				envoyerMessageAleaGroupe(tabMessages["grpC"], 1);
       		}
       		
       		if (message2Heure.toNumber()==today.hour.toNumber() 	// 2eme message
			&& message2Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe C");
 				envoyerMessageAleaGroupe(tabMessages["grpC"], 2);
       		}
       		
       		if (message3Heure.toNumber()==today.hour.toNumber() 	//3eme message
			&& message3Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe Entrer D");
				envoyerMessageAleaGroupe(tabMessages["grpD"], 3);
       		}
       		
       		if (message4Heure.toNumber()==today.hour.toNumber() 	//4eme message
			&& message4Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe B");
				envoyerMessageAleaGroupe(tabMessages["grpB"], 4);
       		}
       		
       		if (messageSortieHeure.toNumber()==today.hour.toNumber() 	//message de sortie
			&& messageSortieMinute.toNumber()==today.min.toNumber()) {
				var nbPasActuel = ActivityMonitor.getInfo().steps;		// nombre de pas actuel
				System.println("message du groupe Sortie");
				if (nbPasActuel >= 10000){
					userActuel.addJour();
					System.println(tabMessages["grpA"]);
					envoyerMessageAleaGroupe(tabMessages["grpA"], 5);
				}
				else {
					userActuel.addJour();
					System.println(tabMessages["grpE"]);
					envoyerMessageAleaGroupe(tabMessages["grpE"], 5);
				}
       		}
       		
       		if (4==today.hour.toNumber() && 00==today.min.toNumber()) {
       			userActuel.addJour();
       		}
       }
       	//Kick the display update
       	Ui.requestUpdate();
	}
	
	/* Fonction qui envoie le message selon le groupe choisi */
    function envoyerMessageAleaGroupe(groupe, type){
		var random = Math.rand()%(groupe.size()); //To generate a random number between min and max => rand()%(max-min + 1) + min;
		var tabKeys = groupe.keys();
    	var messageCode = tabKeys[random]; // Récupère un Id au hassard dans le groupe (tableau)
    	System.println(messageCode);
    	var messageId = groupe.get(messageCode);
    	System.println(messageId);
    	
       	Ui.pushView(new MessageView(true, messageId), new MessageViewDelegate(messageCode, type), Ui.SLIDE_IMMEDIATE);
	}
	
    // Return the initial view of your application here
    function getInitialView() {
        return [ new WennerView() , new WennerDelegate() ];
    }
}
