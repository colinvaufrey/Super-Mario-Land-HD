extends Control

@onready var label: Label = $PanelContainer/Label
@onready var mario: Mario = %Mario

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	var debug_text := ""
	debug_text += "State: %s\n" % mario.state_machine.state.name
	debug_text += "Velocity: %.2f" % mario.velocity.x
	label.text = debug_text
