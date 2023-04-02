extends HittableBlock

var already_hit := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func hit(by_super_mario := false):
	if not already_hit:
		already_hit = true
		animation_player.play("hit")
