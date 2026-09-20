extends Area2D

var is_opened = false
var is_in = false
@onready var label: Label = $HowToInteract
@onready var player: CharacterBody2D = $"../Player"
@onready var treasure_hole: TileMapLayer = $"../TreasureHole"
@onready var treasure_chest: TileMapLayer = $"../TreasureChest"
@onready var collision_shape_2d: CollisionShape2D = $"../TreasureChest/StaticBody2D/CollisionShape2D"

func _physics_process(delta: float) -> void:
	mark_interaction()

func _on_body_entered(body: Node2D) -> void:
	is_in = true
	if is_opened == false:
		label.show()


func _on_body_exited(body: Node2D) -> void:
	label.hide()
	is_in = false

func mark_interaction():
	if Input.is_action_just_pressed("Interact"):
		if is_in == true:
			if is_opened == false:
				if player.is_having_shovel == true:
					label.hide()
					hide()
					treasure_hole.show()
					treasure_chest.show()
					collision_shape_2d.set_deferred("disabled", false)
					is_opened = true
