extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@export var speed = 400
@export var jump_height = 1000
@export var speed_limit = 500
@export var horizontal_air_coeffecient = 0.8
@export var friction = 0.2
@export var grapple_strength = 100
var chain_velocity = Vector2(0,0)



func _get_input():
	if Input.is_action_just_pressed("p1_grapple") and not $Hook.flying and not $Hook.hooked:
		_shoot_hook()
	elif Input.is_action_just_pressed("p1_grapple"):
		$Hook.release()
	if is_on_floor():
		if Input.is_action_pressed("p1_left"):
			velocity += Vector2(-speed, 0)
		if Input.is_action_pressed("p1_right"):
			velocity += Vector2(speed, 0)
		if Input.is_action_just_pressed("p1_jump"):
			velocity += Vector2(0, -jump_height)
	if not is_on_floor():
		if Input.is_action_pressed("p1_left"):
			velocity += Vector2(-speed * horizontal_air_coeffecient, 0)
		if Input.is_action_pressed("p1_right"):
			velocity += Vector2(speed * horizontal_air_coeffecient, 0)
		if Input.is_action_pressed("p1_down"):
			velocity += Vector2(0, speed * horizontal_air_coeffecient)
	

func _apply_gravity():
	if not is_on_floor():
		velocity += gravity

func _limit_speed():
	if velocity.x > speed_limit:
		velocity = Vector2(speed_limit, velocity.y)
	if velocity.x < -speed_limit:
		velocity = Vector2(-speed_limit, velocity.y)

func _apply_friction():
	if is_on_floor() and not (Input.is_action_pressed("p1_left") or Input.is_action_pressed("p1_right")):
		velocity -= Vector2(velocity.x * friction, 0)
		if abs(velocity.x) < 10:
			velocity = Vector2(0, velocity.y)

func _shoot_hook():
	var hook_direction = Vector2(0,0)
	if Input.is_action_pressed("p1_left"):
		hook_direction += Vector2(-1, 0)
	if Input.is_action_pressed("p1_right"):
		hook_direction += Vector2(1, 0)
	if Input.is_action_pressed("p1_jump"):
		hook_direction += Vector2(0, -1)
	if hook_direction != Vector2(0,0):
		$Hook.shoot(hook_direction)
	
func _hook_pull():
	if $Hook.hooked:
		chain_velocity = to_local($Hook.tip).normalized() * grapple_strength
		if chain_velocity.y > 0:
			chain_velocity.y*= 0.55
		else:
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(velocity.x):
			chain_velocity.x *= 0.7
	else:
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity

func _physics_process(delta):
	_get_input()
	_limit_speed()
	_apply_friction()
	_apply_gravity()
	_hook_pull()
	move_and_slide()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

