extends CharacterBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $"../Map/SubViewportContainer/SubViewport/Camera2D"

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var is_having_shovel: bool = false

func _ready() -> void:
	var sub_viewport: SubViewport = $"../Map/SubViewportContainer/SubViewport"
	if sub_viewport:
		sub_viewport.world_2d = get_viewport().world_2d

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	camera_2d.position = global_position

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	if velocity.x > 0:
		animated_sprite_2d.play("walk_right")
	elif velocity.x < 0:
		animated_sprite_2d.play("walk_left")
	elif velocity.y > 0:
		animated_sprite_2d.play("walk_down")
	elif velocity.y < 0:
		animated_sprite_2d.play("walk_up")
	elif velocity == Vector2.ZERO:
		if Input.is_action_just_released("ui_up"):
			animated_sprite_2d.play("idle_up")
		elif Input.is_action_just_released("ui_down"):
			animated_sprite_2d.play("idle_down")
		elif Input.is_action_just_released("ui_left"):
			animated_sprite_2d.play("idle_left")
		elif Input.is_action_just_released("ui_right"):
			animated_sprite_2d.play("idle_right")
	
	move_and_slide()
	
