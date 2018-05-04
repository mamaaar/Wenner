//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Sensor as Snsr;
using Toybox.Application as App;
using Toybox.Position as GPS;
using Toybox.Timer;

class SensorView extends Ui.View
{
    var coeur; //variable pour le logo coeur
	
	var string_HR;
    var HR_graph;

    //! Constructor
    function initialize()
    {
        View.initialize();			
    	Snsr.setEnabledSensors( [Snsr.SENSOR_HEARTRATE] );
        Snsr.enableSensorEvents( method(:onSnsr) );
        HR_graph = new LineGraph( 20, 10, Gfx.COLOR_RED );

        string_HR = "---bpm";
    }

    //! Handle the update event
    function onUpdate(dc)
    {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        
        coeur = new Ui.Bitmap({	:rezId=>Rez.Drawables.coeur,
        						:locX=>85,
        						:locY=>45}
        					);
        coeur.draw(dc);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
		var stringFc = Ui.loadResource( Rez.Strings.FcTitle );
        dc.drawText(dc.getWidth()/2,30, Gfx.FONT_SMALL, stringFc, Gfx.TEXT_JUSTIFY_CENTER);
        
        dc.drawText(dc.getWidth() / 2, 90, Gfx.FONT_LARGE, string_HR, Gfx.TEXT_JUSTIFY_CENTER);
        
        var hrIterator = ActivityMonitor.getHeartRateHistory(null, false);
		var maxHR = hrIterator.getMax();
       	var minHR = hrIterator.getMin();
       	
       	dc.drawText(dc.getWidth()/2, dc.getHeight()/4*3 - 15, Gfx.FONT_SMALL, "Basse: " + minHR + " / Haute: " + maxHR, Gfx.TEXT_JUSTIFY_CENTER);

        HR_graph.draw(dc, [0, 0], [dc.getWidth(), dc.getHeight()]);
		
    }

    function onSnsr(sensor_info)
    {
        var HR = sensor_info.heartRate;
        var bucket;
        if( sensor_info.heartRate != null )
        {
            string_HR = HR.toString() + " bpm";

            //Add value to graph
            HR_graph.addItem(HR);
        }
        else
        {
            string_HR = "---bpm";
        }

        Ui.requestUpdate();
    }
    
}


class SensorDelegate extends Ui.BehaviorDelegate {
	
    function initialize() {
        BehaviorDelegate.initialize();
    }
    
    function onNextPage() { //when Key up
    	Ui.pushView(new PasView(), new PasDelegate(), Ui.SLIDE_UP);
    }
    
    function onPreviousPage() { //when Key down
    	Ui.pushView(new PasView(), new PasDelegate(), Ui.SLIDE_DOWN);
    }
    
}
