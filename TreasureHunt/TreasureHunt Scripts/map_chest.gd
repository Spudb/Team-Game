extends StaticBody2D

var is_opened = false
var is_in = false

@onready var label: Label = $Label
@onready var sub_viewport_container: SubViewportContainer = $"../CanvasLayer/SubViewportContainer"
@onready var player: CharacterBody2D = $"../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	chest_interaction()

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_in = true
	if is_opened == false:
		label.show()
	else:
		pass
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	label.hide()
	is_in = false

func chest_interaction():
	if Input.is_action_just_pressed("Interact"):
		if is_in == true:
			if is_opened == false:
				sub_viewport_container.show()
				animated_sprite_2d.play("opened")
				is_opened = true
