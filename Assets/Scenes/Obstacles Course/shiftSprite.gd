extends Sprite2D
@export var speed: float = -54

func _process(delta: float) -> void:
	region_rect.position.x += speed * delta
	
	if region_rect.position.x >= region_rect.size.x:
		region_rect.position.x = 0.0
