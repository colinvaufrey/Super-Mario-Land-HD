# Run.gd
extends MarioState

var entered_direction: int

func enter(_msg := {}) -> void:
	entered_direction = mario.get_input_direction()
	if mario.is_super:
		mario.sprite.play("run_super")
	else:
		mario.sprite.play("run")


func physics_update(_delta: float) -> void:
	if not mario.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var input_direction_x: int = mario.get_input_direction()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif input_direction_x != entered_direction:
		state_machine.transition_to("Idle")
	if input_direction_x == entered_direction:
		mario.velocity.x = mario.get_speed() * input_direction_x
	mario.velocity.y += mario.gravity * _delta
	mario.move_and_slide()
