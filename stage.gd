extends Node2D


var home_player_count = 0
var away_player_count = 0

@onready var home_count_text = $UI/Container/HomeCount
@onready var away_count_text = $UI/Container/AwayCount


func _ready():
	WebListener.js_message_arrived.connect(_on_js_message_arrived)
	
	$Hotdog.run_completed.connect(_on_run_completed)
	
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


func _on_js_message_arrived(msg_dict):
	if msg_dict.message == "ready":
		$UI/Container/StartText/Animation.play("start")


func _unhandled_input(event):
	#if not OS.has_feature("pc"):
		#return
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			$UI/Container/StartText/Animation.play("start")


func set_player_counts(home, away):
	home_player_count = home
	away_player_count = away
	
	home_count_text.text = str(home_player_count) + " Players"
	away_count_text.text = str(away_player_count) + " Players"


func set_start_text(text: String):
	$UI/Container/StartText.text = str(text)


func start_running():
	$Hotdog.start_running()
	$HomePlayer.start_running()
	$AwayPlayer.start_running()
	$Background/Animation.play("move")
	
	# Send frame data and game start time with a request
	#$Hotdog.get_sauce_frames()


func stop_running():
	$Hotdog.stop_running()
	$HomePlayer.stop_running()
	$AwayPlayer.stop_running()
	$Background/Animation.play("stop")


func _on_run_completed():
	stop_running()
