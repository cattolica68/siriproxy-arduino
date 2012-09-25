require 'cora'
require 'siri_objects'
require 'open-uri'
require 'json'
require 'net/http'

#############
# This is a plugin for SiriProxy that will allow you to control SickBeard.
# Example usage: "search my shows backlog."
#############

class SiriProxy::Plugin::Arduino < SiriProxy::Plugin

    def initialize(config)
        @host = config["arduino_host"]
        @port = config["arduino_port"]
    end
    
    listen_for /hello (arduino|circuit board)/i do
        begin
            say "This is Mongo's Arduino speaking!"
        end
        request_completed
    end
end