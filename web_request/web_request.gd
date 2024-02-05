extends Node


@onready var player_count_request = $PlayerCountRequest
@onready var time_info_request = $TimeInfoRequest

var player_count_req_url = ""
var time_info_req_url = ""


func request_player_count():
	player_count_request.request(player_count_req_url)


func request_time_info(dict):
	var json = JSON.stringify(dict)
	var headers = ["Content-Type: application/json"]
	time_info_request.request(
			time_info_req_url, headers, HTTPClient.METHOD_POST, json)
