using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Application;
using Toybox.ActivityMonitor;

class MessageViewDelegate extends Ui.BehaviorDelegate {

	var secMessage; //Timer
	
	var type;
	var messageCode;
	var secondes;

    function initialize(_messageCode, _type) {
        BehaviorDelegate.initialize();
        secondes = 0;
        type = _type;
        messageCode = _messageCode;
        
        System.println("testAffichageMessageViewDelegate");
       	secMessage = new Timer.Timer();
        secMessage.start(method(:incsec), 1000, true);
    }
    
    function incsec() {
		secondes +=1;	
		if (secondes == (3600*6-60)) {
				secMessage.stop();
		}	
	}
	
	function onBack(){
		secMessage.stop();
		System.println("temps mit : " + secondes + "secondes");
		var appbase = Application.getApp();
		var nbPas = ActivityMonitor.getInfo().steps;
		
		appbase.userActuel.addMessage(type, messageCode, secondes, nbPasActuel);
       	
		System.println("finAddMessage");
		System.println("");
	}
	

    
}