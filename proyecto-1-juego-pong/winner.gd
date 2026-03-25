extends Control

var winner_player : int = 0

func setup(player: int) -> void:
	winner_player = player

func _ready() -> void:
	var vp := get_viewport_rect().size
	position = Vector2.ZERO
	size = vp

	$Overlay.position = Vector2.ZERO
	$Overlay.size = vp

	$VBoxContainer.position = Vector2(vp.x / 2 - 190, vp.y / 2 - 100)

	var title := $VBoxContainer/Title
	if winner_player == 1:
		title.text = "¡JUGADOR 1 GANÓ!"
	else:
		if GameState.mode == "pvc":
			title.text = "¡LA MÁQUINA GANÓ!"
		else:
			title.text = "¡JUGADOR 2 GANÓ!"

	$VBoxContainer/BtnReplay.pressed.connect(_on_replay)
	$VBoxContainer/BtnMenu.pressed.connect(_on_menu)

func _on_replay() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_menu() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
