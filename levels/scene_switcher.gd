extends Node

@onready var current_level = $Main
# Called when the node enters the scene tree for the first time.

func _ready():
	current_level.level_changed.connect(handle_level_changed) # Replace with function body.

func handle_level_changed(current_level_name: String):
	print("yum")
	var next_level
	var next_level_name: String
	
	match current_level_name:
		"main":
			next_level_name = "level_1"
		"level_1":
			next_level_name = "main"
			
	var temp = load("res://levels/"+next_level_name+".tscn") # res://levels/level_1.tscn
	next_level = temp.instantiate() # this is required in order to see the scene
	call_deferred("add_child",next_level) # call_differred fixes a few errors
	next_level.connect("level_changed", handle_level_changed) # syntax is a little different in version 4
	current_level.queue_free()
	current_level = next_level
