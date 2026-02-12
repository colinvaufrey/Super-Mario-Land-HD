# air.gd
extends MarioState

var jump_cut := true
var hit_enemy := false

func _compute_jump_velocity() -> float:
	var horizontal_speed: float = abs(mario.velocity.x)
	var run_ratio: float = clamp(inverse_lerp(mario.speed, mario.run_speed, horizontal_speed), 0.0, 1.0)
	return lerp(mario.jump_velocity, mario.jump_velocity_running, run_ratio)

# If we get a message asking us to jump, we jump.
func enter(_msg := {}) -> void:
	if _msg.has("do_jump"):
		mario.velocity.y = - _compute_jump_velocity()
		mario.sfx_player.play_sfx("jump")
		if mario.is_super:
			mario.sprite.play("jump_super")
		else:
			mario.sprite.play("jump")
		jump_cut = false


func _check_collisions() -> void:
	hit_enemy = false
	var collision_count := mario.get_slide_collision_count()
	for i in range(collision_count):
		var collision := mario.get_slide_collision(i)
		var collider := collision.get_collider()
		if collider is HittableBlock:
			if collision.get_normal() == Vector2(0, 1):
				collider.hit(mario.is_super)
		elif collider is Enemy:
			collider.stomp()
			mario.velocity.y = - mario.stomp_jump
			hit_enemy = true


func physics_update(delta: float) -> void:
	if mario.is_on_floor() and not hit_enemy:
		if not mario.get_input_direction():
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	
	var input_direction_x := mario.get_input_direction()
	mario.velocity.x = mario.get_speed() * input_direction_x
	mario.velocity.y += mario.gravity * delta
	
	if Input.is_action_just_released("jump") and not jump_cut and mario.velocity.y < -mario.jump_cut_ceiling:
		jump_cut = true
		mario.velocity.y = - mario.jump_cut_ceiling
	
	mario.move_and_slide()
	
	_check_collisions()
