extends Area2D

const COLORS = {
	"red": Color.RED,
	"blue": Color.DODGER_BLUE,
	"yellow": Color.YELLOW,
	"green": Color.LIME_GREEN,
}

@export var balloon_color: String = "red"
@export var speed = 240.0

func _ready():
	modulate = COLORS[balloon_color]

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			pop()

func _process(delta):
	position.y -= speed * delta
	if position.y < -100:
		queue_free()

func pop():
	var game = get_tree().current_scene
	
	game.balloon_popped(balloon_color)
	
	print("Balloon popped!")
	queue_free()
