include <modular_connector_bit_A.scad>

module connector_A() {
    translate([0.5, 0, 3])
        connector_bit_A();
    
    translate([0.5, 0, -3])
        connector_bit_A();
}

//connector_A();