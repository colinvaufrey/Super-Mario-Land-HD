class_name Enemy
extends CharacterBody2D

@export var speed := 30
@export var direction := 1

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var collision: CollisionShape2D = $Collision
@onready var sfx: AudioStreamPlayer2D = $SFX

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	var current_direction = direction
	
	if not is_on_floor():
		velocity.y += gravity * delta
		current_direction = 0
	
	velocity.x = current_direction * speed
	move_and_slide()
	
	var collision_count := get_slide_collision_count()
	for i in range(collision_count):
		var collision := get_slide_collision(i)
		if collision.get_normal() == Vector2(1, 0) or collision.get_normal() == Vector2(-1, 0) :
			direction = -direction
			break


func _on_hit_area_body_entered(body: Node2D) -> void:
	if body is Mario:
		body.hit()


func stomp() -> void:
	sprite.play("stomped")
	sfx.play()
	direction = 0
	collision.disabled = true
	set_physics_process(false)
	await get_tree().create_timer(1).timeout
	queue_free()
