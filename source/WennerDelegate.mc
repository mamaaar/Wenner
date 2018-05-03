using Toybox.WatchUi as Ui;

class WennerDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

	function onSelect() {
		Ui.pushView(new PasView(), new PasDelegate(), Ui.SLIDE_LEFT);
	}

}