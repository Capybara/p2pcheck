#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'

def remote_file_exists?(url)
url = URI.parse(url)
	Net::HTTP.start(url.host, url.port) do |http|
return http.head(url.request_uri).code == "200"
	end
end
site = {"Couchpotato"=>"5050","Sickbeard"=>"8081/home/","Headphones"=>"8181/home","Sabnzbd"=>"8080"}
url = "http://10.0.1.8:"

#site.each {|name,port| puts "#{name} is good" if remote_file_exists? "http://10.0.1.8:#{port}"}
site.each do |name,port|
if remote_file_exists? "#{url}#{port}"
  puts "#{name} is good"
else

	puts "There seems to be a problem with #{name}"
end
end
							

