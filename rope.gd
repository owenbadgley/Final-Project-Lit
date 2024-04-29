#thanks to https://www.youtube.com/watch?v=Wzrw6_KDMl4 this guy for helping with the hook

extends Node2D
var chain
var direction := Vector2(0,0)
var tip := Vector2(0,0)

const SPEED = 50
var flying = false
var hooked = false

func shoot(dir: Vector2) -> void:
	direction = dir.normalized()
	flying = true
	tip = self.global_position
	
func release() -> void:
	flying = false
	hooked = false
	

# Called when the node enters the scene tree for the first time.
func _ready():
	chain = $chain
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.visible = flying or hooked
	if not self.visible:
		return
	var tip_loc = to_local(tip)
	chain.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(90)
	$tip.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(90)
	chain.position = tip_loc
	chain.region_rect.size.y = tip_loc.length()
	
func _physics_process(delta):
	$tip.global_position = tip
	if flying:
		if $tip.move_and_collide(direction * SPEED):
			hooked = true
			flying = false
	tip = $tip.global_position
