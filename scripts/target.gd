extends Node2D

# عشان يبعت للسكربت هناك ان في تارجت اتضرب
var game
var id

# البتاع دي لو عايز تستقبل كليك شمال على area مثلا
func check_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.3)
	tween.tween_property(self, "scale", Vector2(1,1), 0.1) 
	 

# لو جت click فوق الarea بتسمع هنا
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		game.target_hit()
		#print(self)
		#print(self.get_path())
		#print(self.get_parent())
		#self.get_path()
		game.current_targets -= 1
		game.targets_list[id] = 0
		$Area2D/CollisionShape2D.set_deferred("disabled", 1)
		$hit.visible = 1
		await get_tree().create_timer(0.05).timeout
		$skins.visible = 0
		
		$hit.visible = 0
		$Label.visible = 1
		await get_tree().create_timer(1).timeout
		var tween = create_tween()
		tween.tween_property(self, "modulate:a", 0, 0.2)
		await get_tree().create_timer(0.3).timeout
		
		
		queue_free()
