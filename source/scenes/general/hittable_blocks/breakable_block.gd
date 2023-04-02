extends HittableBlock

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func hit(by_super_mario := false):
	if by_super_mario:
		animation_player.play("break")
	else:
		animation_player.play("hit")
