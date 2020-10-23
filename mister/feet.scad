// All values are in mm.

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

shank_hole_width = 3.5;
head_hole_width = 7;

base_thickness = 2;
wall_width = 2;
height = 5;

module makefoot() {
    difference() {
        // Solid foot
        cylinder(h = height + base_thickness, d = head_hole_width + (wall_width * 2));
    
        union() {
            // Hole for shank of screw
            translate([0,0,-(height / 2)]) {
                cylinder(h = height * 2, d = shank_hole_width);
            }
            
            // Hole for head of screw
            translate([0,0,base_thickness]) {
                cylinder(h = height * 2, d = head_hole_width);
            }
        }
    }
}

makefoot();

translate([15, 0, 0]) {
    makefoot();
}

translate([15, 15, 0]) {
    makefoot();
}

translate([0, 15, 0]) {
    makefoot();
}
    
