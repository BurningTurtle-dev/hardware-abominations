include <screw_mount.scad>
include <../top/top_plate.scad>

len_x = 88;
len_y = 248;
height = 30;
thickness = 2;

hole_radius = 4;
slot_width = 10;
slot_height = 5;

nunchuck_height = 2;
nunchuck_width = 10;

//TODO screw hole

module walls () {
    difference() {
        translate([0,0,2])
        cube(size=[len_x+thickness,len_y+thickness,height+4], center=true);
        cube(size=[len_x-2*thickness,len_y-2*thickness,height], center=true);
        
        translate([len_x/2, 0,0])
        union(){
            translate([0,0,slot_height/2])
            cube(size=[2*thickness, slot_width, slot_height], center=true);
            rotate([0,90,0])
            cylinder(  h=2*thickness, d=hole_radius,$fn=100 , center=true);
        }
        //nunchuck slot
        translate([0,len_y/2,0])
        cube(size=[nunchuck_width,nunchuck_width,nunchuck_height], center=true);
        
        //top_plate cuttout
        translate([0,0,4+height/2])
        cube(size=[len_x+0.5,len_y+0.5,8], center=true);
    }
        
    
    //Screws
    screw_offset_x = (len_x/2-4);
    screw_offset_y = (len_y/2-2);
    translate([-screw_offset_x, -screw_offset_y,0])
    rotate([0,0,90])
    mirror([0,1,0])
    screw_mount();
    
    translate([screw_offset_x, -screw_offset_y,0])
    rotate([0,0,90])
    screw_mount();
    
    translate([screw_offset_x, screw_offset_y,0])
    rotate([0,0,90])
    mirror([1,0,0])
    screw_mount();
    
    translate([-screw_offset_x, screw_offset_y,0])
    mirror([0,0,0])
    rotate([0,0,270])
    screw_mount();
    
}
rotate([0,0,90])

walls();
//translate([-len_y/2+4,-len_x/2+4,height/2+3])
//top_plate();