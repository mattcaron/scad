// Dimensions are in mm.

wall_thickness = 3;

// Avoid surface overlap
delta = .1;

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

// Lower cylinder O.D.
lower_cylinder_diameter = 40;

// Lower cylinder height
lower_cylinder_height = 20;

// Upper cylinder bottom O.D.
upper_cylinder_bottom_diameter = 50;

// Upper cylinder top O.D.
upper_cylinder_top_diameter = 100;

// Upper cylinder height
upper_cylinder_height = 40;

difference() {
    union() {
        cylinder(h = lower_cylinder_height,
                 d = lower_cylinder_diameter);
        translate([0, 0, lower_cylinder_height]) {
            cylinder(h = upper_cylinder_height,
                     d1 = upper_cylinder_bottom_diameter,
                     d2 = upper_cylinder_top_diameter);
        }
    }
    union() {
        // This takes out a tall cylinder making a center hole
        translate([0, 0, -delta]) {
            cylinder(h = lower_cylinder_height + upper_cylinder_height + delta,
                     d = lower_cylinder_diameter - (wall_thickness * 2));
            }
        // And this gives us our angled edges
        translate([0, 0, lower_cylinder_height + wall_thickness]) {
            cylinder(h = upper_cylinder_height + delta,
                     d1 = upper_cylinder_bottom_diameter - (wall_thickness * 2),
                     d2 = upper_cylinder_top_diameter - (wall_thickness * 2));
        }
    }
}
