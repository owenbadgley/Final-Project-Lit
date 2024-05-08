extends Node

@onready var current_level = $Main
# Called when the node enters the scene tree for the first time.

func _ready():
	current_level.level_changed.connect(handle_level_changed) # Replace with function body.

func handle_level_changed(current_level_name: String):
	var next_level
	var next_level_name: String
	
	match current_level_name:
		"menu":
			next_level_name = "level_1"
		"level_1":
			next_level_name = "main"
			
	next_level = load("res://levels/" + next_level_name + ".tscn")
	add_child(next_level)
	next_level.level_changed.connect(handle_level_changed)
	current_level.queue_free()
	current_level = next_level
