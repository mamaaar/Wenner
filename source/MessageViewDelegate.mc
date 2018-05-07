using Toybox.WatchUi as Ui;
using Toybox.Timer as Timer;

class MessageViewDelegate extends Ui.BehaviorDelegate {

	var secMessage; //Timer
	var minutes=0;
	var secondes=0;
	var milliSecs=0;

    function initialize() {
        BehaviorDelegate.initialize();
        System.println("testAffichageMessageViewDelegate");
       	secMessage = new Timer.Timer();
        secMessage.start(method(:incsec), 50, true);
    }
    
    function incsec() {
		milliSecs += 50;
		if(milliSecs == 1000){
			milliSecs=0;
			secondes +=1;
			if(secondes==60){
				secondes=0;
				minutes+=1; 
			}
		}
	}
	
	function onSelect(){
		secMessage.stop();
		System.println("temps mit : " + minutes + " minutes " + secondes + " secondes " + milliSecs + " milisecondes");
		Ui.pushView(new WennerView(), new WennerDelegate(), Ui.SLIDE_LEFT);
	}
	

    
}