extends Node2D


var random = RandomNumberGenerator.new()
var timer = Timer.new()


func _ready():
	timer.one_shot = false
	_set_random_wait_time()
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()


func _get_random_wait_time():
	return random.randf_range(2, 5)


func _on_timer_timeout():
	_set_random_wait_time()
	
	var home_sauce = load("res://sauce/sauce.tscn").instantiate()
	add_child(home_sauce)
	home_sauce.position.y -= 12
	
	var away_sauce = load("res://sauce/sauce.tscn").instantiate()
	add_child(away_sauce)
	away_sauce.position.y += 12


func _set_random_wait_time():
	timer.wait_time = _get_random_wait_time()
