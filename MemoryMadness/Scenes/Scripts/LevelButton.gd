extends TextureButton

@export var level_number: int = 1
@onready var level_text: Label = $LevelText
@onready var master: Control = $"."
@onready var sound: AudioStreamPlayer = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ls: LevelSettingResource = LevelDataSelector.get_level_setting(level_number)
	if ls == null:
		queue_free()
	else:
		level_text.text = "%dx%d" % [ls.get_cols(), ls.get_rows()]


func _on_pressed() -> void:
	SignalHub.emit_on_level_selected(level_number)
	SoundManager.play_button_click(sound)
