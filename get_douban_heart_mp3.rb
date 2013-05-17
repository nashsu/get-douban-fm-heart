require "rubygems"
require 'json'
require 'net/http'

$KCODE="utf8"


uri = URI('http://www.douban.com/j/app/radio/liked_songs?count=666&token=eefcc1cb89&exclude=&version=606&client=s%3Amobile%7Cy%3Aandroid+2.3.5%7Cf%3A606%7Cm%3ADouban%7Cd%3A-1629744272%7Ce%3Ahkcsl_cht_htc_desire_s&app_name=radio_android&from=android_606_Douban&user_id=34411334&expire=1369658062&formats=aac')


res = Net::HTTP.get_response(uri)

hash = JSON.parse res.body

hash["songs"].each do |song|
dest = song["url"]
system("wget #{dest} ")

pic_dest = song["picture"]
pic_dest = pic_dest.gsub(/mpic/, "lpic")
system("wget #{pic_dest} ")
filename = song["url"].scan(/p\d+.mp3$/)[0]
picname = song["picture"].scan(/s\d+.jpg$/)
system("eyeD3 --add-image #{picname}:FRONT_COVER #{filename}")
system("rm -rf #{picname}")
mp3_name = song["title"] + ".mp3"
mp3_name = mp3_name.gsub(/\(/,"-")
mp3_name = mp3_name.gsub(/\)/,"")
mp3_name = mp3_name.gsub(/\'/,"")

system("mv #{filename} #{mp3_name} ")
end

