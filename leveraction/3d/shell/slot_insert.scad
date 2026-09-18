len_x = 200; //TODO set correct
len_y = 300;
height = 30;
thickness = 2;

hole_radius = 5;
slot_width = 10;
slot_height = 5;

module slot(){
    difference(){
        translate([0,0,slot_height/2])
        union(){
            cube(size=[2*thickness-0.5, slot_width-0.5, slot_height-0.5], center=true);
            cube(size=[1, slot_width+4, slot_height+4], center=true);
        }
        rotate([0,90,0])
        cylinder(  h=2*thickness, d=hole_radius,$fn=100 , center=true);
        translate([0,0,-hole_radius/2])
        cube(size=[hole_radius, hole_radius, hole_radius], center=true);
    }
}
slot();