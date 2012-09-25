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
    
    listen_for /(turn on (.*) | turn (.*) on | switch on (.*) | switch (.*) on)/i do |response|
        begin
            if(response.downcase.include? "dining room")
        		if(response.downcase.include? "lights")
            		server = arduinoParser("DRLights", "ON")
            	end
            
            elsif(response.downcase.include? "office")
        		if(response.downcase.include? "fan")
        			server = arduinoParser("OfficeFan", "ON")
        		end
        	end
            
            if(server.code == "200")
            	say "The #{response} are now on!"
            
            else
            	say "Sorry there was a problem"
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
    
    listen_for /(turn off (.*) | turn (.*) off | switch off (.*) | switch (.*) off)/i do |response|
        begin
        	if(response.downcase.include? "dining room")
        		if(response.downcase.include? "lights")
        			server = arduinoParser("DRLights", "OFF")
        		end
        	
        	elsif(response.downcase.include? "office")
        		if(response.downcase.include? "fan")
        			server = arduinoParser("OfficeFan", "OFF")
        		end
        	end
        	
        	if(server.code == "200")
            	say "The #{response} are now on!"
            
            else
            	say "Sorry there was a problem"
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