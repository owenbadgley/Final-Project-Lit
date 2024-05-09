extends Node

@onready var current_level = $Main
# Called when the node enters the scene tree for the first time.

func _ready():
	current_level.level_changed.connect(handle_level_changed) # Replace with function body.
	current_level.restart_level.connect(handle_restart_level)

func handle_level_changed(current_level_name: String):
	var next_level
	var next_level_name: String
	
	match current_level_name:
		"main":
			next_level_name = "level_1"
		"level_1":
			next_level_name = "level_2"
		"level_2":
			next_level_name = "level_3"
		"level_3":
			next_level_name = "level_4"
		"level_4":
			next_level_name = "level_5"
		"level_5":
			next_level_name = "level_6"
			
	var temp = load("res://levels/"+next_level_name+".tscn") # res://levels/level_1.tscn
	next_level = temp.instantiate() # this is required in order to see the scene
	call_deferred("add_child",next_level) # call_differred fixes a few errors
	next_level.connect("level_changed", handle_level_changed)
	next_level.connect("restart_level", handle_restart_level) # syntax is a little different in version 4
	current_level.queue_free()
	current_level = next_level

func handle_restart_level(current_level_name: String):
	var next_level
	var next_level_name: String
	
	next_level_name = current_level_name
			
	var temp = load("res://levels/"+next_level_name+".tscn") # res://levels/level_1.tscn
	next_level = temp.instantiate() # this is required in order to see the scene
	call_deferred("add_child",next_level) # call_differred fixes a few errors
	next_level.connect("level_changed", handle_level_changed)
	next_level.connect("restart_level", handle_restart_level) # syntax is a little different in version 4
	current_level.queue_free()
	current_level = next_level
