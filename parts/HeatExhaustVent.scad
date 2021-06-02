use <utils/MakeVentGrill.scad>;

thickness = 11.55;
ventWidth = 200;
ventHeight = 133;
borderThickness = 2.53;

function heatExhaustVentBoundingBox() =
    [ventWidth, ventHeight, thickness];

module heatExhaustVent() {

    difference () {
        difference() {
            cube(heatExhaustVentBoundingBox());
            translate([15, 6, -0.05]) scale([1, 1, thickness + 0.1]) makeVentGrill(7, 10);
        }
        pushIn();
    }
    cups();
    
    module pushIn() {
        thickness = 5.75;
        translate([borderThickness, -0.01, -0.01])
            cube([ventWidth - (borderThickness * 2), ventHeight - borderThickness, thickness]);
    }

    module cups() {
        thickness = 3;
        module left() {
            firstHeight = 49.90;
            secondHeight = 24.96;
            width = 12.25;
            translate([0, ventHeight - firstHeight - borderThickness]) 
            cube([width, firstHeight, thickness]);

            translate([0, 36, 0]) 
            cube([width, secondHeight, thickness]);
        }

        module right() {
            firstHeight = 49.90;
            secondHeight = 24.96;
            width = 7.35;
            translate([ventWidth - width, ventHeight - firstHeight - borderThickness]) 
            cube([width, firstHeight, thickness]);

            translate([ventWidth - width, 36, 0]) 
            cube([width, secondHeight, thickness]);
        }

        left();
        right();
    }
}

heatExhaustVent();