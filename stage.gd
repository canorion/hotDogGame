extends Node2D


var home_player_count = 0
var away_player_count = 0

@onready var home_count_text = $UI/Container/HomeCount
@onready var away_count_text = $UI/Container/AwayCount


func _ready():
	#WebRequest.request_player_count()
	#var req = await WebRequest.player_count_request.request_completed
	#var player_counts = JSON.parse_string(req[3].get_string_from_utf8())
	var player_counts = {
		"home": 10,
		"away": 10,
	}
	set_player_counts(player_counts.home, player_counts.away)
	
	$HomePlayer.init_as_home()
	$AwayPlayer.init_as_away()


func set_player_counts(home, away):
	home_player_count = home
	away_player_count = away
	
	home_count_text.text = str(home_player_count) + " Players"
	away_count_text.text = str(away_player_count) + " Players"
