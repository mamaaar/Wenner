using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;
using Toybox.Math;
using Toybox.Communications;

var user = {};

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
    // Variables globales
    var condition; 		// Pour récupérer le type de condition de l'utilisateur
	var tabMessages;	// Pour récup le tableau des messages selon la condition
	
   	var timer; 			// Timer 
	var sec;			// Compteur pour refresh la page chaque seconde
	var today;
	
	/*******************************/
	function initialize() {
		makeRequest();
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
    	condition = Ui.loadResource(Rez.Strings.condition);
    		
    	if (condition.equals("prevention")){
    		tabMessages = {
				"grpA" => [Rez.Strings.preA1, Rez.Strings.preA2, Rez.Strings.preA8, Rez.Strings.preA9 ],
			    "grpB" => [Rez.Strings.preB4, Rez.Strings.preB5, Rez.Strings.preB8],
				"grpC" => [Rez.Strings.preC2, Rez.Strings.preC3, Rez.Strings.preC4, Rez.Strings.preC6],
				"grpD" => [Rez.Strings.preD4, Rez.Strings.preD6, Rez.Strings.preD10, Rez.Strings.preD11],
				"grpE" => [Rez.Strings.preE2, Rez.Strings.preE3]
			};
    	}
    	else if (condition.equals("promotion")){
    		tabMessages = {
				"grpA" => [Rez.Strings.proA1, Rez.Strings.proA1, Rez.Strings.proA7, Rez.Strings.proA8],
		        "grpB" => [Rez.Strings.proB7, Rez.Strings.proB4, Rez.Strings.proB8],
				"grpC" => [Rez.Strings.proC8, Rez.Strings.proC7, Rez.Strings.proC3],
				"grpD" => [Rez.Strings.proD1, Rez.Strings.proD6],
				"grpE" => [Rez.Strings.proE4, Rez.Strings.proE2, Rez.Strings.proE3]
			};
    	}
    	else if (condition.equals("aleatoire")){
    		tabMessages = {
				"grpA" => [Rez.Strings.proA1, Rez.Strings.proA1, Rez.Strings.proA7, Rez.Strings.proA8, Rez.Strings.preA1, Rez.Strings.preA2, Rez.Strings.preA8, Rez.Strings.preA9 ],
			    "grpB" => [Rez.Strings.proB7, Rez.Strings.proB4, Rez.Strings.proB8, Rez.Strings.preB4, Rez.Strings.preB5, Rez.Strings.preB8],
				"grpC" => [Rez.Strings.proC8, Rez.Strings.proC7, Rez.Strings.proC3, Rez.Strings.preC2, Rez.Strings.preC3, Rez.Strings.preC4, Rez.Strings.preC6],
				"grpD" => [Rez.Strings.proD1, Rez.Strings.proD6, Rez.Strings.preD4, Rez.Strings.preD6, Rez.Strings.preD10, Rez.Strings.preD11],
				"grpE" => [Rez.Strings.proE4, Rez.Strings.proE2, Rez.Strings.proE3, Rez.Strings.preE2, Rez.Strings.preE3]
			};
    	}
    	//***************************************************************
    	sec = 0;
    	timer = new Timer.Timer();
    	timer.start(method(:incsec),1000, true);
        AppBase.initialize();
    }
	// onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }
   
    
    function incsec() { // Fonction appelé toute les secondes
    	
		sec += 1;		// incrémente le compteur
       	System.println("wennerView" + sec);
       	if (sec%60 == 0){		// Toute les minutes cette partie vérifie si un message doit être affiché
    		today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM); // récupère l'heure, la minute et la seconde courantes
			
			if (messageEntreeHeure.toNumber()==today.hour.toNumber()  // message d'entrer
			&& messageEntreeMinute.toNumber()==today.min.toNumber()) {
    			var messageAenvoyer = Ui.loadResource(Rez.Strings.messageEntree);
    		
    			Application.getApp().setProperty("Message", messageAenvoyer);
       			Ui.switchToView(new MessageView(false), new MessageViewDelegate(), Ui.SLIDE_IMMEDIATE);
       		}
       		
       		if (message1Heure.toNumber()==today.hour.toNumber() 	// 1er message
			&& message1Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe C");
				envoyerMessageAleaGroupe(tabMessages["grpC"]);
       		}
       		
       		if (message2Heure.toNumber()==today.hour.toNumber() 	// 2eme message
			&& message2Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe C");
 				envoyerMessageAleaGroupe(tabMessages["grpC"]);
       		}
       		
       		if (message3Heure.toNumber()==today.hour.toNumber() 	//3eme message
			&& message3Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe Entrer D");
				envoyerMessageAleaGroupe(tabMessages["grpD"]);
       		}
       		
       		if (message4Heure.toNumber()==today.hour.toNumber() 	//4eme message
			&& message4Minute.toNumber()==today.min.toNumber()) {
				System.println("message du groupe B");
				envoyerMessageAleaGroupe(tabMessages["grpB"]);
       		}
       		
       		if (messageSortieHeure.toNumber()==today.hour.toNumber() 	//message de sortie
			&& messageSortieMinute.toNumber()==today.min.toNumber()) {
				var nbPasActuel = ActivityMonitor.getInfo().steps;		// nombre de pas actuel
				System.println("message du groupe Sortie");
				if (nbPasActuel >= 10000){
					envoyerMessageAleaGroupe(tabMessages["grpA"]);
				}
				else {
					System.println(tabMessages["grpE"]);
					envoyerMessageAleaGroupe(tabMessages["grpE"]);
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
       	Ui.pushView(new MessageView(true), new MessageViewDelegate(), Ui.SLIDE_IMMEDIATE);
	}

    // Return the initial view of your application here
    function getInitialView() {
        return [ new WennerView() , new WennerDelegate() ];
    }
    
    // set up the response callback function
   function onReceive(responseCode, data) {
       if (responseCode == 200) {
           System.println("Request Successful");                   	// print success
       }
       else {
           System.println("Response - sending failed: " + responseCode);           	// print response code
       }

   }
   
   function makeRequest() {   		
       	var url = Ui.loadResource(Rez.Strings.URL_dataRegister);	// set the url

       	var params = {                                              // set the parameters
              "definedParams" => "123456789abcdefg"
       	};

       	var options = {                                             // set the options
           :method => Communications.HTTP_REQUEST_METHOD_POST,      // set HTTP method
           :headers => {                                           // set headers
                   "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON
                   },
                                                                   // set response type
           :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
       	};

       // Make the Communications.makeWebRequest() call
       Communications.makeWebRequest(url, params, options, method(:onReceive));
  }

}
