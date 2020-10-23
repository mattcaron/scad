// All values are in mm.

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

$model = "orig/Main-Top-M.stl";

difference() {
    union() {
        import($model);
        
        translate([-38.8235,23,10]){
            cube([2,19,11]);
        }
        
        translate([-38.8235,-45,12]){
            cube([2,10,7]);
        }

        translate([36.8235,-50,8]){
            cube([2,20,12]);
        }

        translate([-20,20,0]){
            cube([40,25,2]);
        }
    }

    translate([-20,20,2]){
        cube([40,25,20]);
    }
}

    



