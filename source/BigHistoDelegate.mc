using Toybox.WatchUi;
using Toybox.System;

class BigHistoDelegate extends WatchUi.MenuInputDelegate {
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :item_1) {
            System.println("Item 1");
        } 
        else if (item == :item_2) {
            System.println("Item 2");
        }
        else if (item == :item_3) {
            System.println("Item 3");
        }
        else if (item == :item_4) {
            System.println("Item 2");
        }
        else if (item == :item_5) {
            System.println("Item 2");
        }
        else if (item == :item_6) {
            System.println("Item 2");
        }
        else if (item == :item_7) {
            System.println("Item 2");
        }
    }
}