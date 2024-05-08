extends CanvasLayer
@export var level_name = "level"

signal level_changed(level_name)

func level_cleard():
	emit_signal("level_changed", level_name)
