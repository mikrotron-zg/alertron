// Unicorn pHAT diffuser

include <rpi_zero_w.scad>

// tolerance, should be adjusted for different printers
tol = 0.25;

// Unicorn pHAT dimensions
uph_height = 1.6;


// diffuser dimensions
d_wall_edge = 2; // how thick is the edge
d_wall_slot = 1; // how deep is the edge slot
d_wall_top = 2; // diffuser thickness
d_length = pi_length + 2*d_wall_edge - 2*d_wall_slot + 2*tol;
d_width = pi_width + d_wall_edge;
d_led_height = 2; // LED height over PCB
d_offset = 1; // how far is diffuser from LEDs
d_edge_height = uph_height + d_led_height + d_offset + tol + 2;
d_height = d_wall_top + d_edge_height;
d_corner_radius = pi_corner_radius + d_wall_edge - 2*d_wall_slot;

// Entry point
rotate([90, 0, 0]) unicorn_phat_diffuser();

module unicorn_phat_diffuser(){
    difference(){
        rounded_rect(d_length, d_width, d_height, d_corner_radius);
        translate([d_wall_edge, d_wall_edge, d_wall_top])
            rounded_rect(pi_length - 2*d_wall_slot + 2*tol, pi_width + 10, 
                         d_edge_height + ex, pi_corner_radius - d_wall_slot);
        translate([d_wall_edge - d_wall_slot, d_wall_edge - d_wall_slot, 
                                        d_wall_top + d_led_height + d_offset])
            rounded_rect(pi_length + 2*tol, pi_width + 10, uph_height + tol, pi_corner_radius);
    }
}