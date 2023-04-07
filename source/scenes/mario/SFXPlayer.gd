@tool
class_name SFXPlayer
extends AudioStreamPlayer2D

@export var sounds: Array[AudioStream]
@export var names: Array[String]

func play_sfx(name: String):
	var index = names.find(name)
	if index != -1:
		stream = sounds[index]
		play()
	else:
		print_debug("SFX not found!")
