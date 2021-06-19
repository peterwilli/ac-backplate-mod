include <../Parameters.scad>;
use <__comm__/__to3d.scad>;
use <ptf/ptf_rotate.scad>;
use <sweep.scad>;
use <shape_circle.scad>;
use <util/lerp.scad>;
use <util/reverse.scad>;

module airHoseHolder(width, height, circleRadius) {
    function expCurve(x) = pow(x, 2) * exp(pow(-x, 2));
    module holderToHoseTransition(scale = 1, circleRadius = 1) {
        heightSteps = 20;
        circle = [for(s = reverse(shape_circle(radius = circleRadius))) __to3d(s)];
        sections = [
            for(i = [0:heightSteps]) 
                [
                    let(
                        expI = (1 - (expCurve(1 - i / heightSteps)) / 2.71828)
                    )
                    for(p = circle)
                        let(pt = ptf_rotate(p, [0, 0, 0]))
                        let(circleScale = [
                            lerp([width / (circleRadius * 2)], [1], expI)[0], 
                            lerp([height / (circleRadius * 2)], [1], expI)[0],
                        ])
                        [pt[0] * circleScale[0], pt[1] * circleScale[1] , pt[2] + i]
                ]
        ];
        translate([width / 2, height / 2, cupsThickness - 0.21]) scale([scale, scale, 1])  sweep(sections);
    }
    difference() {
        borderThickness = 2;
        union() {
            holderToHoseTransition(1, circleRadius + borderThickness);
            cube([width, height, cupsThickness - 0.2]);
        }
        translate([0, 0, -4]) scale([1, 1, 1.3]) holderToHoseTransition(1, circleRadius);
    }
}

airHoseHolder(150, 100, 30);