include <bottom_segment.scad>

segment_width = 20;

module bottom_plate() {
    translate([segment_width/2, segment_width/2, 0])
    union() {
        for (i = [0: 1: 16]) {
            translate([i * segment_width, 0, 0])
            bottom_segment();
        }
    }
    
}

bottom_plate();