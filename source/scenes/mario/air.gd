# air.gd
extends MarioState

var jump_cut := true

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		mario.velocity.y = -mario.jump_velocity
		if mario.is_super:
			mario.sprite.play("jump_super")
		else:
			mario.sprite.play("jump")
		jump_cut = false


func physics_update(delta: float) -> void:
	var input_direction_x := mario.get_input_direction()
	mario.velocity.x = mario.get_speed() * input_direction_x
	mario.velocity.y += mario.gravity * delta
	
	mario.move_and_slide()
	
	if Input.is_action_just_released("jump") and not jump_cut and mario.velocity.y < -mario.jump_cut_ceiling:
		jump_cut = true
		mario.velocity.y = -mario.jump_cut_ceiling
	
	if mario.is_on_floor():
		if is_equal_approx(mario.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	
	var collision_count := mario.get_slide_collision_count()
	for i in range(collision_count):
		var collision := mario.get_slide_collision(i)
		var collider := collision.get_collider()
		if collider is HittableBlock:
			print(collision.get_normal())
			if collision.get_normal() == Vector2(0, 1):
				collider.hit(mario.is_super)
