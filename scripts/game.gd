extends Node2D


func allow_move():
	$player.move = 1
func disable_move():
	$player.move = 0
	

func _ready() -> void:
	allow_move()
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if tent_shooter:
			await enter_game("res://scenes/shooter.tscn")
	
	
	$map/shooter_tent/info.position.x = remap($player.position.x, 320, 800, 90, -130)
	
	#print($player.position)

func enter_game(game):
	disable_move()
	var tween = create_tween()
	tween.tween_property($CanvasLayer/black, "modulate:a", 1, 0.3)
	
	await get_tree().create_timer(0.3).timeout
	
	get_tree().change_scene_to_file(game)

var tent_shooter = 0
var pulse: Tween
func _on_tent_shooter_body_entered(body: Node2D) -> void:
	if body.name == "player":
		print("tent")
		tent_shooter = 1
		var e = $map/shooter_tent/e
		var og_scale = e.scale.x
		var tw_scale = e.scale.x + 0.04
		e.visible = 1
		
		pulse = create_tween().set_loops()
		pulse.tween_property(e, "scale", Vector2(tw_scale, tw_scale), 0.3)
		pulse.tween_property(e, "scale", Vector2(og_scale, og_scale), 0.3)
		
		
func _on_tent_shooter_body_exited(body: Node2D) -> void:
	if body.name == "player":
		tent_shooter = 0
		$map/shooter_tent/e.visible = 0 
		if pulse:
			pulse.kill()
		$map/shooter_tent/e.scale = Vector2(0.195, 0.195)
		
#
#func _on_tent1_left_body_entered(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_left.visible = 1
#func _on_tent1_left_body_exited(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_left.visible = 0
#func _on_tent1_right_body_entered(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_right.visible = 1
#func _on_tent1__right_body_exited(body: Node2D) -> void:
	#if body.name == "player":
		#$map/shooter_tent/info_right.visible = 0

var pulse2: Tween
var pulse3: Tween

func _on_tent1_info_area_body_entered(body: Node2D) -> void:
	if body.name == "player":
		var tween_frame = create_tween()
		tween_frame.tween_property($CanvasLayer/frame, "modulate:a", 1, 0.3)
		
		
		var tent = $map/shooter_tent/tent
		var tent_up = $map/shooter_tent/tent_up
		var og_scale = tent.scale.x
		var tw_scale = tent.scale.x + 0.002
		
		pulse2 = create_tween().set_loops()
		pulse3 = create_tween().set_loops()
		
		pulse2.tween_property(tent, "scale", Vector2(tw_scale, tw_scale), 0.3)
		pulse2.tween_property(tent, "scale", Vector2(og_scale, og_scale), 0.3)
		
		pulse3.tween_property(tent_up, "scale", Vector2(tw_scale, tw_scale), 0.3)
		pulse3.tween_property(tent_up, "scale", Vector2(og_scale, og_scale), 0.3)
		
		
		var info = $map/shooter_tent/info
		info.visible = 1
		info.scale = Vector2(0,0)
		var tween = create_tween()
		tween.tween_property(info, "scale", Vector2(1.1,1.1), 0.3)
		tween.tween_property(info, "scale", Vector2(1,1), 0.1)
func _on_tent1_info_area_body_exited(body: Node2D) -> void:
	if body.name == "player":
		var tween_frame = create_tween()
		tween_frame.tween_property($CanvasLayer/frame, "modulate:a", 0, 0.3)
		
		
		$map/shooter_tent/tent.scale = Vector2(0.184, 0.184)
		$map/shooter_tent/tent_up.scale = Vector2(0.184, 0.184)
		pulse2.kill()
		pulse3.kill()
		
		var info = $map/shooter_tent/info
		var tween = create_tween()
		tween.tween_property(info, "scale", Vector2(1.1,1.1), 0.3)
		tween.tween_property(info, "scale", Vector2(0,0), 0.1)
		#info.visible = 0
