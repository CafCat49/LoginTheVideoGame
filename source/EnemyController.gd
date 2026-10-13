extends CharacterBody2D

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -200
@export var direction = 1;
@export var is_ledge_turning = true
@export var is_wall_bouncing = true
@export var is_jumping = true

@onready var ledge_check = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	var total_bounce_time = (2 * abs(JUMP_VELOCITY)) / gravity
	var bounce_distance = SPEED * total_bounce_time 
	
	if (is_jumping):
		ledge_check.position.x = bounce_distance
		ledge_check.position.y = 0
		ledge_check.target_position = Vector2(0, 150)
		
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Standard gravity application
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 1. Check if we are approaching an edge
	var hit_ledge = is_ledge_turning and is_on_floor() and not ledge_check.is_colliding()
	var hit_wall = false
	
	if is_wall_bouncing and is_on_wall():
		var wall_normal = get_wall_normal()
		if (wall_normal.x < 0 and direction > 0) or (wall_normal.x > 0 and direction < 0):
			hit_wall = true
		
	if is_jumping and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if hit_ledge or hit_wall:
		turn_around()
	else:
		# Normal movement logic here
		velocity.x = SPEED * direction

	move_and_slide()
	
func turn_around():
	direction *= -1
	ledge_check.position.x = abs(ledge_check.position.x) * direction
	ledge_check.force_raycast_update()
