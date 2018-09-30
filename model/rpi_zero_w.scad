// RPi Zero W board 3D model

include <common.scad>;

// Defines smoothness of rounded objects
$fn = 80;

// Board dimensions
pi_length = 65;
pi_width = 30;
pi_height = 1.3;
pi_corner_radius = 3;
pi_connector_peek = 1; // how much connectors stick out
pi_sd_peek = 3.5; // how much inserted SD card sticks out

// Mount holes dimensions
pi_mh_dia = 2.75;
pi_mh_center = 3.5;
pi_mh_xy = [ [pi_mh_center, pi_mh_center, -ex],
             [pi_length - pi_mh_center, pi_mh_center, -ex],
             [pi_length - pi_mh_center, pi_width - pi_mh_center, -ex],
             [pi_mh_center, pi_width - pi_mh_center, -ex]
           ];

// HDMI connector dimensions
pi_hdmi_length = 11.2;
pi_hdmi_width = 7.6;
pi_hdmi_height = 3.5;
pi_hdmi_cx = 12.4; // center x coordinate of conector

// USB connector dimensions
pi_usb_length = 7.5;
pi_usb_width = 5.7;
pi_usb_height = 2.7;
pi_usb1_cx = 41.4; // center x coordinate of USB 1
pi_usb2_cx = 54.0; // center x coordinate of USB 2

// SD card connector dimensions
pi_sd_length = 12;
pi_sd_height = 1.5;
pi_sd_cy = 16.9; // center y coordinate of SD card connector

// Camera connector dimensions
pi_camc_length = 17.0;
pi_camc_width = 4.0;
pi_camc_height = 1.0;
pi_cam_cy = pi_width/2; // center y coordinate of camera connector

// GPIO dimensions
pi_gpio_length = 50.8;
pi_gpio_width = 5.08;

// Processor dimensions
pi_proc_width = 12;
pi_proc_height = 2;
pi_proc_cx = 26;
pi_proc_cy = 13;

// Entry point, uncomment the line bellow to see the object
//rpi_zero_w();

module rpi_zero_w(){
    pi_board();
    translate([0, 0, pi_height]) pi_connectors();
    translate([pi_proc_cx - pi_proc_width/2, pi_proc_cy - pi_proc_width/2, pi_height])
        color("Black") cube([pi_proc_width, pi_proc_width, pi_proc_height]);
}

module pi_board(){
    difference(){
        color("DarkGreen") rounded_rect(pi_length, pi_width, pi_height, pi_corner_radius);
        // Mount holes
        for (i = [0:len(pi_mh_xy)-1]) pi_mount_hole(pi_mh_xy [i]);
    }
}

module pi_mount_hole(vect){
    translate(vect) color("LightYellow") cylinder(d=pi_mh_dia, pi_height + 2*ex);
}

module pi_connectors(){
    // Draw side connectors
    translate([0, -pi_connector_peek, 0]) color("Silver"){
        translate([pi_hdmi_cx - pi_hdmi_length/2, 0, 0]) 
            cube([pi_hdmi_length, pi_hdmi_width, pi_hdmi_height]);
        translate([pi_usb1_cx - pi_usb_length/2, 0, 0]) pi_usb();
        translate([pi_usb2_cx - pi_usb_length/2, 0, 0]) pi_usb();
    }
    // Draw SD card connector
    translate([pi_connector_peek, pi_sd_cy - pi_sd_length/2, 0]) {
        color("Silver") cube([pi_sd_length, pi_sd_length, pi_sd_height]);
        translate([-pi_connector_peek - pi_sd_peek, 0.5, 0.1])
            color("Black") 
            cube([pi_connector_peek + pi_sd_peek, pi_sd_length - 1, pi_sd_height - 0.2]);
    }
    // Draw camera connector
    translate([pi_length + pi_connector_peek - pi_camc_width,
                    pi_cam_cy - pi_camc_length/2, 0]) color("Beige")
            cube([pi_camc_width, pi_camc_length, pi_camc_height]);
    // Draw GPIO 2x20 headers
    translate([pi_length/2 - pi_gpio_length/2, pi_width - pi_mh_center - pi_gpio_width/2, 0]) 
        header_pin(2, 20);
}

module pi_usb(){
    cube([pi_usb_length, pi_usb_width, pi_hdmi_height]);
}

