#!/usr/bin/env ruby
#
# This script is meant to be ran via a launchd plist to check the availability of my Sabnzbd plugins
require "rubygems"
require "bundler/setup"
require "prowl"
require 'terminal-notifier'
require 'open-uri'
require 'net/http'
load '~/.p2pcheck'
require './pgrep'

require 'prowl'
p = Prowl.new(:apikey=>"#{$papi}",:application=>"p2pcheck")
#
# the url variable will have to be changed to your servers IP address and ports in the site array
# you should put the following 2 lines in a file named ~/.p2pcheck
#site = {"Couchpotato"=>"5050","Sickbeard"=>"8081/home/","Headphones"=>"8181/home","Sabnzbd"=>"8080"}
#url = "http://10.0.1.8:"

#this method was taken from a Dzone snipet. It works pretty good if the urls are exact
def remote_file_exists?(url)
url = URI.parse(url)
	Net::HTTP.start(url.host, url.port) do |http|
return http.head(url.request_uri).code == "200"
	end
end

#site.each {|name,port| puts "#{name} is good" if remote_file_exists? "http://10.0.1.8:#{port}"}
$site.each do |name,port|
r = 0
if pgrep_wrap("#{name}")
	message = "#{name}'s process is running"
		if remote_file_exists? "#{$url}#{port}"
			reachable = "#{name} is reachable"
		else
			reachable = "#{name} isn't reachable"
			r += 1
		end
else
	message = "#{name}'s process isn't running"
	r += 1
end
	if r > 0
		p.add(:event=>"#{reachable}\n#{message}")
		TerminalNotifier.notify("#{reachable}\n#{message}", :title =>"Attention!", :execute => "lunchy restart com.tv.#{name.downcase}")
if r > 0
  p.add(:event=>"#{reachable}\n#{message}")
	TerminalNotifier.notify("#{reachable}\n#{message}", :title =>"Attention!", :execute => "lunchy restart com.tv.#{name.downcase}")
end
puts "#{reachable},\n#{message}"
end
end
