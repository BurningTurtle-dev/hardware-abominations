
width = 20;
switch_width_x = 13.5;
switch_width_y = 8.5;
wall_thickness = 1;
wall_height = 2;

module top_segment() {
    rotate([0,0,90]) 
    union() {
        difference() {
            cube(size = [width, width, 2], center = true);
        
            cylinder(h = 10, r = 3, center = true, $fn=100);
        }
        translate([0,0,-2])
        difference() {
            cube(size = [width, width, wall_height], center = true);
            cube(size = [switch_width_x, switch_width_y, wall_height], center = true);
            }
    }
}

//top_segment();