extends Node


@onready var ready_request = $ReadyRequest
@onready var player_count_request = $PlayerCountRequest
@onready var time_info_request = $TimeInfoRequest
@onready var end_request = $EndRequest

#https://stadiumgames.azurewebsites.net
var player_count_req_url = "http://localhost:3001/api/hotdog/gamestatus/"
var time_info_req_url = "http://localhost:3001/api/hotdog/startgame"
var ready_request_url = "http://localhost:3001/api/hotdog/game"
var end_request_url = "http://localhost:3001/api/hotdog/endgame/"


func request_end(game_id):
	end_request.request(end_request_url + str(game_id))


func request_ready_req():
	ready_request.request(ready_request_url)


func request_player_count(game_id):
	player_count_request.request(player_count_req_url + str(game_id))


func request_time_info(dict):
	var json = JSON.stringify(dict)
	var headers = ["Content-Type: application/json"]
	time_info_request.request(
			time_info_req_url, headers, HTTPClient.METHOD_POST, json)
