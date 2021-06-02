include <Parameters.scad>;
use <parts/HeatExhaustVent.scad>;

heatExhaustVentBoundingBox = heatExhaustVentBoundingBox();

module heatExhaustVentMove() {
    translate([55, heatExhaustVentBoundingBox[1] + 291, heatExhaustVentBoundingBox[2]])
        children();
}

module backplate() {
    difference() {
        cube([
            backplateWidth, backplateHeight, backplateThickness
        ]);
        translate([0, 0, -0.01]) 
        heatExhaustVentMove() 
        rotate([180, 0, 0]) 
        cube(heatExhaustVentBoundingBox);
    }
    heatExhaustVentMove() rotate([180, 0, 0]) heatExhaustVent();
}

translate([0, 0, -10])
    backplate();