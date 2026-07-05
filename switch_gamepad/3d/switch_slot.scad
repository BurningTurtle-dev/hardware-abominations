include <modular_connector_A.scad>
include <modular_connector_B.scad>

render()
union() {
    difference() {
        cube(size = [13 + 6, 8.2 + 3, 13], center = true);
        translate([0, 0, -3])
            render()
            union() {
                cube(size = [13, 8.2, 10], center = true);
                translate([0, 0, 10])
                    cylinder(h = 10, r = 2.8, center = true);
            }
    }
    

    translate([-(13 + 6)/ 2 - 1, 0, 0])
    scale([1, 8.2 + 3, 1])
    connector_B();

    translate([(13 + 6) / 2, 0, 0])
    scale([1, 8.2 + 3, 1])
    connector_A();
    
    translate([0, (8.2 + 3)/2 + 1,0])
    rotate([0,0,-90])
    scale([1,13 + 6, 1])
    connector_B();
    
    translate([0, -(8.2 + 3)/2 - 1,0])
    rotate([0,0,90])
    scale([1,13 + 6, 1])
    connector_B();
}