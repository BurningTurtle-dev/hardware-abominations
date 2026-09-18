include <top_segment.scad>
include <symbol_segment.scad>

segment_width = 20;
// M3 screw-hole settings
//screw_hole_diameter = 3.2;
screw_hole_diameter = 3;
screw_head_diameter = 6.2;
screw_head_height = 2.5;


segment_order_1 = [
    "A",
    "B",
    "X",
    "Y",
    "",
    "l2",
    "l1",
    "r1",
    "r2",
    "",
    "r_horizontal",
    "r_vertical",
];
    
segment_order_2 = [
    "d_up",
    "d_down",
    "d_left",
    "d_right",
    "",
    "",
    "l3",
    "r3",
    "",
    "",
    "start",
    "select",
];

module screw_hole() {
    union() {
        cylinder(h=screw_head_height, d=screw_head_diameter, center=true, $fn=100);
        cylinder(h=10, d=screw_hole_diameter, center=true, $fn=100);
        
    }
}

module top_plate() {
    plate_width  = len(segment_order_1) * segment_width;
    plate_height = 4 * segment_width;
    extra_wall_thickness = 4;

    difference() {
        translate([segment_width/2, segment_width/2, 0])
        union() {
            //extra walls
            translate([-segment_width/2 - extra_wall_thickness, -segment_width/2 ,-3])
            cube(size = [extra_wall_thickness, segment_width * 4, 4], center = false);
            
            translate([plate_width -segment_width/2, -segment_width/2 ,-extra_wall_thickness +1])
            cube(size = [extra_wall_thickness, segment_width * 4, 4], center = false);
            
             translate([-segment_width/2 - extra_wall_thickness, -segment_width/2-extra_wall_thickness, -extra_wall_thickness +1])
            cube(size = [segment_width * len(segment_order_1) + 2*extra_wall_thickness, extra_wall_thickness, 4], center = false);
            
            translate([-segment_width/2 - extra_wall_thickness, plate_height-segment_width/2, -extra_wall_thickness +1])
            cube(size = [segment_width * len(segment_order_1) + 2*extra_wall_thickness, extra_wall_thickness, 4], center = false);
            
            for (i = [0: 1: len(segment_order_1)-1]) {
                if (segment_order_1[i] == "") {
                    translate([i * segment_width, 0, -1])
                    cube(size = [segment_width, segment_width, 4], center = true);
                }
                translate([i * segment_width, 0, 0])
                top_segment();
                
                translate([i * segment_width, segment_width,-1])
                symbol_segment(segment_order_1[i]);
            }
            
            for (i = [0: 1: len(segment_order_2)-1]) {
                if (segment_order_2[i] == "") {
                    translate([i * segment_width, 2 * segment_width, -1])
                    cube(size = [segment_width, segment_width, 4], center = true);
                }
                translate([i * segment_width, 2 * segment_width, 0])
                top_segment();
                
                translate([i * segment_width, 3 * segment_width,-1])
                symbol_segment(segment_order_2[i]);
            }
        }

        // 4 inset corner screw holes for M3 screws
        for (x = [1, plate_width-1])
            for (y = [3, plate_height-3])
                translate([x, y, 0])
                screw_hole();
    }
}

//top_plate();