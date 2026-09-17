extends Node2D


func _process(delta: float) -> void:
	pass

# البتاع دي لو عايز تستقبل كليك شمال على area مثلا
func check_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1

func _on_target_test_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		print()

func _ready() -> void:
	$CanvasLayer/start_menu.visible = 1
	$CanvasLayer/score.visible = 0
	$CanvasLayer/highest.visible = 1
	

func start_game():
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
