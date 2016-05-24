require 'net/http'
require 'json'


puts "Enter Summoner Name #1"

$summoner_1 = gets.chomp

puts "Enter Summoner Name #2"

$summoner_2 = gets.chomp	


url = "https://na.api.pvp.net/api/lol/NA/v1.4/summoner/by-name/#{$summoner_1}?api_key=862de57e-2107-4f84-a18b-3665232f4b97"
uri = URI(url)
response = Net::HTTP.get(uri)
summoner_1_info = JSON.parse(response)

summoner_1_id = summoner_1_info[$summoner_1]["id"]


 
url = "https://na.api.pvp.net/api/lol/NA/v1.4/summoner/by-name/#{$summoner_2}?api_key=862de57e-2107-4f84-a18b-3665232f4b97"
uri = URI(url)
response = Net::HTTP.get(uri)
summoner_2_info = JSON.parse(response)

summoner_2_id = summoner_2_info[$summoner_2]["id"]


url = "https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/#{summoner_1_id}?api_key=862de57e-2107-4f84-a18b-3665232f4b97"
uri = URI(url)
response = Net::HTTP.get(uri)
summoner_1_matchlist = JSON.parse(response)
summoner_1_matches_id = Array.new(10)

url = "https://na.api.pvp.net/api/lol/na/v2.2/matchlist/by-summoner/#{summoner_2_id}?api_key=862de57e-2107-4f84-a18b-3665232f4b97"
uri = URI(url)
response = Net::HTTP.get(uri)
summoner_2_matchlist = JSON.parse(response)
summoner_2_matches_id = Array.new(10)



(0..9).each do |i|
	summoner_1_matches_id[i] = summoner_1_matchlist["matches"][i]["matchId"]
end

	
(0..9).each do |i|
	summoner_2_matches_id[i] = summoner_2_matchlist["matches"][i]["matchId"]
end


summoner_1_match_info = Array.new(10)

(0..9).each do |i|
	sleep 1.5
	url = "https://na.api.pvp.net/api/lol/na/v2.2/match/#{summoner_1_matches_id[i]}?api_key=862de57e-2107-4f84-a18b-3665232f4b97"
	uri = URI(url)
	response = Net::HTTP.get(uri)
	summoner_1_match_info[i] = JSON.parse(response)
	
end

summoner_2_match_info = Array.new(10)
(0..9).each do |i|
	sleep 1.5
	url = "https://na.api.pvp.net/api/lol/na/v2.2/match/#{summoner_2_matches_id[i]}?api_key=862de57e-2107-4f84-a18b-3665232f4b97"
	uri = URI(url)
	response = Net::HTTP.get(uri)
	summoner_2_match_info[i] = JSON.parse(response)
	
end


summoner_1_match_stats = Array.new(10)

(0..9).each do |i|
		summoner_1_match_info[i]["participantIdentities"].each do |player|
					
				if player["player"]["summonerName"].downcase == $summoner_1 then
						participantId = player["participantId"]
						summoner_1_match_info[i]["participants"].each do |participant|
							
							if participant["participantId"] == participantId then

								summoner_1_match_stats[i] = participant
								break	
							end
							
						end
						break
				end
		end	
end



summoner_2_match_stats = Array.new(10)

(0..9).each do |i|
		summoner_2_match_info[i]["participantIdentities"].each do |player|
					
				if player["player"]["summonerName"].downcase == $summoner_2 then
						participantId = player["participantId"]
						summoner_2_match_info[i]["participants"].each do |participant|
							
							if participant["participantId"] == participantId then
								summoner_2_match_stats[i] = participant
								break	
							end
							
						end
						break
				end
		end
		
end


summoner_1_xpDiffPerMinDelta_zeroToTen = 0
summoner_1_xpDiffPerMinDelta_tenToTwenty = 0
summoner_1_damageTakenDiffPerMinDeltas_zeroToTen = 0
summoner_1_damageTakenDiffPerMinDeltas_tenToTwenty = 0
summoner_1_goldPerMinDeltas_zeroToTen = 0
summoner_1_goldPerMinDeltas_tenToTwenty	= 0			
summoner_1_csDiffPerMinDeltas_zeroToTen = 0
summoner_1_csDiffPerMinDeltas_tenToTwenty = 0			
			
summoner_2_xpDiffPerMinDelta_zeroToTen = 0
summoner_2_xpDiffPerMinDelta_tenToTwenty = 0
summoner_2_damageTakenDiffPerMinDeltas_zeroToTen = 0
summoner_2_damageTakenDiffPerMinDeltas_tenToTwenty = 0
summoner_2_goldPerMinDeltas_zeroToTen = 0
summoner_2_goldPerMinDeltas_tenToTwenty	= 0			
summoner_2_csDiffPerMinDeltas_zeroToTen = 0
summoner_2_csDiffPerMinDeltas_tenToTwenty = 0			
		


