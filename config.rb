#!/usr/bin/env ruby
# change your ports and services as need be in the 'site' array
$site = {"Pytivo"=>"9032","Couchpotato"=>"5050","Sickbeard"=>"8081/home/","Headphones"=>"8181/home","Sabnzbd"=>"8080"}
# set the base url of your server ,be sure to include the trailing colon
$url = "http://10.0.1.8:"