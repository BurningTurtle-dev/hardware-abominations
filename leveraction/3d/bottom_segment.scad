
width = 20;
pin_distance = 4.7;
pin_length = 2; //TODO
pin_width = 0.8;

module bottom_segment() {
    difference() {
        cube(size = [width, width, 2], center = true);
        
        union() {
            cube(size = [pin_length, pin_width, 3], center = true);
            
            translate([0, pin_distance,0])
            cube(size = [pin_length, pin_width, 3], center = true);
            
            translate([0, -pin_distance,0])
            cube(size = [pin_length, pin_width, 3], center = true);
        }
    }
}

//bottom_segment();