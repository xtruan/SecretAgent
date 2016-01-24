using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;

class SecretAgentView extends Ui.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = Sys.getClockTime();
        var hours = clockTime.hour;
        if (App.getApp().getProperty("UseMilitaryFormat")) {
	        if (!Sys.getDeviceSettings().is24Hour) {
	            if (hours > 12) {
	                hours = hours - 12;
	            }
	        } else {
	            timeFormat = "$1$$2$";
	        }
        }
        var timeString = Lang.format(timeFormat, [hours.format("%02d"), clockTime.min.format("%02d")]);

        // Update the view
		dc.clear();
		
        var view = View.findDrawableById("TimeLabel");
        view.setColor(App.getApp().getProperty("ForegroundColor"));
        view.setText(timeString);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        var h = dc.getHeight();
        var w = dc.getWidth();
        var fourthW = w/4;
        var eightH = h/11;
        var blockH = 9;
        var halfBlockH = blockH/2;
        var blockW = 15;
        
        var actInfo = Act.getInfo();
        var stepPercent = (actInfo.steps*100.0)/actInfo.stepGoal;
        if (stepPercent >= 100){ dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW, eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 90) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/1.5, 2*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 80) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/3, 3*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 70) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/6, 4*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 60) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(2, 5*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 50) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(2, 6*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 40) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/6, 7*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 30) { dc.setColor( Gfx.COLOR_YELLOW,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/3, 8*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 20) { dc.setColor( Gfx.COLOR_YELLOW,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/1.5, 9*eightH-halfBlockH, blockW, blockH);
        if (stepPercent >= 10) { dc.setColor( Gfx.COLOR_YELLOW,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW, 10*eightH-halfBlockH, blockW, blockH);
        
        var battPercent = Sys.getSystemStats().battery;
        if (battPercent >= 98) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW, eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 90) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/1.5, 2*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 80) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/3, 3*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 70) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/6, 4*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 60) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-2, 5*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 50) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-2, 6*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 40) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/6, 7*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 30) { dc.setColor( Gfx.COLOR_BLUE,    Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/3, 8*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 20) { dc.setColor( Gfx.COLOR_BLUE,    Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/1.5, 9*eightH-halfBlockH, blockW, blockH);
        if (battPercent >= 10) { dc.setColor( Gfx.COLOR_BLUE,    Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW, 10*eightH-halfBlockH, blockW, blockH);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
