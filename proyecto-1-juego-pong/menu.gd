extends Control

func _ready() -> void:
	$VBoxContainer/BtnPvP.pressed.connect(_on_pvp)
	$VBoxContainer/BtnPvC.pressed.connect(_on_pvc)
	$VBoxContainer/BtnQuit.pressed.connect(_on_quit)
	$VBoxContainer/GoalsContainer/Btn3.pressed.connect(func(): _set_goals(3))
	$VBoxContainer/GoalsContainer/Btn5.pressed.connect(func(): _set_goals(5))
	$VBoxContainer/GoalsContainer/Btn10.pressed.connect(func(): _set_goals(10))
	_update_goal_buttons()

func _set_goals(n: int) -> void:
	GameState.max_goals = n
	_update_goal_buttons()

func _update_goal_buttons() -> void:
	# Resalta el botón seleccionado
	for btn in [$VBoxContainer/GoalsContainer/Btn3,
				$VBoxContainer/GoalsContainer/Btn5,
				$VBoxContainer/GoalsContainer/Btn10]:
		btn.modulate = Color.WHITE
	match GameState.max_goals:
		3:  $VBoxContainer/GoalsContainer/Btn3.modulate  = Color.YELLOW
		5:  $VBoxContainer/GoalsContainer/Btn5.modulate  = Color.YELLOW
		10: $VBoxContainer/GoalsContainer/Btn10.modulate = Color.YELLOW

func _on_pvp() -> void:
	GameState.mode = "pvp"
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_pvc() -> void:
	get_tree().change_scene_to_file("res://Difficulty.tscn")

func _on_quit() -> void:
	get_tree().quit()
