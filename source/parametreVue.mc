using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Attention;
using Toybox.System as Sys;

var selectedIndex;
var mainText;

class parametreVue extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
        selectedIndex = 1;
        mainText = Rez.Layouts.MainText(dc);
        setLayout(mainText);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();
        
        // Draw selected box
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, selectedIndex * dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        // Draw frames
        dc.drawLine(0, dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.drawLine(0, 2 * dc.getHeight() / 3, dc.getWidth(), 2 * dc.getHeight() / 3);

        var titreLabel = View.findDrawableById("Parametre");
        var typeMessagesLabel = View.findDrawableById("Type_de_messages");
        var messagesLabel = View.findDrawableById("Messages");

        titreLabel.setText("Parametre");
		typeMessagesLabel.setText("Type de messages");
		messagesLabel.setText("Messages");
		
		// Draw text fields in layout
        for (var i = 0; i < mainText.size(); i+=1) {
            mainText[i].draw(dc);
        }
    
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    
    // Decrement the currently selected option index
    function incIndex() {
        if (null != selectedIndex) {
            selectedIndex += 1;
            if (2 < selectedIndex) {
                selectedIndex = 1;
            }
        }
    }

    // Decrement the currently selected option index
    function decIndex() {
        if (null != selectedIndex) {
            selectedIndex -= 1;
            if (1 > selectedIndex) {
                selectedIndex = 2;
            }
        }
    }
    
     // Process the current attention action
    function action() {
    	if (selectedIndex == 1){
    		Ui.pushView(new paramTypeMessageVue(), new paramTypeMessageDelegate(), Ui.SLIDE_UP);
    	}
    	if (selectedIndex == 2){
    		Ui.pushView(new paramMessagesVue(), new paramTypeMessageDelegate(), Ui.SLIDE_UP);
    	}
    	return true;
    }
    
}

/********************************************************************************************/
//------------------------------------------------------------------------------------------
/********************************************************************************************/

class paramTypeMessageVue extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
        selectedIndex = 1;
        mainText = Rez.Layouts.MainText(dc);
        setLayout(mainText);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();
        
        // Draw selected box
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, selectedIndex * dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        // Draw frames
        dc.drawLine(0, dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.drawLine(0, 2 * dc.getHeight() / 3, dc.getWidth(), 2 * dc.getHeight() / 3);

        var titreLabel = View.findDrawableById("Type_de_messages2");
        var typeMessagesLabel = View.findDrawableById("Promotion");
        var messagesLabel = View.findDrawableById("Prevention");

        titreLabel.setText("Type de messages");
		typeMessagesLabel.setText("Promotion");
		messagesLabel.setText("Prevention");
		
		// Draw text fields in layout
        for (var i = 0; i < mainText.size(); i+=1) {
            mainText[i].draw(dc);
        }
    
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    
    // Decrement the currently selected option index
    function incIndex() {
        if (null != selectedIndex) {
            selectedIndex += 1;
            if (2 < selectedIndex) {
                selectedIndex = 1;
            }
        }
    }

    // Decrement the currently selected option index
    function decIndex() {
        if (null != selectedIndex) {
            selectedIndex -= 1;
            if (1 > selectedIndex) {
                selectedIndex = 2;
            }
        }
    }
    
    // Process the current attention action
    function action() {
    	if (selectedIndex == 1){
    	}
    	if (selectedIndex == 2){
    	}
    	return true;
    }

}

/********************************************************************************************/
//------------------------------------------------------------------------------------------
/********************************************************************************************/

class paramMessagesVue extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
        selectedIndex = 1;
        mainText = Rez.Layouts.MainText(dc);
        setLayout(mainText);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();
        
        // Draw selected box
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, selectedIndex * dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        
        // Draw frames
        dc.drawLine(0, dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.drawLine(0, 2 * dc.getHeight() / 3, dc.getWidth(), 2 * dc.getHeight() / 3);

        var titreLabel = View.findDrawableById("Messages2");
        var typeMessagesLabel = View.findDrawableById("Semaine");
        var messagesLabel = View.findDrawableById("Week_end");

        titreLabel.setText("Messages");
		typeMessagesLabel.setText("Semaine");
		messagesLabel.setText("Week_end");
		
		// Draw text fields in layout
        for (var i = 0; i < mainText.size(); i+=1) {
            mainText[i].draw(dc);
        }
    
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    
    // Decrement the currently selected option index
    function incIndex() {
        if (null != selectedIndex) {
            selectedIndex += 1;
            if (2 < selectedIndex) {
                selectedIndex = 1;
            }
        }
    }

    // Decrement the currently selected option index
    function decIndex() {
        if (null != selectedIndex) {
            selectedIndex -= 1;
            if (1 > selectedIndex) {
                selectedIndex = 2;
            }
        }
    }
    
    // Process the current attention action
    function action() {
    	if (selectedIndex == 1){
    	}
    	if (selectedIndex == 2){
    	}
    	return true;
    }

}