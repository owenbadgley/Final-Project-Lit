extends CanvasLayer
@export var level_name = "level"
@onready var player_1 = $Player1

signal level_changed(level_name)

func _ready():
	player_1.level_cleared.connect(handle_level_cleared)
	
func handle_level_cleared():
	print("level cleared")
	emit_signal("level_changed", level_name)
