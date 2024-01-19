extends Node2D


var random = RandomNumberGenerator.new()
var timer = Timer.new()


func _ready():
	timer.one_shot = true
	timer.wait_time = 10
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	random.randomize()
	var rand_number = random.randi_range(0, 1)
	
	if rand_number == 1:
		$Mustard.visible = false
	else:
		$Ketchup.visible = false


func _process(delta):
	position.x -= delta * 320


func _on_timer_timeout():
	queue_free()
