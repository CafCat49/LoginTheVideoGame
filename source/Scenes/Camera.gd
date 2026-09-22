extends Camera2D

var player: CharacterBody2D
var lock_y_pos: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_parent()
	if (player && player.lock_y_pos == 0):
		lock_y_pos = global_position.y
	elif (player):
		lock_y_pos = player.lock_y_pos
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (player):
		global_position.x = player.global_position.x
	global_position.y = lock_y_pos
	pass
