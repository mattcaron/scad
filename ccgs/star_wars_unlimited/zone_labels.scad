include <../../Chamfers-for-OpenSCAD/Chamfer.scad>;
$fn=360;

module ground() {
    // main background
    color([0,0,0]) chamferCube([75,20,2],
    ch = 5,
    chamfers=[[0, 0, 0, 0],
              [0, 0, 0, 0],
              [1, 1, 1, 1]]);


    // rim
    difference() {
        translate([1, 1, 0]) {
            color([1,1,1]) chamferCube([73,18,2.5],
            ch = 5,
            chamfers=[[0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [1, 1, 1, 1]]);
        }
    
        translate([1.5, 1.5, -1]) {
            color([1,1,1]) chamferCube([72,17,4],
            ch = 5,
            chamfers=[[0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [1, 1, 1, 1]]);
        }

    }

    // text
    translate([7, 5, 2]) {
        color([1,1,1]) linear_extrude(1) text("Ground", font="Star Jedi");
    }
}

module space() {
    
    // main background
    color([0,0,0]) chamferCube([75,20,2],
    ch = 5,
    chamfers=[[0, 0, 0, 0],
              [0, 0, 0, 0],
              [1, 1, 1, 1]]);


    // rim
    difference() {
        translate([1, 1, 0]) {
            color([1,1,1]) chamferCube([73,18,2.5],
            ch = 5,
            chamfers=[[0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [1, 1, 1, 1]]);
        }
    
        translate([1.5, 1.5, -1]) {
            color([1,1,1]) chamferCube([72,17,4],
            ch = 5,
            chamfers=[[0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [1, 1, 1, 1]]);
        }

    }

    // text
    translate([15, 5, 2]) {
        color([1,1,1]) linear_extrude(1) text("Space", font="Star Jedi");
    }
}

translate([0,30,0]) {
    ground();
}
space();
