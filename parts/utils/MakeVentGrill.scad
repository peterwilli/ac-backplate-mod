module makeVentGrill(width, height) {
    cutoutSize = [20, 7.50];
    spacing = 5;
    for(y = [0:height - 1]) {
        for(x = [0:width - 1]) {
            translate([
                x * (cutoutSize[0] + spacing),
                y * (cutoutSize[1] + spacing),
                0
            ])
            cube([cutoutSize[0], cutoutSize[1], 1]);
        }
    }
}

makeVentGrill(5, 5);