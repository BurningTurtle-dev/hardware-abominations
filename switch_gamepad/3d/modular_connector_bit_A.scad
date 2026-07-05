module connector_bit_A() {
    union() {
        cube(size = [1, 1, 1], center = true);
        translate([1, 0, 0])
            cube(size = [1, 1, 3], center = true);
    }
}

//connector_bit_A();