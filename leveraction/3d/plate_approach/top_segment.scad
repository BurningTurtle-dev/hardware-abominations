
width = 20;

module top_segment() {
    difference() {
        cube(size = [width, width, 2], center = true);
        
        cylinder(h = 10, r = 3, center = true, $fn=100);
    }
}

//top_segment();