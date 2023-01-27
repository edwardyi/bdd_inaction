#!/bin/bash

# Start Xvfb
Xvfb :99 -ac -screen 0 1280x1024x24 &
export DISPLAY=:99

# Start Selenium
java -jar /usr/local/bin/selenium-server-standalone.jar &

# Wait for Selenium to start
sleep 5

# Run your tests
# ...

# Stop Selenium and Xvfb
killall -9 java
killall -9 Xvfb