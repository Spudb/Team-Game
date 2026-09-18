extends Node2D

var sound_start = preload("res://audio/start.mp3")
var sound_shot = preload("res://audio/dragon-studio-gunshot-504030.mp3")

func play_sound(sound, vol = 0.0):
	var temp = AudioStreamPlayer.new()
	temp.stream = sound
	temp.volume_db = vol
	add_child(temp)
	
	temp.finished.connect(temp.queue_free)
	temp.play()

@onready var gun: Sprite2D = $"CanvasLayer/341994"

func _process(delta: float) -> void:
	# y: rotation -21.2: 7.2
	# y:-45:92
	#$"CanvasLayer/341994".rotation = 
	
	var mouse_x = get_global_mouse_position().x
	var mouse_y = get_global_mouse_position().y

#
	#if mouse_y > -45 and mouse_y < 110:
		#gun.rotation = remap(mouse_y, -45, 110, 5.9, 6.3)
	#else:
		#gun.rotation = 0
	#
	gun.rotation = remap(mouse_y, -45, 110, 5.9, 6.3)
	gun.position.x = remap(mouse_x, -320, -15, 31.0, 396.0)
	
	
	
	# -320:-15
	# pos.x  -31.0:396.0
	#print(gun.rotation)
	#print(get_global_mouse_position())
	pass

# البتاع دي لو عايز تستقبل كليك شمال على area مثلا
func check_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1

func _on_target_test_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		print()

func _ready() -> void:
	$CanvasLayer/dark.visible = 1
	$CanvasLayer/start_menu.visible = 1
	$CanvasLayer/score.visible = 0
	$CanvasLayer/highest.visible = 1
	

func start_game():
	play_sound(sound_start)
	$CanvasLayer/dark.visible = 0
	$CanvasLayer/start_menu.visible = 0
	await get_tree().create_timer(0.5).timeout
	$CanvasLayer/score.visible = 1
	await get_tree().create_timer(0.5).timeout
	game_running = 1
	$CanvasLayer/time.visible = 1
	
	$game_time.start()
	spawn_apply()

var game_running = 0

func game_over():
	
	$CanvasLayer/restart_menu.visible = 1
	game_running = 0
	$game_time.stop()
	for i in $targets.get_children():
		i.queue_free()

var max_targets = 1

# هنا البتاعة الي بتتحكم ف الوقت بين ظهور تارجت وتارجت
func spawn_apply():
	
	while $targets.get_child_count() != max_targets:
		if !game_running: return
		spawn_target()
	
	
	await get_tree().create_timer(2.5).timeout
	spawn_apply()

# هنا البتاعة الي بترسبن تارجت
var target = preload("res://scenes/target.tscn")
func spawn_target():
	var temp = target.instantiate()
	var tempy = randi_range(0, 2)
	# بيrandomize الارتفاع على تلت احتمالات (الصفوف يعني)
	match tempy:
		0: tempy = 22
		1: tempy = -38
		2: tempy = 81
	
	temp.game = self
	temp.position.x = randi_range(-28.0, -310.0)
	temp.position.y = tempy
	
	$targets.add_child(temp)
	
	#await get_tree().create_timer(3.0).timeout
	#temp.queue_free()

var highest_score = 0
var score = 0
func target_hit():
	score += 1
	
	play_sound(sound_shot)
	#تحديث الui
	$CanvasLayer/score.text = "Score: " + str(score)
	
	await get_tree().create_timer(0.3).timeout
	if $targets.get_child_count() < max_targets && game_running:
		spawn_target()

var time = 30
func _on_game_time_timeout() -> void:
	time -= 1 
	$CanvasLayer/time.text = ""
	if time < 10: $CanvasLayer/time.text = str(0) 
	$CanvasLayer/time.text += str(time)
	if time == 0:
		game_over()
		
	if time > 20:
		max_targets = 1
	elif time > 10:
		max_targets = 2
	else:
		max_targets = 3


func _on_start_pressed() -> void:
	start_game()


func _on_leave_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
