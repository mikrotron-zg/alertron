""" First, install libraries:
    - unicornhat via 'curl https://get.pimoroni.com/unicornhat  | bash'
    - feedparser via 'sudo pip install feedparser'
    Then, get this project from https://github.com/mikrotron-zg/alertron
    Finnaly, run the script: 'sudo python aerotron.py'
"""

# Import libraries we need
import feedparser as fp     # RSS feed parser library
import unicornhat as uphat  # Unicorn (p)HAT library
import time

# Set warning level RGB colors - meteoalarm.eu uses 4 colors: green, yellow, orange and red
levels = {'1' : (0, 255, 0), '2' : (255, 255, 0), '3' : (255, 102, 0), '4' : (255, 0, 0)}

# Global variables
rss = ''
l_today = ''
l_tomorrow = ''


def getRssFeed(country_code):
    # Get rss feed for Croatia from Meteoalarm
    return fp.parse("http://www.meteoalarm.eu/documents/rss/" + country_code + ".rss")

def getRssFeedIndex(region):
    # Find region index
    for n in range(len(rss.entries)):
        if (rss.entries[n]['title'] == region):
            return n

def getWarningLevels():
    # There are two warning levels, one for today and one for tommorow, let's find them
    global l_today, l_tomorrow
    # First, get rss contents for the selected region
    txt = rss.entries[i]['description']

    # Find warning level for today
    l_index = txt.find('level:', txt.find('Today'))
    l_today = rss.entries[i]['description'][l_index + 6:l_index + 7]

    # Find warning level for tomorrow
    l_index = txt.find('level:', txt.find('Tomorrow'))
    l_tomorrow = rss.entries[i]['description'][l_index + 6:l_index + 7]

def showData():
    # Show the received data, use this for debugging
    print rss.entries[i]['title']
    print rss.entries[i]['description']
    print rss.entries[i]['link']
    print 'Today:' + l_today
    print 'Tomorrow:' + l_tomorrow

def setLedColors():
    # Set today level color
    for y in range(4):
        for x in range(4):
            uphat.set_pixel(x,y,levels[l_today][0], levels[l_today][1],levels[l_today][2])

    # Set tomorrow level color
    for y in range(4):
        for x in range(4, 8):
            uphat.set_pixel(x,y,levels[l_tomorrow][0], levels[l_tomorrow][1],levels[l_tomorrow][2])


# This is where the script starts
# Set unicorn phat LEDs
uphat.set_layout(uphat.PHAT) # Library works for both HAT and pHAT, we choose the second one
uphat.rotation(180) # If your Zero power USB is on the top side use this setting, else set to 0
uphat.brightness(1) # WARNING: if you're not using the diffuser, don't set this to more than 0.5!!!!

# Run forever :-)
while True:
    # Get RSS feed for Croatia - change the code for other countries, e.g. 'de' for Germany
    rss = getRssFeed('hr')
    # Get region index from RSS feed
    i = getRssFeedIndex('North Dalmatia region')
    # Get warning levels for the selected region
    getWarningLevels()
    # If everything works fine, you can comment out the next line
    showData()
    # Set LED colors according to warnning levels for today and tomorrow
    setLedColors()
    # Finnaly, show the colors
    uphat.show()
    # Time (in seconds) until we refresh data, one hour (3600 seconds) is OK for this purpose
    time.sleep(3600)
