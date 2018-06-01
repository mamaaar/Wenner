using Toybox.WatchUi as Ui;

class WennerDelegate extends Ui.BehaviorDelegate {

	var timer;
	var sec;
	
	var key1; 
	var key2; 
	var key3;
	var key4;
	var key5;

    function initialize() {
        BehaviorDelegate.initialize();
    	timer = new Timer.Timer();
    	sec = 0;
    	
		key1 = false; 
		key2 = false; 
		key3 = false;
		key4 = false; 
		key5 = false;
    }
    
    
    function incsec() {
		sec += 1;
		if (sec > 10) {
			initKey();
		}
	}
	
	function onPreviousPage() {//UP
		key1 = true;
		timer.start(method(:incsec),100, true);
		if (key2) { key3 = true; }
		if (key4) { Ui.pushView(new HistoryView(), new HistoryDelegate(), Ui.SLIDE_UP); }
		return true;		
	}
	
	function onNextPage() {//DOWN
		if (key1) { key2 = true; }
		if (key3) { key4 = true; }
		return true;
	}
	
	function initKey() {
		System.println("initKey");
		timer.stop();
		sec=0;
		key1 = false; 
		key2 = false; 
		key3 = false;
		key4 = false; 
		key5 = false;
	}
	
	function onSelect() {
		Ui.pushView(new PasView(), new PasDelegate(), Ui.SLIDE_LEFT);
	}
	
	function onBack() {
		return true;
	}

}