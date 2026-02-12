class_name Mario
extends CharacterBody2D

@export var is_super := false

@export_group("Movement")
@export var speed := 59
@export var run_speed := 93

@export var jump_velocity := 146
@export var jump_velocity_running := 170
@export var jump_cut_ceiling := 82
@export var stomp_jump := 60
@export var slide_factor := 0.6

@export var gravity: int = 320

@onready var state_machine: Node = $StateMachine
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var sfx_player: SFXPlayer = $SFXPlayer
@onready var block_detector: Area2D = $BlockDetector

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
