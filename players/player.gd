extends CharacterBody2D


@onready var anim = $Animation
@onready var sprite = $Sprite
@onready var area = $Area


func _ready():
	anim.animation_finished.connect(_on_anim_finished)
	area.area_entered.connect(_on_area_entered)


func _on_anim_finished(anim_name):
	if anim_name == "jump":
		anim.play("run")


func init_as_home():
	sprite.texture = load("res://players/player_home.png")


func init_as_away():
	sprite.texture = load("res://players/player_away.png")


func _on_area_entered(area):
	if not anim.current_animation == "run":
		return
	
	anim.play("jump")


func start_running():
	$Animation.play("run")


func stop_running():
	$Animation.play("stand")
