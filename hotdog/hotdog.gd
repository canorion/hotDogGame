extends Node2D


signal run_completed

var random = RandomNumberGenerator.new()
var sauce_timer = Timer.new()
var sauce_frames = []
var current_sauce_frame = 0
var max_sauce_frame = 0
var max_seconds = 60
var frame_offset = 3
var time_passed_timer = Timer.new()


func _ready():
	sauce_timer.one_shot = true
	sauce_timer.timeout.connect(_on_sauce_timer_timeout)
	add_child(sauce_timer)
	
	time_passed_timer.one_shot = true
	time_passed_timer.wait_time = max_seconds
	time_passed_timer.timeout.connect(_on_time_passed_timer_timeout)
	add_child(time_passed_timer)
	
	_generate_sauce_frames()


func _generate_sauce_frames():
	var current_seconds = 0
	
	while current_seconds < max_seconds:
		var rand_wait_time = _get_random_wait_time()
		current_seconds += rand_wait_time
		
		if (current_seconds + rand_wait_time) < (max_seconds - frame_offset):
			sauce_frames.push_back(current_seconds)
	
	max_sauce_frame = sauce_frames.size()


func _get_random_wait_time():
	return random.randf_range(2, 5)


func _on_sauce_timer_timeout():
	_set_next_wait_time()
	
	var home_sauce = load("res://sauce/sauce.tscn").instantiate()
	add_child(home_sauce)
	home_sauce.position.y -= 12
	
	var away_sauce = load("res://sauce/sauce.tscn").instantiate()
	add_child(away_sauce)
	away_sauce.position.y += 12


func _on_time_passed_timer_timeout():
	run_completed.emit()


func _set_next_wait_time():
	if current_sauce_frame >= max_sauce_frame:
		return
	
	if current_sauce_frame == 0:
		sauce_timer.wait_time = sauce_frames[current_sauce_frame]
	else:
		sauce_timer.wait_time = (sauce_frames[current_sauce_frame] - 
				sauce_frames[current_sauce_frame - 1])
	
	current_sauce_frame += 1
	sauce_timer.start()


func start_running():
	$Animation.play("run")
	_set_next_wait_time()
	time_passed_timer.start()


func stop_running():
	$Animation.play("stand")
