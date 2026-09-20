extends TileMapLayer

var is_opened = false
var is_in = false
@onready var how_to_interact: Label = $Area2D/HowToInteract2

func _physics_process(delta: float) -> void:
	chest_interaction()

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_in = true
	if is_opened == false:
		how_to_interact.show()

func chest_interaction():
	if Input.is_action_just_pressed("Interact"):
		if is_in == true:
			if is_opened == false:
				win()
				is_opened = true

func win():
	pass
