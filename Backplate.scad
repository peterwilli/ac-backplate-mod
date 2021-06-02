include <Parameters.scad>;
use <parts/HeatExhaustVent.scad>;
use <parts/AirInletVent.scad>;

heatExhaustVentBoundingBox = heatExhaustVentBoundingBox();
airInletVentBoundingBox = airInletVentBoundingBox();

module heatExhaustVentMove() {
    translate([55, heatExhaustVentBoundingBox[1] + 291, heatExhaustVentBoundingBox[2]])
        children();
}

module airInletVentMove() {
    translate([(backplateWidth / 2) - (airInletVentBoundingBox[0] / 2), airInletVentBoundingBox[1] + 100, airInletVentBoundingBox[2]])
        children();
}

module backplate() {
    difference() {
        cube([
            backplateWidth, backplateHeight, backplateThickness
        ]);
        translate([0, 0, (backplateThickness + 0.01) * -1]) 
        union() {
            heatExhaustVentMove() 
            rotate([180, 0, 0]) 
                cube(heatExhaustVentBoundingBox);

            airInletVentMove() 
            rotate([180, 0, 0]) 
                cube(airInletVentBoundingBox);
        }
    }
    airInletVentMove() rotate([180, 0, 0]) airInletVent();
    heatExhaustVentMove() rotate([180, 0, 0]) heatExhaustVent();
}

translate([0, 0, -10])
    backplate();