@tool
class_name SFXPlayer
extends AudioStreamPlayer2D

@export var sounds_by_name: Dictionary[String, AudioStream]

func play_sfx(sfx_name: String) -> void:
	if sfx_name in sounds_by_name:
		stream = sounds_by_name[sfx_name]
		play()
	else:
		push_error("SFX not found: %s" % sfx_name)
