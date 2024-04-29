extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@export var speed = 400
@export var jump_height = 1000
@export var speed_limit = 500
@export var horizontal_air_coeffecient = 0.8
@export var friction = 0.2
@export var blink_distance = 2000
@export var speed_limit_vert = speed_limit
var blinking = -100

func _get_input():
	if is_on_floor():
		if Input.is_action_pressed("p2_left"):
			velocity += Vector2(-speed, 0)
		if Input.is_action_pressed("p2_right"):
			velocity += Vector2(speed, 0)
		if Input.is_action_just_pressed("p2_jump"):
			velocity += Vector2(0, -jump_height)
	if not is_on_floor():
		if Input.is_action_pressed("p2_left"):
			velocity += Vector2(-speed * horizontal_air_coeffecient, 0)
		if Input.is_action_pressed("p2_right"):
			velocity += Vector2(speed * horizontal_air_coeffecient, 0)
	

func _apply_gravity():
	if not is_on_floor():
		velocity += gravity

func _limit_speed():
		if velocity.x > speed_limit:
			velocity = Vector2(speed_limit, velocity.y)
		if velocity.x < -speed_limit:
			velocity = Vector2(-speed_limit, velocity.y)
		if velocity.y < -speed_limit_vert:
			velocity.y *= 0.01

func _apply_friction():
	if is_on_floor() and not (Input.is_action_pressed("p2_left") or Input.is_action_pressed("p2_right")):
		velocity -= Vector2(velocity.x * friction, 0)
		if abs(velocity.x) < 10:
			velocity = Vector2(0, velocity.y)
	
func _blink():
	blinking -= 1
	if (Input.is_action_just_pressed("p2_blink") and blinking < -35):
		velocity = Vector2(0,0);
		if Input.is_action_pressed("p2_left"):
			velocity += Vector2(-blink_distance, 0)
		if Input.is_action_pressed("p2_right"):
			velocity += Vector2(blink_distance, 0)
		if Input.is_action_pressed("p2_jump"):
			velocity += Vector2(0, -blink_distance)
		if Input.is_action_pressed("p2_down"):
			velocity += Vector2(0, blink_distance)
		velocity = velocity.normalized()
		velocity *= blink_distance
		blinking = 5


func _physics_process(delta):
	_get_input()
	_blink()
	if (blinking < 0):
		_limit_speed()
		_apply_friction()
		_apply_gravity()
	
	move_and_slide()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

