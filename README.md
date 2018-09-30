# Alertron
Alertrnon is a simple visual alert system based on RPi Zero W and Unicorn pHAT

Demo application in src/ is using http://www.meteoalarm.eu/ data to signal weather alerts for today and tomorrow. In this demo Country is set to Croatia and region is set to North Dalmatia region. See the code comments to change country and/or region. Any other type of data (e.g. sensor data, other web sources, REST API sources) can be used for visualisation. For example, data from outside temperature sensor can be used to represent different temperatures as colors and give visual representation rather than displaying values. This way, it can be usefull even for little children who can't read or for people with disabilities. Also, this way of data representation is 'readable' from greater distance, withot the need for bigger displays.

Included in model/ is 3D printable model for Unicorn pHAT diffuser. It should be printed in 'natural' or 'transparent' color, using PLA, PET-G or ABS filament. If the .stl file doesn't fit, change values in original OpenSCAD file and re-export to STL format.

Detailed project description and instructions can be found here: https://hackaday.io/project/161530-alertron
