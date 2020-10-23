// All values are in mm.

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

$model = "orig/Rear_Cover_-_Extended_USB_Bridge.stl";

union() {
    import($model);

    translate([-73,21,0]){
        cube([50,20,2.5]);
    }

    translate([-52,-10,0]){
        cube([20,15,2.5]);
    }
}



