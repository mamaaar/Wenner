using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class WennerApp extends App.AppBase {

	var userActuel;
	
    function initialize() {
        AppBase.initialize();
        userActuel = new User(); // Donn�e que l'on va r�cuper � la fin de l'exp�rimentation
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new WennerView() , new WennerDelegate() ];
    }

}