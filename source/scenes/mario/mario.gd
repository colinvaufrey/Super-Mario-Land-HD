class_name Mario
extends CharacterBody2D

@export var is_super := false 

var speed := 59
var run_speed := 93

var jump_velocity := 146
var jump_cut_ceiling := 82
var stomp_jump := 60
var slide_factor := 0.6

var gravity: int = 320
#var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var state_machine: Node = $StateMachine
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var sfx_player: SFXPlayer = $SFXPlayer

var acceleration: Vector2 = Vector2.ZERO

func get_input_direction() -> int:
	var input_direction := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input_direction:
		sprite.flip_h = input_direction < 0
	return input_direction


func get_speed() -> float:
	return run_speed if Input.is_action_pressed("run_fireball") else speed


func hit() -> void:
	sfx_player.play_sfx("power_down")
	pass
