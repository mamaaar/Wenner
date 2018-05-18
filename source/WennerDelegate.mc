using Toybox.WatchUi as Ui;

class WennerDelegate extends Ui.BehaviorDelegate {

	var pasView = new PasView();
	var pasDelegate = new PasDelegate();
	
	var timerUp; 			// Timer
	var timerDown;
	var secKeyUp;
	var secKeyDown;
	var okKeyUp;
	var okKeyDown;
	
	var first; 
	var second; 
	var third;

    function initialize() {
        BehaviorDelegate.initialize();
    	timerUp = new Timer.Timer();
    	timerDown = new Timer.Timer();
    	secKeyUp = 0;
		secKeyDown = 0;
		okKeyUp = false;
		okKeyDown = false;
    }
    
    
    function incsecDown() {
		secKeyDown += 1;
		if (secKeyDown > 5) {
			System.println("InitialiseDown");
			okKeyUp = false;
			okKeyDown = false;
			secKeyUp = 0;
			secKeyDown = 0;
			timerDown.stop();
			timerUp.stop();
			
		}
	}
	
	function incsecUp() {
		secKeyUp += 1;
		if (secKeyUp > 5) {
			System.println("InitialiseUp");
			okKeyDown = false;
			okKeyUp = false;
			secKeyUp = 0;
			secKeyDown = 0;
			timerUp.stop();
			timerDown.stop();
		}
	}
	
	function onPreviousPage() {//UP
		okKeyUp = true;
		if (!okKeyDown) {
			System.println("timerupstart");
			timerUp.start(method(:incsecUp),100, true);
		}
		if (okKeyDown && okKeyUp) {
			System.println("Initialise");
			timerUp.stop();
			timerDown.stop();
			secKeyUp = 0;
			secKeyDown = 0;
			okKeyDown = false;
			okKeyUp = false;
			System.println("Vue parametre");
			Ui.pushView(new HistoryView(), new HistoryDelegate(), Ui.SLIDE_UP);
		} 
	}
	
	function onNextPage() {//DOWN
		if (okKeyUp) {
			okKeyDown = true;
			timerUp.stop();
			timerDown.start(method(:incsecDown),100, true);
		}
	}
	
	function onSelect() {
		Ui.pushView(pasView, pasDelegate, Ui.SLIDE_LEFT);
	}
	
	function onBack() {
		return true;
	}

}