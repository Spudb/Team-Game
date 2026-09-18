extends Node2D

# عشان يبعت للسكربت هناك ان في تارجت اتضرب
var game
var id

# البتاع دي لو عايز تستقبل كليك شمال على area مثلا
func check_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1

# لو جت click فوق الarea بتسمع هنا
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		game.target_hit()
		#print(self)
		#print(self.get_path())
		#print(self.get_parent())
		#self.get_path()
		game.targets_list[id] = 0
		queue_free()
