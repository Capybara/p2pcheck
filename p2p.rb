#!/usr/bin/env ruby
#
# This script is meant to be ran via a launchd plist to check the availability of my Sabnzbd plugins
require "rubygems"
require "bundler/setup"
require "prowl"
require 'terminal-notifier'
require 'net/ping'
load '~/.p2pcheck'
require './pgrep'

p = Prowl.new(:apikey=>"#{$papi}",:application=>"p2pcheck")

# the url variable will have to be changed to your servers IP address and ports in the site array
# you should put your settings in a file named ~/.p2pcheck
# there is a sample .p2pcheck, you can edit it and move to ur home dirctory

def remote_file_exists?(port)
	Net::Ping::TCP.new($url,port).ping?
end

$site.each do |name,port|
r = 0
if pgrep_wrap("#{name}")
	message = "#{name}'s process is running"
		if remote_file_exists?(port)
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
        end
puts "#{reachable},\n#{message}"

end
