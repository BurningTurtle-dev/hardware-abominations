hole_offset = 3;
height = 10;

module screw_mount(){
    linear_extrude(height=height, center=true)
    difference() {
        translate([0,-4,0])
        polygon(points = [[0,0],[14,0],[0,14]]);
        translate([hole_offset,hole_offset,0])
        circle(d=3, $fn=100);
    }
}
//screw_mount();