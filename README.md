SiriProxy-Arduino
==

About
--

Allows you to control [x10](http://x10.com) devices using an [Arduino](http://arduino.cc) with Siri!

Installation
--

1. Add the following to ~./siriproxy/config.yml

  - name: 'Arduino'
      git: 'git://github.com/mongo527/siriproxy-arduino.git'
      arduino_host: '[Enter Arduino IP]' # IP of Arduino with Ethernet Shield
      arduino_port: '[Enter Arduino Port]' # Port Arduino is using

2. Change options that need to be changed in config.yml.

3. Run the bundler
	- $ siriproxy bundle

4. Start SiriProxy using 
	- $ rvmsudo siriproxy server

6. To update:
	- $ siriproxy update

Voice Commands
--

+ Turn on *device* / Turn *device* on
+ Turn off *device* / Turn *device* off

Coming Soon
--

+ Dim / Brighten Lights
+ Control IR Devices (TV) - Hopefully
+ Thermostat

Notes
--

This is one of my first times using Ruby. I figured it would be a decent way to learn the language. So help me where you can! 

Thanks!

Credits
--

Thanks to [Plamoni](https://github.com/plamoni/SiriProxy) and [Westbaer](https://github.com/westbaer/SiriProxy) for SiriProxy.

You are free to use, modify, and redistribute the SiriProxy-SickBeard gem as long as proper credit is given to.