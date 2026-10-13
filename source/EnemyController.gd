extends CharacterBody2D

@export var SPEED = 200.0
@export var direction = 1;
@export var is_ledge_turning = true
@export var is_wall_bouncing = true

@onready var ledge_check = $RayCast2D

@onready var ray_offset_x = ledge_check.position.x

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
		
	
	if hit_ledge or hit_wall:
		turn_around()
	else:
		# Normal movement logic here
		velocity.x = SPEED * direction

	move_and_slide()
	
func turn_around():
	direction *= -1
	ledge_check.position.x = ray_offset_x * direction
