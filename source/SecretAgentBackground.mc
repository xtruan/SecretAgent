using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class Background extends Ui.Drawable {

    function initialize() {
        var dictionary = {
            :identifier => "Background"
        };

        Drawable.initialize(dictionary);
    }

    function draw(dc) {
        // Set the background color then call to clear the screen
        dc.setColor(Gfx.COLOR_TRANSPARENT, App.getApp().getProperty("BackgroundColor"));
        dc.clear();
        
        if (App.getApp().getProperty("ClassicFace")) {
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
            
            // Add decor
            dc.setColor( Gfx.COLOR_WHITE,  Gfx.COLOR_TRANSPARENT );
            
            dc.fillCircle(fourthW*1.5-blockH, 2*eleventhH, halfBlockH);
            dc.fillCircle(fourthW-blockH, 3.5*eleventhH, halfBlockH);
            dc.fillCircle(fourthW-blockH, 7.5*eleventhH, halfBlockH);
            dc.fillCircle(fourthW*1.5-blockH, 9*eleventhH, halfBlockH);
            
            dc.fillCircle(w-fourthW*1.5+blockH, 2*eleventhH, halfBlockH);
            dc.fillCircle(w-fourthW+blockH, 3.5*eleventhH, halfBlockH);
            dc.fillCircle(w-fourthW+blockH, 7.5*eleventhH, halfBlockH);
            dc.fillCircle(w-fourthW*1.5+blockH, 9*eleventhH, halfBlockH);
            
            dc.fillRectangle(fourthW/2, 5.5*eleventhH-halfSmBlockH, blockW, smBlockH);
            dc.fillRectangle(w-blockW-fourthW/2, 5.5*eleventhH-halfSmBlockH, blockW, smBlockH);
            dc.fillRectangle(w/2-3*smBlockH/2, eleventhH-blockH, smBlockH, blockW);
            dc.fillRectangle(w/2+smBlockH/2, eleventhH-blockH, smBlockH, blockW);
            dc.fillRectangle(w/2-smBlockH/2, 10*eleventhH, smBlockH, blockW);
        } else {
            var image = Ui.loadResource(Rez.Drawables.Background);
            dc.drawBitmap(0, 0, image);
        }
    }

}
