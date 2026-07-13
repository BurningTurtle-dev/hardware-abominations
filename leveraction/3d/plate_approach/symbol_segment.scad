
width = 20;
letter_height = 1;

// letters
{
module a() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/A.svg", center = true, dpi = 30);
}

module b() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/B.svg", center = true, dpi = 30);
}

module x() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/X.svg", center = true, dpi = 30);
}

module y() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/Y.svg", center = true, dpi = 30);
}

module d_up() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/d_up.svg", center = true, dpi = 45);
}

module d_down() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/d_down.svg", center = true, dpi = 45);
}

module d_left() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/d_left.svg", center = true, dpi = 45);
}

module d_right() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/d_right.svg", center = true, dpi = 45);
}

module l_up() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l_up.svg", center = true, dpi = 45);
}

module l_down() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l_down.svg", center = true, dpi = 45);
}

module l_left() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l_left.svg", center = true, dpi = 45);
}

module l_right() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l_right.svg", center = true, dpi = 45);
}

module r_up() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r_up.svg", center = true, dpi = 45);
}

module r_down() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r_down.svg", center = true, dpi = 45);
}

module r_left() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r_left.svg", center = true, dpi = 45);
}

module r_right() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r_right.svg", center = true, dpi = 45);
}

module select() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/select.svg", center = true, dpi = 25);
}

module start() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/start.svg", center = true, dpi = 25);
}

module l1() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l1.svg", center = true, dpi = 60);
}

module l2() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l2.svg", center = true, dpi = 60);
}

module l3() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l3.svg", center = true, dpi = 60);
}

module r1() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r1.svg", center = true, dpi = 60);
}

module r2() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r2.svg", center = true, dpi = 60);
}

module r3() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r3.svg", center = true, dpi = 60);
}


module l_vertical() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l_vertical.svg", center = true, dpi = 60);
}

module r_vertical() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r_vertical.svg", center = true, dpi = 60);
}

module l_horizontal() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/l_horizontal.svg", center = true, dpi = 60);
}

module r_horizontal() {
    translate([0,0,1])
    linear_extrude(height = letter_height)
    import("svg/r_horizontal.svg", center = true, dpi = 60);
}
}




// symbol dispatcher
module symbol_segment(which=0) {
    
    cube(size = [width, width, 2], center = true);
    
    if (which == "A") {
        a();
    }
    
    if (which == "B") {
        b();
    }
    
    if (which == "X") {
        x();
    }
    
    if (which == "Y") {
        y();
    }
    
    if (which == "d_up") {
        d_up();
    }
    
    if (which == "d_down") {
        d_down();
    }
    
    if (which == "d_left") {
        d_left();
    }
    
    if (which == "d_right") {
        d_right();
    }
    
    if (which == "l_up") {
        l_up();
    }
    
    if (which == "l_down") {
        l_down();
    }
    
    if (which == "l_left") {
        l_left();
    }
    
    if (which == "l_right") {
        l_right();
    }
    
    if (which == "r_up") {
        r_up();
    }
    
    if (which == "r_down") {
        r_down();
    }
    
    if (which == "r_left") {
        r_left();
    }
    
    if (which == "r_right") {
        r_right();
    }
    
    if (which == "start") {
        start();
    }
    
    if (which == "select") {
        select();
    }
    
    if (which == "l1") {
        l1();
    }
    
    if (which == "l2") {
        l2();
    }
    
    if (which == "l3") {
        l3();
    }
    
    if (which == "r1") {
        r1();
    }
    
    if (which == "r2") {
        r2();
    }
    
    if (which == "r3") {
        r3();
    }
    
    if (which == "l_vertical") {
        l_vertical();
    }
    
    if (which == "r_vertical") {
        r_vertical();
    }
    
    if (which == "l_horizontal") {
        l_horizontal();
    }
    
    if (which == "r_horizontal") {
        r_horizontal();
    }
    
}

//symbol_segment("l_horizontal");