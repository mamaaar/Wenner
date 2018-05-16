using Toybox.WatchUi as Ui;

class WennerDelegate extends Ui.BehaviorDelegate {

	var pasView = new PasView();
	var pasDelegate = new PasDelegate();

    function initialize() {
        BehaviorDelegate.initialize();
    }

	function onSelect() {
		Ui.pushView(pasView, pasDelegate, Ui.SLIDE_LEFT);
	}
	
	function onBack() {
		return true;
	}
	
	function onBack() {
		return true;
	}	

}