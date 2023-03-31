extends Control

@onready var label: Label = $PanelContainer/Label
@onready var mario: Mario = %Mario

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var debug_text := ""
	debug_text += "State: " + mario.state_machine.state.name
	label.text = debug_text
