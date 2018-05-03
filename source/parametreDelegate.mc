using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class parametreDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }
    
    // Handle key  events
    function onKey(evt) {
        var app = App.getApp();
        var key = evt.getKey();
        
        if (Ui.KEY_DOWN == key) {
            app.parametreVue.incIndex();
        } 
        else if (Ui.KEY_UP == key) {
            app.parametreVue.decIndex();
        } 
        else if (Ui.KEY_ENTER == key) {
        	app.parametreVue.action();
        } 
        else if (Ui.KEY_START == key) {
        	app.parametreVue.action();
        } 
        else {
            return false;
        }
        Ui.requestUpdate();
        return true;
    }

}


class paramTypeMessageDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }
    
    // Handle key  events
    function onKey(evt) {
        var app = App.getApp();
        var key = evt.getKey();
        
        if (Ui.KEY_DOWN == key) {
            app.paramTypeMessageVue.incIndex();
        } 
        else if (Ui.KEY_UP == key) {
            app.paramTypeMessageVue.decIndex();
        }
        else if (Ui.KEY_ESC == key){
        	Ui.pushView(new parametreVue(), new parametreDelegate(), Ui.SLIDE_UP);
        }
        else if (Ui.KEY_ENTER == key) {
        	app.paramTypeMessageVue.action();
        } 
        else if (Ui.KEY_START == key) {
        	app.paramTypeMessageVue.action();
        } 
        else {
            return false;
        }
        Ui.requestUpdate();
        return true;
    }
}


class paramMessagesDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return true;
    }
    
    // Handle key  events
    function onKey(evt) {
        var app = App.getApp();
        var key = evt.getKey();
        
        if (Ui.KEY_DOWN == key) {
            app.paramMessagesVue.incIndex();
        } 
        else if (Ui.KEY_UP == key) {
            app.paramMessagesVue.decIndex();
        }
        else if (Ui.KEY_ESC == key){
        	Ui.pushView(new parametreVue(), new parametreDelegate(), Ui.SLIDE_UP);
        }
        else if (Ui.KEY_ENTER == key) {
        	app.paramMessagesVue.action();
        } 
        else if (Ui.KEY_START == key) {
        	app.paramMessagesVue.action();
        } 
        else {
            return false;
        }
        Ui.requestUpdate();
        return true;
    }
}