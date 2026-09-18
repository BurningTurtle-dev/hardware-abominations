hole_offset = 3;

module screw_mount(){
    linear_extrude(height=10)
    difference() {
        polygon(points = [[0,0],[10,0],[0,10]]);
        translate([hole_offset,hole_offset,0])
        circle(d=3, $fn=100);
    }
}
screw_mount();