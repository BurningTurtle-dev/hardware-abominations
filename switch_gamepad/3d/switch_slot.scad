
module switch_slot() {
    render()
    union() {
        difference() {
            cube(size = [20, 20, 10], center = true);
            translate([0, 0, -2])
                render()
                union() {
                    cube(size = [13.1, 8.2, 10], center = true);
                    translate([0, 0, 10])
                    cylinder(h = 10, r = 2.8, center = true, $fn=100);
                }
        }
    }
}

switch_slot();