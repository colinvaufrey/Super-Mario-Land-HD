class_name InterroBlock
extends HittableBlock

var already_hit := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func hit(_by_super_mario := false) -> void:
	if not already_hit:
		already_hit = true
		animation_player.play("hit")
