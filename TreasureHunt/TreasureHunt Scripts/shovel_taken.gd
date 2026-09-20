extends Label

func show_notification():
	var tween = create_tween()
	text = "Shovel Found"
	modulate.a = 0
	tween.tween_property(self, "modulate:a", 1.0, 0.4)\
	.set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, 0.6)\
	.set_trans(Tween.TRANS_SINE)\
	.set_ease(Tween.EASE_IN)
