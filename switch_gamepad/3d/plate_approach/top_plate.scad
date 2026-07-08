include <top_segment.scad>
include <symbol_segment.scad>

segment_width = 20;

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

module top_plate() {
    translate([segment_width/2, segment_width/2, 0])
    union() {
        for (i = [0: 1: len(segment_order_1)-1]) {
            if (segment_order_1[i] == "") {
                translate([i * segment_width, 0, 0])
                cube(size = [segment_width, segment_width, 2], center = true);
            }
            translate([i * segment_width, 0, 0])
            top_segment();
            
            translate([i * segment_width, segment_width,0])
        symbol_segment(segment_order_1[i]);
        }
        
        
        for (i = [0: 1: len(segment_order_2)-1]) {
            if (segment_order_2[i] == "") {
                translate([i * segment_width, 2 * segment_width, 0])
                cube(size = [segment_width, segment_width, 2], center = true);
            }
            translate([i * segment_width, 2 * segment_width, 0])
            top_segment();
            
            translate([i * segment_width, 3 * segment_width,0])
        symbol_segment(segment_order_2[i]);
        }
    }
    
}

top_plate();