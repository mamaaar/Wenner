using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;

class User {
	var idParticipant;
	var condition;
	var idMontre;
	var tabJours;
		
	var jourActuel;
	
	function initialize() {
		idParticipant = Ui.loadResource(Rez.Strings.idParticipant);
		condition = Ui.loadResource(Rez.Strings.condition);
		idMontre = Ui.loadResource(Rez.Strings.idMontre);
		tabJours = [];
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var stringToday = today.day_of_week + " " + today.day;
		self.jourActuel = new Jour(stringToday);
	}
	
	function addJour() {  // ajouter les données de la journée dans la base locale
		System.println("addJour");
		self.tabJours.add(jourActuel);
	}
	
	function newJour() {
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var stringToday = today.day_of_week + " " + today.day;
		self.jourActuel = new Jour(stringToday);
	}
	
	function addMessage(_type, _code, _tmps, _nbPas) { // ajouter les donénes du message envoyée dans la base locale
		jourActuel.addMessage(_type, _code, _tmps, _nbPas);
	}
	
	function affichage(){
		var tab = [];
		var string = "";
		string += idParticipant+","+condition+","+idMontre+",";
		
		for(var i=0 ; i<tabJours.size(); i++){
			var iJour = tabJours[i].toString();
			//			nomJour		nbPasTotal
			string += iJour[0]+","+iJour[1]+","+iJour[3]+",";
			
			for(var j=0; j<iJour[2].size(); j++){
				var jMessage = iJour[2][j].toString();
				//			type			code			tmps			nbPas		
				string += jMessage[0]+","+jMessage[1]+","+jMessage[2]+","+jMessage[3]+",";
			}
			tab.add(string);
			string = "";
			}
		return tab;
	}
	
	function toString() {
		return [idParticipant, condition, idMontre, tabJours];
	}	
}
class Jour {
	var jour;
	var nbPas;
	var nbConsultationPas;
	var tabMessages = [];
	
	function initialize(_jour) {
		self.nbPas = ActivityMonitor.getInfo().steps;
		self.jour = _jour;
		self.nbConsultationPas = 0;
	}
	
	function addMessage(_type, _code, _tmps, _nbPas) {
		tabMessages.add(new Message(_type, _code, _tmps, _nbPas));
	}
	
	function toString(){
		return [jour, nbPas, tabMessages, nbConsultationPas];
	}
	
	function addConsultation(){
		nbConsultationPas += 1;
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
	
	function toString(){
		return [type, code, tmps, nbPas];
	}
}