(0..9).each do |i|
	summoner_1_xpDiffPerMinDelta_zeroToTen += summoner_1_match_stats[i]["timeline"]["xpDiffPerMinDeltas"]["zeroToTen"].to_i
	summoner_1_xpDiffPerMinDelta_tenToTwenty += summoner_1_match_stats[i]["timeline"]["xpDiffPerMinDeltas"]["tenToTwenty"].to_i
	summoner_1_damageTakenDiffPerMinDeltas_zeroToTen += summoner_1_match_stats[i]["timeline"]["damageTakenDiffPerMinDeltas"]["zeroToTen"].to_i
	summoner_1_damageTakenDiffPerMinDeltas_tenToTwenty += summoner_1_match_stats[i]["timeline"]["damageTakenDiffPerMinDeltas"]["tenToTwenty"].to_i
	summoner_1_goldPerMinDeltas_zeroToTen += summoner_1_match_stats[i]["timeline"]["goldPerMinDeltas"]["zeroToTen"].to_i
	summoner_1_goldPerMinDeltas_tenToTwenty	+= summoner_1_match_stats[i]["timeline"]["goldPerMinDeltas"]["tenToTwenty"].to_i			
	summoner_1_csDiffPerMinDeltas_zeroToTen += summoner_1_match_stats[i]["timeline"]["csDiffPerMinDeltas"]["zeroToTen"].to_i
	summoner_1_csDiffPerMinDeltas_tenToTwenty += summoner_1_match_stats[i]["timeline"]["csDiffPerMinDeltas"]["tenToTwenty"].to_i		

	summoner_2_xpDiffPerMinDelta_zeroToTen += summoner_2_match_stats[i]["timeline"]["xpDiffPerMinDeltas"]["zeroToTen"].to_i
	summoner_2_xpDiffPerMinDelta_tenToTwenty += summoner_2_match_stats[i]["timeline"]["xpDiffPerMinDeltas"]["tenToTwenty"].to_i
	summoner_2_damageTakenDiffPerMinDeltas_zeroToTen += summoner_2_match_stats[i]["timeline"]["damageTakenDiffPerMinDeltas"]["zeroToTen"].to_i
	summoner_2_damageTakenDiffPerMinDeltas_tenToTwenty += summoner_2_match_stats[i]["timeline"]["damageTakenDiffPerMinDeltas"]["tenToTwenty"].to_i
	summoner_2_goldPerMinDeltas_zeroToTen += summoner_2_match_stats[i]["timeline"]["goldPerMinDeltas"]["zeroToTen"].to_i
	summoner_2_goldPerMinDeltas_tenToTwenty	+= summoner_2_match_stats[i]["timeline"]["goldPerMinDeltas"]["tenToTwenty"].to_i			
	summoner_2_csDiffPerMinDeltas_zeroToTen += summoner_2_match_stats[i]["timeline"]["csDiffPerMinDeltas"]["zeroToTen"].to_i
	summoner_2_csDiffPerMinDeltas_tenToTwenty += summoner_2_match_stats[i]["timeline"]["csDiffPerMinDeltas"]["tenToTwenty"].to_i			

end

summoner_1_xpDiffPerMinDelta_zeroToTen /= 10
summoner_1_xpDiffPerMinDelta_tenToTwenty /= 10
summoner_1_damageTakenDiffPerMinDeltas_zeroToTen /= 10
summoner_1_damageTakenDiffPerMinDeltas_tenToTwenty /= 10
summoner_1_goldPerMinDeltas_zeroToTen /= 10
summoner_1_goldPerMinDeltas_tenToTwenty	/= 	10	
summoner_1_csDiffPerMinDeltas_zeroToTen /= 10
summoner_1_csDiffPerMinDeltas_tenToTwenty /= 	10		
			
summoner_2_xpDiffPerMinDelta_zeroToTen /= 10
summoner_2_xpDiffPerMinDelta_tenToTwenty /= 10
summoner_2_damageTakenDiffPerMinDeltas_zeroToTen /= 10
summoner_2_damageTakenDiffPerMinDeltas_tenToTwenty /= 10
summoner_2_goldPerMinDeltas_zeroToTen /= 10
summoner_2_goldPerMinDeltas_tenToTwenty	/= 10			
summoner_2_csDiffPerMinDeltas_zeroToTen /= 10
summoner_2_csDiffPerMinDeltas_tenToTwenty /= 10			

def diff(x,y)
		if(x>y) then
			v = $summoner_1
			i = x - y
		elsif (y>x) then 
			v = $summoner_2
			i = y - x
		else
			v = "tie"
			i = 0
		end

		return {"advantage" => v, "lead" => i}

