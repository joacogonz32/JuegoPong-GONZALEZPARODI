extends Control

func _ready() -> void:
	var vp := get_viewport_rect().size
	position = Vector2.ZERO
	size = vp

	$Overlay.position = Vector2.ZERO
	$Overlay.size = vp

	$VBoxContainer.position = Vector2(vp.x / 2 - 190, vp.y / 2 - 80)

	$VBoxContainer/BtnResume.pressed.connect(_on_resume)
	$VBoxContainer/BtnMenu.pressed.connect(_on_menu)

func _on_resume() -> void:
	get_tree().paused = false
	get_parent().is_paused = false
	queue_free()

func _on_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menu.tscn")
