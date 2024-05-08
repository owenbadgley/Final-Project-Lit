extends CanvasLayer
@export var level_name = "level"
@onready var player_1 = $Player1
@onready var player_2 = $Player2

signal level_changed(level_name)
signal restart_level(level_name)

func _ready():
	player_1.level_cleared.connect(handle_level_cleared)
	player_2.level_cleared.connect(handle_level_cleared)
	player_1.death.connect(handle_respawn)
	player_2.death.connect(handle_respawn)
	
func handle_level_cleared():
	emit_signal("level_changed", level_name)

func handle_respawn():
	emit_signal("restart_level", level_name)
