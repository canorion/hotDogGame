extends Node2D


func _ready():
	WebListener.js_message_arrived.connect(_on_js_message_arrived)


func _on_js_message_arrived(msg_dict):
	if msg_dict.message == "ready":
		start()


func _unhandled_input(event):
	if not OS.has_feature("pc"):
		return
	
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			get_tree().change_scene_to_file("res://stage.tscn")


func start():
	get_tree().change_scene_to_file("res://stage.tscn")
