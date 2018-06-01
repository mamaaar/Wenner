using Toybox.WatchUi as Ui;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor as Act;

class HistoryDelegate extends Ui.BehaviorDelegate {

	//var timer; // pour appui long
	//var sec;
	
	
	var menu = new Ui.Menu();
    var delegate = new BigHistoDelegate(); // a WatchUi.MenuInputDelegate
    
    var itemId = [:item_1, :item_2, :item_3, :item_4, :item_5, :item_6, :item_7];
    
    /*var jour = {
    	"Mon" => "Lundi",
    	"Tue" => "Mardi",
    	"Wed" => "Mercredi",
    	"Thurs" => "Jeudi",
    	"Fri" => "Vendredi",
    	"Sat" => "Samedi",
    	"Sun" => "Dimanche"
    };*/
	
    // Constructor
    function initialize() {
        BehaviorDelegate.initialize();
        
        //sec = 0;
        //timer = new Timer.Timer();
        
        menu.setTitle("Historique");
        
        var actHistArray = Act.getHistory();
        var string = "";

        if (null != actHistArray && actHistArray.size() > 0) {
            for (var i = 0; i < 7; i += 1) {
                if (null != actHistArray[i] && null != actHistArray[i].steps) {
                	//var day = new Time.Moment(actHistArray[i].startOfDay.value());
                	//var date = Gregorian.info(day, Time.FORMAT_MEDIUM);
                	//var dayOfWeek = jour[date.day_of_week];
                	//System.println(dayOfWeek);
                    //string = dayOfWeek.toString() + " : " + actHistArray[i].steps.toString();
                    string = actHistArray[i].steps.toString();
                    menu.addItem(string, itemId[i]);
                    string = "";
                }
            }
        }
    }

    function incTimer(){
    	sec ++;
    }
    
    function onSelect() {
    	Ui.pushView(menu, delegate, Ui.SLIDE_LEFT); 
    }
    
}