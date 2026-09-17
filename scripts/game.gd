extends Node2D



func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if tent_shooter:
			get_tree().change_scene_to_file("res://scenes/shooter.tscn")
	
	pass


var tent_shooter = 0
func _on_tent_shooter_body_entered(body: Node2D) -> void:
	if body == $player:
		tent_shooter = 1
func _on_tent_shooter_body_exited(body: Node2D) -> void:
	if body == $player:
		tent_shooter = 0




#
