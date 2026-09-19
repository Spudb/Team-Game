extends Area2D

@export var balloon_color: String = "red"

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			pop()

func pop():
	var game = get_tree().current_scene
	
	game.balloon_popped(balloon_color)
	
	print("Balloon popped!")
	queue_free()
