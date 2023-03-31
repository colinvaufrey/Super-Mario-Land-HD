# idle.gd
extends MarioState

func enter(_msg := {}) -> void:
	mario.velocity = Vector2.ZERO
	mario.sprite.play("idle")


func update(_delta: float) -> void:
	if not mario.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
