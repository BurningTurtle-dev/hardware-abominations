include <modular_connector_A.scad>

module connector_B() {
    
    render()
    difference() {
        cube(size = [2, 1, 13], center = true);
        
        translate([-1, 0, 0])
            scale([1.1, 1.1, 1])
                render()
                    connector_A();
    }
}

//connector_B();