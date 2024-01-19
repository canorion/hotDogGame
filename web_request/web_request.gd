extends Node


@onready var player_count_request = $PlayerCountRequest

var player_count_req_url = ""


func request_player_count():
	player_count_request.request(player_count_req_url)
