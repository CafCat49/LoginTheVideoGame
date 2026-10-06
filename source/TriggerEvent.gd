extends Area2D

@export var trigger_function: String
@export var target_node: Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	# Optional: Check if the thing that walked into the trigger is the Player
	print("Trigger")
	if body.is_in_group("player"):
		
		# Check if a target node was assigned and if it has the desired function
		if target_node and target_node.has_method(trigger_function) and "respawnPlayer" == trigger_function:
			target_node.respawnPlayer() # Calls the function on
			print("Trigger respawn")
		if target_node and target_node.has_method(trigger_function) and "setSpawn" == trigger_function:
			target_node.setSpawn(position) # Calls the function on	
			print("Set spawn %d %d" % [position.x, position.y])
	
