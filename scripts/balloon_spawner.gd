extends Node2D

@export var balloon_scene: PackedScene

@onready var spawn_area: Area2D = $"../SpawnArea"
@onready var balloons_container: Node2D = $"../BalloonsContainer"
@onready var spawn_timer: Timer = $SpawnTimer

var colors = ["red", "blue", "yellow", "green"]

func _ready():
	spawn_timer.timeout.connect(spawn_balloon)

func spawn_balloon():
	var balloon = balloon_scene.instantiate()
	
	balloon.position = get_random_position()
	balloon.balloon_color = colors.pick_random()
	
	balloons_container.add_child(balloon)

func get_random_position() -> Vector2:
	var shape = spawn_area.get_node("CollisionShape2D").shape
	var size = shape.size
	
	var x = randf_range(-size.x / 2, size.x / 2)
	var y = randf_range(-size.y / 2, size.y / 2)
	
	return spawn_area.position + Vector2(x,y)
