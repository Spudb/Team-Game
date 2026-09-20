extends Node2D

var things_to_spawn = [
	preload("res://Assets/Scenes/Obstacles Course/obstacles.tscn"),
	preload("res://Assets/Scenes/Obstacles Course/obstacles_1.tscn")
]

func _ready() -> void:
	$Timer.wait_time = randf_range(1.0, 4.0)
	$Timer.start()

func _on_timer_timeout() -> void:
	var thing = things_to_spawn.pick_random()
	var new_thing = thing.instantiate()
	add_child(new_thing)
	new_thing.position = position
	$Timer.wait_time = randf_range(1.0, 4.0)
	$Timer.start()

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("GAME OVER")
		get_tree().paused = true
