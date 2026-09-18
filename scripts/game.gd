extends Node2D



func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if tent_shooter:
			get_tree().change_scene_to_file("res://scenes/shooter.tscn")
	
	
	
	$map/shooter_tent/info.position.x = remap($player.position.x, 320, 800, 90, -130)
	
	#print($player.position)

var tent_shooter = 0
func _on_tent_shooter_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("tent")
		tent_shooter = 1
func _on_tent_shooter_body_exited(body: Node2D) -> void:
	if body.name == "player":
		tent_shooter = 0
#
#func _on_tent1_left_body_entered(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_left.visible = 1
#func _on_tent1_left_body_exited(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_left.visible = 0
#func _on_tent1_right_body_entered(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_right.visible = 1
#func _on_tent1__right_body_exited(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_right.visible = 0
func _on_tent1_info_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$map/shooter_tent/info.visible = 1
func _on_tent1_info_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		$map/shooter_tent/info.visible = 0
