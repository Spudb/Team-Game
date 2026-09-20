extends StaticBody2D

var is_opened = false
var is_in = false

@onready var label: Label = $HowToInteract
@onready var player: CharacterBody2D = $"../Player"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var shovel_taken: Label = $ShovelTaken
@onready var shovel: TextureRect = $"../HUD/Shovel"
@onready var animated_shovel: Control = $"../HUD/AnimatedShovel"

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
				animated_sprite_2d.play("opened")
				player.is_having_shovel = true
				shovel_taken.show_notification()
				shovel.hide()
				animated_shovel.show()
				is_opened = true
