// All values are in mm.

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

// Google suggests that the standard shopping cart wheel is 4" in
// diameter and 1.25" in width. That translates to 101.6mm in diameter
// (50.8mm in radius) and 31.75mm in width.

wheel_diameter = 101.6;
wheel_radius = wheel_diameter/2;
wheel_thickness = 31.75;

// As such, the side "guard" height of the chock being the radius
// makes sense because it will give us maximum coverage to prevent the
// wheel from turning if chocking a front wheel
side_height = wheel_radius;

// But, having the center section be lower than that will keep the
// "angle of attack" shallow makes sense.
center_height = wheel_radius * (2/3) ;

// Similarly the side "guard" length should be most of the diameter of
// the wheel.. we'll say half, which is conveniently the diameter. We
// want maximum surface area with minimum wasted material.
side_length = wheel_radius;

// And we'll say that we want the center triangle length to be half
// that of the sides:
// Length of the center triangle
center_length = side_length * (2/3);

// Width of the center triangle (wheel width plus 6mm padding (3mm
// each side))
center_width = wheel_thickness + 6;

// Width of the side triangles, which is just a semi-random number for
// strength/thickness.
side_width = 20;

// No overlap
delta = 0.1;

SidePoints = [
  [           0,          0,           0 ],  // 0
  [ side_length,          0,           0 ],  // 1
  [ side_length, side_width,           0 ],  // 2
  [           0, side_width,           0 ],  // 3
  [           0,          0, side_height ],  // 4
  [           0, side_width, side_height ]]; // 5

CenterPoints = [
  [             0,            0,             0 ],  // 0
  [ center_length,            0,             0 ],  // 1
  [ center_length, center_width,             0 ],  // 2
  [             0, center_width,             0 ],  // 3
  [             0,            0, center_height ],  // 4
  [             0, center_width, center_height ]]; // 5
  
Faces = [
  [0,1,2,3],  // bottom
  [4,1,0]  ,  // front
  [2,1,4,5],  // top
  [5,3,2],    // back
  [5,4,0,3]]; // left

difference() {
    union() {
        // Draw both sides
        polyhedron(SidePoints, Faces);
        
        translate([0, center_width + side_width, 0]){
            polyhedron(SidePoints, Faces);
        }
        
        // Draw center
        translate([0, side_width, 0]){
            polyhedron(CenterPoints, Faces);
        }
    }
    
    // Wheel cylinder relief
    translate([wheel_radius - 3, side_width + (center_width / 2), wheel_radius]) {
        rotate(a=[90,0,0]) {
            cylinder(h = center_width - (delta * 2), r = wheel_radius, center = true);
        }
    }
}

// Wheel cylinder
translate([wheel_radius - 3, side_width + (center_width / 2), wheel_radius]) {
    rotate(a=[90,0,0]) {
        color("blue") {
            cylinder(h = wheel_thickness, r = wheel_radius, center = true);
        }
    }
}
