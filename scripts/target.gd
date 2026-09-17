extends Node2D



# البتاع دي لو عايز تستقبل كليك شمال على area مثلا
func check_click(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return 1

# لو جت click فوق الarea بتسمع هنا
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if check_click(event):
		queue_free()
