extends Control

const MEMORY_TILE = preload("res://Scenes/MemoryTile.tscn")

@onready var tile_grid: GridContainer = $HBFullScreen/TileGrid
@onready var sound: AudioStreamPlayer = $Sound
@onready var scorer: Scorer = $Scorer
@onready var moves_qty: Label = $HBFullScreen/ScoreMC/ScoreVB/MovesHB/MovesQty
@onready var paris_qty: Label = $HBFullScreen/ScoreMC/ScoreVB/PairsHB/ParisQty


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _enter_tree() -> void:
	SignalHub.on_level_selected.connect(on_level_selected)

func _process(delta: float) -> void:
	moves_qty.text = scorer.get_moves_made_str()
	paris_qty.text = scorer.get_pairs_made_str()

func add_memory_tile(image: Texture2D, frame: Texture2D) -> void:
	var mt: MemoryTile = MEMORY_TILE.instantiate()
	tile_grid.add_child(mt)
	mt.setup(image, frame)

func on_level_selected(level_num: int) -> void:
	var lds: LevelDataSelector = \
			LevelDataSelector.get_level_selection(level_num)
	
	var fi: Texture2D = ImageManager.get_random_frame_image()
	
	tile_grid.columns = lds.get_num_cols()
	
	for im in lds.get_selected_images():
		add_memory_tile(im,fi)
	
	scorer.clear_new_game(lds.get_target_pairs())

func _on_exit_button_pressed() -> void:
	for t in tile_grid.get_children():
		t.queue_free()
	SoundManager.play_button_click(sound)
	SignalHub.emit_on_game_exit_pressed()
