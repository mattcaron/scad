cup_diameter = 3;
wall_thickness = .25;
bottom_thickness = .5;
wood_thickness = 1.5;
holder_height=3;
clip_height=2;
clip_width=1.5;
$fn=100;

cup_radius = cup_diameter/2;
clip_depth = wood_thickness + (wall_thickness * 2);
// Avoid surface overlap
delta = .1;

union() {
    difference() {
        cylinder(h=holder_height, r=cup_radius + wall_thickness);
        translate([0, 0, bottom_thickness]) {
            cylinder(h=holder_height, r=cup_radius);
        }
    }
    difference() {
        translate([cup_radius + clip_depth / 2,
                   0,
                   holder_height - clip_height / 2]) {
            cube([clip_depth, clip_width, clip_height], center = true);
        }
        translate([cup_radius + clip_depth / 2,
                   0,
                   holder_height - clip_height / 2 - wall_thickness]) {
            cube([wood_thickness, clip_width + delta, clip_height],
                 center = true);
        }
    }
}
