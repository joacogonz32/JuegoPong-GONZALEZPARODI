extends Control

func _ready() -> void:
	$VBoxContainer/BtnEasy.pressed.connect(_on_easy)
	$VBoxContainer/BtnMedium.pressed.connect(_on_medium)
	$VBoxContainer/BtnHard.pressed.connect(_on_hard)
	$VBoxContainer/BtnBack.pressed.connect(_on_back)

func _on_easy() -> void:
	GameState.difficulty = "easy"
	GameState.mode       = "pvc"
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_medium() -> void:
	GameState.difficulty = "medium"
	GameState.mode       = "pvc"
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_hard() -> void:
	GameState.difficulty = "hard"
	GameState.mode       = "pvc"
	get_tree().change_scene_to_file("res://Main.tscn")

func _on_back() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
