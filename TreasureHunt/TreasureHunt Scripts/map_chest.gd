extends StaticBody2D

@onready var label: Label = $Label

func _ready() -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	var is_opened = false
	label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	label.hide()
