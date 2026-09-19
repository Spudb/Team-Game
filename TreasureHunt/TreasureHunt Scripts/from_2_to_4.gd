extends Area2D

@onready var camera_2d: Camera2D = $"../../Camera2D"

func _on_body_entered(body: Node2D) -> void:
	camera_2d.position = Vector2(-577, -326)
