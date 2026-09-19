extends Area2D

@export var balloon_color: String = "red"

func pop():
	print("Balloon popped!")
	queue_free()
