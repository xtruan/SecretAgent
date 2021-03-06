using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Cal;

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
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else if (App.getApp().getProperty("UseMilitaryFormat")) {
            timeFormat = "$1$$2$";
        }
        var timeString = Lang.format(timeFormat, [hours.format("%02d"), clockTime.min.format("%02d")]);

        // Update the view
        dc.clear();
        
        var view = View.findDrawableById("TimeLabel");
        view.setColor(App.getApp().getProperty("ForegroundColor"));
        view.setText(timeString);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        // Draw the life (steps), armor (battery) bars, and other details
        drawFace(dc);
    }
    
    function drawFace(dc) {
        // Setup of sizes
        var h = dc.getHeight();
        var w = dc.getWidth();
        var fourthW = w/4;
        var eleventhH = h/11;
        var blockH = 9;
        var smBlockH = blockH - 3;
        var halfBlockH = blockH/2;
        var halfSmBlockH = smBlockH/2;
        var blockW = 15;
        
        // Show status info
        dc.setColor( App.getApp().getProperty("ForegroundColor"), Gfx.COLOR_TRANSPARENT );
        if (App.getApp().getProperty("ShowStatusInfo")) {
            var infoStr = "";
            var alarmNum = Sys.getDeviceSettings().alarmCount;
            if (alarmNum > 0) {
                infoStr = infoStr + "A";
            } else {
                infoStr = infoStr + "--";
            }
            infoStr = infoStr + "  ";
            var notifyNum = Sys.getDeviceSettings().notificationCount;
            if (notifyNum > 0) {
                infoStr = infoStr + "M";
            } else {
                infoStr = infoStr + "--";
            }
            infoStr = infoStr + "  ";
            if (Sys.getDeviceSettings().phoneConnected) {
                infoStr = infoStr + "C";
            } else {
                infoStr = infoStr + "--";
            }
            
            var statusY;
            if (App.getApp().getProperty("ClassicFace")) {
                statusY = 9*eleventhH-blockH;
            } else {
                statusY = 7.75*eleventhH-blockH;
            }
            dc.drawText(w/2, statusY, Gfx.FONT_TINY, infoStr, Gfx.TEXT_JUSTIFY_CENTER);
        }
        
        // Show date info
        var now = Time.now();
        var date = Cal.info(now, Time.FORMAT_MEDIUM);
        if (App.getApp().getProperty("ClassicFace")) {
            var longDate = Cal.info(now, Time.FORMAT_LONG);
            var dateStr = "" + date.month + " " + date.day + ", " + date.year;
            dc.drawText(w/2, 3*eleventhH-blockH+2, Gfx.FONT_TINY, dateStr, Gfx.TEXT_JUSTIFY_CENTER);
            dc.drawText(w/2, 2*eleventhH-blockH+1, Gfx.FONT_TINY, longDate.day_of_week, Gfx.TEXT_JUSTIFY_CENTER);
        } else {
            var dateStr = date.day_of_week + ", " + date.month + " " + date.day;
            dc.drawText(w/2, 3*eleventhH-blockH+4, Gfx.FONT_TINY, dateStr, Gfx.TEXT_JUSTIFY_CENTER);
        }
        
        // Get steps info
        var actInfo = Act.getInfo();
        var stepPercent = (actInfo.steps*100.0)/actInfo.stepGoal;
        
        // Draw steps bar
        if (stepPercent >= 100){ dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW, eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 90) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/1.5, 2*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 80) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/3, 3*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 70) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/6, 4*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 60) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(2, 5*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 50) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(2, 6*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 40) { dc.setColor( Gfx.COLOR_ORANGE,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/6, 7*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 30) { dc.setColor( Gfx.COLOR_YELLOW,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/3, 8*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 20) { dc.setColor( Gfx.COLOR_YELLOW,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW/1.5, 9*eleventhH-halfBlockH, blockW, blockH);
        if (stepPercent >= 10) { dc.setColor( Gfx.COLOR_YELLOW,  Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(fourthW, 10*eleventhH-halfBlockH, blockW, blockH);
        
        // Get battery info
        var battPercent = Sys.getSystemStats().battery;
        
        // Draw battery bar
        if (battPercent >= 98) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW, eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 90) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/1.5, 2*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 80) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/3, 3*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 70) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/6, 4*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 60) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-2, 5*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 50) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-2, 6*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 40) { dc.setColor( Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/6, 7*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 30) { dc.setColor( Gfx.COLOR_BLUE,    Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/3, 8*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 20) { dc.setColor( Gfx.COLOR_BLUE,    Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW/1.5, 9*eleventhH-halfBlockH, blockW, blockH);
        if (battPercent >= 10) { dc.setColor( Gfx.COLOR_BLUE,    Gfx.COLOR_TRANSPARENT ); }
        else                   { dc.setColor( Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT ); }
        dc.fillRectangle(w-blockW-fourthW, 10*eleventhH-halfBlockH, blockW, blockH);
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
