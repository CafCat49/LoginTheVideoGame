extends CharacterBody2D

@export var speed: float = 300.0				#Your ground speed
@export var jump_velocity: float = -400.0		#How high you jump
@export var has_double_jump: bool				#Two jumps?
@export var flight_turn_speed: float = 150.0	#2nd speed when jumping
@export var lock_y_pos: float					#Camera y axis

var last_direction: float = 0.0
var extra_jump: bool = false

func _init() -> void:
	extra_jump = has_double_jump

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or extra_jump):
		last_direction = direction
		if is_on_floor() and has_double_jump:
			extra_jump = true;
		if not is_on_floor():
			extra_jump = false;
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var current_speed = speed
	# print(str(int(velocity.x) % 2) + " " + str(int(last_direction) % 2))
	var changed_direction = (velocity.x > 0 and last_direction < 0)   \
						 or (velocity.x < 0 and last_direction > 0)   \
						 or (velocity.x == 0 and last_direction != 0) \
						 or (velocity.x != 0 and last_direction == 0)
 									# If you changed direction in the air
	if not is_on_floor() and changed_direction:
		current_speed = flight_turn_speed
		
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)

	move_and_slide()
