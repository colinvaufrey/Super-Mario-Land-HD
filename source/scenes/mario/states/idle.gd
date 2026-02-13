# idle.gd
extends MarioState

var sliding: bool

func enter(_msg := {}) -> void:
	sliding = false
	if mario.is_super:
		mario.sprite.play("idle_super")
	else:
		mario.sprite.play("idle")


func physics_update(_delta: float) -> void:
	if mario.velocity.x > 0 and Input.is_action_pressed("move_left"):
		mario.sprite.play("slide")
		mario.sprite.flip_h = false
		sliding = true
	elif mario.velocity.x < 0 and Input.is_action_pressed("move_right"):
		mario.sprite.play("slide")
		mario.sprite.flip_h = true
		sliding = true
	elif abs(mario.velocity.x) < 0.01 and sliding:
		sliding = false
		mario.sprite.play("idle")
		mario.sprite.flip_h = not mario.sprite.flip_h
	if not mario.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif (int(mario.velocity.x) == 0) and mario.get_input_direction():
		state_machine.transition_to("Run")
	
	
	mario.velocity.x *= mario.slide_factor
	mario.move_and_slide()
