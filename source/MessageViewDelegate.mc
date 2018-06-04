using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;
using Toybox.Application;
using Toybox.ActivityMonitor;

class MessageViewDelegate extends Ui.BehaviorDelegate {

	var secMessage; //Timer
	
	var type;
	var messageCode;
	var secondes;
	
	var log1;
	var log2;

    function initialize(_messageCode, _type) {
        BehaviorDelegate.initialize();
        secondes = 0;
        type = _type;
        messageCode = _messageCode;
        log1 = ActivityMonitor.getInfo().steps;
        
        System.println("testAffichageMessageViewDelegate");
       	secMessage = new Timer.Timer();
        secMessage.start(method(:callback), 1000, true);
    }
    
    function callback() {
		secondes +=1;	
		if (secondes == (3600*6-60)) {
				secMessage.stop();
		}	
	}
	
	function onBack(){
		secMessage.stop();
		System.println("temps mit : " + secondes + "secondes");
				
		log2 = ActivityMonitor.getInfo().steps;
				
		var appbase = Application.getApp();
		appbase.userActuel.addMessage(type, messageCode, secondes, log1, log2);
       	
		System.println("finAddMessage");
		return false; 
	}
	

    
}