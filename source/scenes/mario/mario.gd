class_name Mario
extends CharacterBody2D

@export var speed = 1800.0
@export var run_speed = 320.0

@export var jump_velocity = 400.0
@export var jump_cut_ceiling := 50.0

@onready var state_machine: Node = $StateMachine
@onready var sprite: AnimatedSprite2D = $Sprite

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var acceleration: Vector2 = Vector2.ZERO

func get_input_direction() -> int:
	var input_direction := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input_direction:
		sprite.flip_h = input_direction < 0
	return input_direction


func get_speed() -> float:
	return run_speed if Input.is_action_pressed("run_fireball") else speed
