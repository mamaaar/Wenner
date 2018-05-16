using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Application;
using Toybox.ActivityMonitor;

class MessageViewDelegate extends Ui.BehaviorDelegate {

	var secMessage; //Timer
	
	var type;
	var messageCode;
	var secondes;
	var nbPas;

    function initialize(_messageCode, _type) {
        BehaviorDelegate.initialize();
        secondes = 0;
        type = _type;
        messageCode = _messageCode;
        nbPas = ActivityMonitor.getInfo().steps;
        
        System.println("testAffichageMessageViewDelegate");
       	secMessage = new Timer.Timer();
        secMessage.start(method(:incsec), 1000, true);
    }
    
    function incsec() {
		secondes +=1;	
	}
	
	function onBack(){
		secMessage.stop();
		System.println("temps mit : " + secondes + "secondes");
		var appbase = Application.getApp();
		appbase.userActuel.addMessage(type, messageCode, secondes, nbPas);
       	System.println("");
		System.println("finAddMessage");
	}
	

    
}