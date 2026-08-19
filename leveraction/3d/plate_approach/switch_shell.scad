switch_width_x = 13.5;
switch_width_y = 8.5;
wall_thickness = 1;

difference() {
    cube(size = [switch_width_x + wall_thickness, switch_width_y + wall_thickness, 1], center = true);
    cube(size = [switch_width_x, switch_width_y, 1], center = true);
}