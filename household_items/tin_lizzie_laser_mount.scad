// Dimensions are in mm.

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

// Thickness for all walls.
wall_thickness = 5;

// Bar width and height (it's extruded square tube, so this dimension
// is the same). This is ID.
bar_width = 19.5;

// Diameter of the laser hole
laser_diameter = 15;

// Thickness of the laser mounts
mount_thickness = 10;

// Length of the clip
clip_length = laser_diameter + (wall_thickness * 2);

// Delta to make sure that we have a clean subtraction.
delta = 1;

module makeEye()
{
    translate([bar_width - wall_thickness / 2, 0,
               bar_width - wall_thickness / 2]) {
        rotate([0, -45, 0]) {
                cube(size = [mount_thickness * 2 , 
                     clip_length,
                     mount_thickness],
                     center=true);
        }
    }
}

module makeEyeHole()
{
    translate([bar_width - wall_thickness / 2, 0,
               bar_width - wall_thickness / 2]) {
        rotate([0, -45, 0]) {
            translate([0, 0, -(mount_thickness + delta) / 2]) {
                cylinder(h=mount_thickness + delta,
                         d=laser_diameter);
            }
        }
    }
}

module sliceBevel()
{
    translate([-(bar_width - wall_thickness * 2) / 2, 0,
               -(bar_width + wall_thickness * 2) / 2]) {
        rotate([0, 45, 0]) {
            difference() {
                cube(size = [wall_thickness * 1.5,
                             clip_length + delta,
                             wall_thickness * 1.5],
                     center=true);
            }
        }
    }
}

difference() {

    union() {
        // make the box
        difference() {
            cube(size = [bar_width + wall_thickness * 2, clip_length,
                         bar_width + wall_thickness * 2], center=true);
            
            // Hole for the bar
            translate([0, -delta / 2 , 0]) {
                // this shouldn't need to be delta * 2, but I'm tired of
                // messing with it.
                cube(size = [bar_width,
                             clip_length + delta * 2,
                             bar_width], center=true);
            }

            // Hole for the clip
            translate([0, -delta / 2, -bar_width / 2 ]) {
                // this shouldn't need to be delta * 2, but I'm tired of
                // messing with it.
                cube(size = [bar_width - wall_thickness * 1.5,
                             clip_length + delta * 2,
                             bar_width - wall_thickness * 1.5], center=true);
            }

            // Bevel the edges
            sliceBevel();
            mirror(){
                sliceBevel();
            }
        }

        // add the two eyes
        makeEye();
        mirror() {
            makeEye();
        }
    }
    // drill out the holes
    makeEyeHole();
    mirror() {
        makeEyeHole();
    }
}

            



