using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Act;

class HistoryView extends Ui.View {

    // Constructor
    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.HistoryLayout(dc));
    }

    // Handle the update event
    function onUpdate(dc) {
        View.onUpdate(dc);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var actHistArray = Act.getHistory();
        var padding = 10;
        var string = "";
        var fontHeight = Gfx.getFontHeight(Gfx.FONT_TINY);

        if (null != actHistArray && actHistArray.size() > 0) {
            // Loop through array of history items
            for (var i = 0; i < actHistArray.size(); i += 1) {
                dc.drawText((dc.getWidth() / 4), padding +  fontHeight * (i+2), Gfx.FONT_TINY, (i+1).toString(), Gfx.TEXT_JUSTIFY_CENTER);
                // Validate that each element is non-null
                if (null != actHistArray[i] && null != actHistArray[i].steps) {
                    string = actHistArray[i].steps.toString();
                    dc.drawText((dc.getWidth() / 4*3), padding + fontHeight * (i+2), Gfx.FONT_TINY, string, Gfx.TEXT_JUSTIFY_CENTER);
                }
            }
        }
    }
}