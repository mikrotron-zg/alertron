// A library of common modules, functions and variables

// Extra dimension to remove ambiguity of walls
ex = 0.001;

// Hole dimension correction - if 3D printed holes turn out too small,
// increase the value (e.g. 1.1 = 110%), or reduce the value (e.g. 0.9 = 90%).
// Default value is 1.0 (100%)
hdc = 1.1;

// Some nuts and bolts dimensions
m3_bolt_head_dia = 6*hdc;
m3_bolt_head_height = 2;
m3_dia = 3*hdc;


module rounded_rect(x, y, z, radius = 1) {
    // Draws a rounded rectangle
    translate([radius,radius,0]) //move origin to outer limits
	linear_extrude(height=z)
		minkowski() {
			square([x-2*radius,y-2*radius]); //keep outer dimensions given by x and y
			circle(r = radius, $fn=100);
		}
}


module cylinder_quarter(r, h){
    // Draws quarter of a cylinder
    difference(){
        cylinder(r=r, h=h);
        translate ([-r-ex, -r-ex, -ex]) cube([2*r + 2*ex, r + ex, h + 2*ex]);
        translate ([-r-ex, -ex, -ex]) cube([r + ex, r + ex, h + 2*ex]);
    }
}


module header_pin(rows=1, columns=1){
    // Draws 2.54 mm male header pins
    base_width = 2.54;
    base_height = 2.54;
    header_width = 0.508;
    header_height = 5.08;
    trans = base_width/2 - header_width/2;

    for (i = [0: rows - 1]){
        for (j = [0: columns -1]){
            translate([j*base_width, i*base_width, 0]){
                color("Black") cube([base_width, base_width, base_height]);
                translate([trans , trans, base_height])
                    color("Khaki") cube([header_width, header_width, header_height]);
            }
        }
    }

}

module m3_bolt(length = 10){
    // M3 bolt mockup
    union(){
        cylinder(d = m3_dia, h = length);
        translate([0, 0, length - ex - m3_bolt_head_height]) 
            cylinder(d = m3_bolt_head_dia, h = m3_bolt_head_height + ex);
    }
}

module m3_nut_trap(){
    // Makes M3 nut trap inset
    cylinder(r=5.5/2/cos(180/6)*hdc, h=2, $fn=6);
}

module cross_beams(rect_a, rect_b, beam_width){
    // Cross beams in the ractangle with sides a and b
    diag = sqrt(rect_a*rect_a + rect_b*rect_b);
    rot = atan2(rect_b, rect_a);
    

    translate([rect_a/2, rect_b/2, beam_width/2])
    difference(){
        union(){
            rotate(rot) cube([diag, beam_width, beam_width], true);
            rotate(-rot) cube([diag, beam_width, beam_width], true);
        }
        difference(){
            cube([rect_a + 2*beam_width, rect_b + 2*beam_width, beam_width + 2*ex], true);
            cube([rect_a, rect_b, beam_width + 4*ex], true);
        }
    }
}