end


xpDiffPerMinDelta_zeroToTen = diff(summoner_1_xpDiffPerMinDelta_zeroToTen,summoner_2_xpDiffPerMinDelta_zeroToTen)
xpDiffPerMinDelta_tenToTwenty = diff(summoner_1_xpDiffPerMinDelta_tenToTwenty,summoner_2_xpDiffPerMinDelta_tenToTwenty)
damageTakenDiffPerMinDeltas_zeroToTen = diff(summoner_1_damageTakenDiffPerMinDeltas_zeroToTen,summoner_2_damageTakenDiffPerMinDeltas_zeroToTen)
damageTakenDiffPerMinDeltas_tenToTwenty = diff(summoner_1_damageTakenDiffPerMinDeltas_tenToTwenty,summoner_2_damageTakenDiffPerMinDeltas_tenToTwenty)
goldPerMinDeltas_zeroToTen = diff(summoner_1_goldPerMinDeltas_zeroToTen,summoner_2_goldPerMinDeltas_zeroToTen)
goldPerMinDeltas_tenToTwenty = 	diff(summoner_1_goldPerMinDeltas_tenToTwenty,summoner_2_goldPerMinDeltas_tenToTwenty)	
csDiffPerMinDeltas_zeroToTen = diff(summoner_1_csDiffPerMinDeltas_zeroToTen,summoner_2_csDiffPerMinDeltas_zeroToTen)
csDiffPerMinDeltas_tenToTwenty = diff(summoner_1_csDiffPerMinDeltas_tenToTwenty,summoner_2_csDiffPerMinDeltas_tenToTwenty)		

puts xpDiffPerMinDelta_zeroToTen
puts xpDiffPerMinDelta_tenToTwenty
puts damageTakenDiffPerMinDeltas_zeroToTen
puts damageTakenDiffPerMinDeltas_tenToTwenty
puts goldPerMinDeltas_zeroToTen

summoner_1_points = 0
summoner_2_points = 0

if xpDiffPerMinDelta_zeroToTen["advantage"] == $summoner_1
	summoner_1_points += xpDiffPerMinDelta_zeroToTen["lead"] * 1.5
else
	summoner_2_points += xpDiffPerMinDelta_zeroToTen["lead"] * 1.5		
end

if xpDiffPerMinDelta_tenToTwenty["advantage"] == $summoner_1
	summoner_1_points += xpDiffPerMinDelta_tenToTwenty["lead"]
else
	summoner_2_points += xpDiffPerMinDelta_tenToTwenty["lead"]		
end

if(damageTakenDiffPerMinDeltas_zeroToTen["advantage"] == $summoner_1)
	summoner_1_points += damageTakenDiffPerMinDeltas_zeroToTen["lead"] * 1.2
else
	summoner_2_points += damageTakenDiffPerMinDeltas_zeroToTen["lead"] * 1.2	
end

if(damageTakenDiffPerMinDeltas_tenToTwenty["advantage"] == $summoner_1)
	summoner_1_points += damageTakenDiffPerMinDeltas_tenToTwenty["lead"]

else
	summoner_2_points += damageTakenDiffPerMinDeltas_tenToTwenty["lead"]		
end

if(goldPerMinDeltas_zeroToTen["advantage"] == $summoner_1)
	summoner_1_points += goldPerMinDeltas_zeroToTen["lead"] * 0.4

else
	summoner_2_points += goldPerMinDeltas_zeroToTen["lead"]	* 0.4	
end

if(goldPerMinDeltas_tenToTwenty["advantage"] == $summoner_1)
	summoner_1_points += goldPerMinDeltas_tenToTwenty["lead"] * 0.25

else
	summoner_2_points += goldPerMinDeltas_tenToTwenty["lead"] * 0.25		
end

if(csDiffPerMinDeltas_zeroToTen["advantage"] == $summoner_1)
	summoner_1_points += csDiffPerMinDeltas_zeroToTen["lead"] * 8

else
	summoner_2_points += csDiffPerMinDeltas_zeroToTen["lead"] * 8		
end

if(csDiffPerMinDeltas_tenToTwenty["advantage"] == $summoner_1)
	summoner_1_points += csDiffPerMinDeltas_tenToTwenty["lead"] * 4

else
	summoner_2_points += csDiffPerMinDeltas_tenToTwenty["lead"]	* 4	
end
 total = summoner_1_points + summoner_2_points
summoner_1_chance = summoner_1_points / total * 100
summoner_2_chance = summoner_2_points / total * 100

puts "#{$summoner_1} has a #{summoner_1_chance.round(2)}% of winning lane"
puts "#{$summoner_2} has a #{summoner_2_chance.round(2)}% of winning lane"