# Run.gd
extends MarioState

func enter(_msg := {}) -> void:
	if mario.is_super:
		mario.sprite.play("run_super")
	else:
		mario.sprite.play("run")


func physics_update(_delta: float) -> void:
	if not mario.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	var input_direction_x: int = mario.get_input_direction()
	mario.velocity.x = mario.get_speed() * input_direction_x
	mario.velocity.y += mario.gravity * _delta
	mario.move_and_slide()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif input_direction_x == 0:
		state_machine.transition_to("Idle")
