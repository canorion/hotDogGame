extends Node2D


var home_player_count = 0
var away_player_count = 0

@onready var home_count_text = $UI/Container/HomeCount
@onready var away_count_text = $UI/Container/AwayCount

var score_timer = Timer.new()
var ready_timer = Timer.new()

var game_id = ""


func _ready():
	WebListener.js_message_arrived.connect(_on_js_message_arrived)
	
	$Hotdog.run_completed.connect(_on_run_completed)
	
	score_timer.wait_time = 3
	score_timer.timeout.connect(_on_score_timer_timeout)
	add_child(score_timer)
	
	ready_timer.wait_time = 3
	ready_timer.timeout.connect(_on_ready_timer_timeout)
	ready_timer.one_shot = false
	add_child(ready_timer)
	ready_timer.start()
	
	$HomePlayer.init_as_home()
	$AwayPlayer.init_as_away()
	
	var sauce_frames = $Hotdog.get_sauce_frames()
	var frames = ""
	for i in sauce_frames.frames.size():
		frames += str(sauce_frames.frames[i])
		if i < sauce_frames.frames.size() - 1:
			frames += ","
	
	WebRequest.request_time_info({
		"gameId": game_id,
		"timeData": frames,
	})


func _on_ready_timer_timeout():
	WebRequest.request_ready_req()
	var req = await WebRequest.ready_request.request_completed
	var ready_json = JSON.parse_string(req[3].get_string_from_utf8())
	print(ready_json)
	if ready_json.data[0].has("_id"):
		game_id = ready_json.data[0]._id
		ready_timer.stop()


func _on_score_timer_timeout():
	_update_scores()


func _update_scores():
	WebRequest.request_player_count(game_id)
	var req = await WebRequest.player_count_request.request_completed
	var player_counts_json = JSON.parse_string(req[3].get_string_from_utf8())
	print(player_counts_json)
	var player_counts = {
		"home": player_counts_json.playerCounts.home,
		"away": player_counts_json.playerCounts.away,
		"win_info": "",
	}
	
	set_player_counts(player_counts.home, player_counts.away)
	
	if player_counts.win_info != "":
		$UI/Container/StartText.text = str(player_counts.win_info) + " wins!"
	#else:
		#$UI/Container/StartText.text = "Well done!"


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
	
	score_timer.start()


func stop_running():
	$Hotdog.stop_running()
	$HomePlayer.stop_running()
	$AwayPlayer.stop_running()
	$Background/Animation.play("stop")
	
	score_timer.stop()


func _on_run_completed():
	stop_running()
