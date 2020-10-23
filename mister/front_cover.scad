// All values are in mm.

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

$model = "orig/Front_Cover_-_Extended_USB_Bridge.stl";

difference() {
    union() {
        import($model);

        translate([52,2,0]) {
            cube([16,25,20]);
        }
    }
    
    translate([53,3,-1]) {
        cube([13,22,19]);
    }

    translate([40,15,-1]) {
        cube([12,12,10]);
    }
}




