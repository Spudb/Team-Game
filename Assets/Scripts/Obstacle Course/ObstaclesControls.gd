extends CharacterBody2D

@export var JUMP_VELOCITY = -27500
@export var gravityMultiplier = 1.75

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * gravityMultiplier

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	move_and_slide()
