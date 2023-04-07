extends Area2D

@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var sprite: AnimatedSprite2D = $Sprite

var collected := false

func _on_body_entered(body: Node2D) -> void:
	if not collected and body is Mario:
		sfx.play()
		sprite.visible = false
		collected = true


func _on_sfx_finished() -> void:
	queue_free()
