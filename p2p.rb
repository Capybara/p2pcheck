#!/usr/bin/env ruby
#
# This script is meant to be ran via a launchd plist to check the availability of my Sabnzbd plugins
# the url variable will have to be changed to your servers IP address and ports in the site array
require "rubygems"
require "bundler/setup"
require 'terminal-notifier'
require 'open-uri'
require 'net/http'
require './config'
require './pgrep'


#
#site = {"Couchpotato"=>"5050","Sickbeard"=>"8081/home/","Headphones"=>"8181/home","Sabnzbd"=>"8080"}
#url = "http://10.0.1.8:"

#this method was taken from a Dzone snipet. It works pretty good, but the url has to be exact
def remote_file_exists?(url)
url = URI.parse(url)
	Net::HTTP.start(url.host, url.port) do |http|
return http.head(url.request_uri).code == "200"
	end
end

#site.each {|name,port| puts "#{name} is good" if remote_file_exists? "http://10.0.1.8:#{port}"}
$site.each do |name,port|
if remote_file_exists? "#{$url}#{port}"
  puts "#{name} is good"
else
	TerminalNotifier.notify("#{name} isn't available", :title =>"Attention!", :subtitle =>"click \"show\"", :execute => 'say omg')
	puts "There seems to be a problem with #{name}"
	puts "-The process isn't running-" if	pgrep_wrap("#{name}")
end
end
							

