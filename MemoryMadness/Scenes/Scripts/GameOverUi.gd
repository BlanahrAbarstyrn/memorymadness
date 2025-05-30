extends Control

@onready var moves: Label = $NPR/VB/Moves

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)


func on_game_over(moves_made: int) -> void:
	moves.text = "You took %d moves" % moves_made
	show()

func on_game_exit_pressed() -> void:
	hide()
