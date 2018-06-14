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
		self.tabJours.add(jourActuel);
	}
	
	function newJour() {
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var stringToday = today.day_of_week + " " + today.day;
		self.jourActuel = new Jour(stringToday);
	}
	
	function addMessage(_type, _code, _tmps, log1, log2) { // ajouter les donénes du message envoyée dans la base locale
		jourActuel.addMessage(_type, _code, _tmps, log1, log2);
	}
	
	function printData(){
		var tab = [];
		var string = "";
		
		for(var i=0 ; i<tabJours.size(); i++){
		
			string += idParticipant+","+condition+","+idMontre+",";
			
			var iJour = tabJours[i].toString();
			//			nomJour		nbPasTotal	nbConsultationPas
			string += iJour[0]+","+iJour[1]+","+iJour[2]+",";
			
			for(var j=0; j<iJour[3].size(); j++){
				var jMessage = iJour[3][j].toString();
				
				string += 	jMessage[0]+","		//type
							+jMessage[1]+","	//code
							+jMessage[2]+","	//tmps
							+jMessage[3]+","	//logPerf1
							+jMessage[4]+",";	//logPerf2
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
	
	function addMessage(_type, _code, _tmps, log1, log2) {
		tabMessages.add(new Message(_type, _code, _tmps, log1, log2));
	}
	
	function toString(){
		return [jour, nbPas, nbConsultationPas, tabMessages];
	}
	
	function addConsultation(){
		self.nbConsultationPas = self.nbConsultationPas + 1;
	}
}

class Message {
	var type; 		//0 pour le message d'entrer, 1 pour le 1er message ainsi de suite
	var code;	 	//code du message
	var tmps;		//temps passé sur le message
	var log1;
	var log2;
	
	function initialize(_type, _code, _tmps, log1, log2) {
		self.type = _type;
		self.code = _code;
		self.tmps = _tmps;
		self.log1 = log1;
		self.log2 = log2;
	}
	
	function toString(){
		return [type, code, tmps, log1, log2];
	}
}