require 'cora'
require 'siri_objects'
require 'open-uri'
require 'json'
require 'net/http'

#############
# This is a plugin for SiriProxy that will allow you to control x10 Devices with Arduino.
# Example usage: "turn on living room lights"
#############

class SiriProxy::Plugin::Arduino < SiriProxy::Plugin

    def initialize(config)
        @host = config["arduino_host"]
        @port = config["arduino_port"]
    end
    
    x10 = Hash['dining room lights', "DRLights", 'dining room light', "DRLights", 'front porch lights', "FrontPorchLights", 'front porch light', "FrontPorchLights"]
    
    listen_for /((turn (on|on the|off|off the) (.+))|(turn the (.+) (on|off)))/i do |response|
        begin
            x10.each_key do |loc|
                if response.downcase.include? loc
                    if response.downcase.include? "on"
                        server = arduinoParser(x10[response.downcase], "ON")
                    elsif response.downcase.include? "off"
                        server = arduinoParser(x10[response.downcase], "OFF")
                    end
                    if server.code == "200"
                        say "The #{response} are now ON!"
                    end
                end
            end
            
        rescue Errno::EHOSTUNREACH
            say "Sorry, I could not connect to your Arduino."
        rescue Errno::ECONNREFUSED
            say "Sorry, the Arduino is not running."
        rescue Errno::ENETUNREACH
            say "Sorry, Could not connect to the network."
        rescue Errno::ETIMEDOUT
            say "Sorry, The operation timed out."
        end
        request_completed
    end

    def arduinoParser(dvc, cmd)
        
        url = "http://#{@host}:#{@port}/?device=#{dvc}&cmd=#{cmd}"
        resp = Net::HTTP.get_response(URI.parse(url))
        
        return resp;
    end
end