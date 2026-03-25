extends Control

func _ready() -> void:
	var vp := get_viewport_rect().size
	# Hacemos que el Control ocupe toda la pantalla manualmente
	position = Vector2.ZERO
	custom_minimum_size = vp
	size = vp
	
	# Centramos el label
	var label := $Label
	label.size = vp
	label.position = Vector2.ZERO
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment   = VERTICAL_ALIGNMENT_CENTER
	
	await get_tree().create_timer(1.5).timeout
	queue_free()
