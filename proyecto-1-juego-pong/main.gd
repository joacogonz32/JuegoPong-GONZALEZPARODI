extends Node2D

@onready var ball     = $Ball
@onready var paddle1  = $Paddle
@onready var paddle2  = $Paddle2
@onready var score_p1 : Label = $UI/HBoxContainer/ScoreP1
@onready var score_p2 : Label = $UI/HBoxContainer/ScoreP2

var score        := {1: 0, 2: 0}
var pause_scene  := preload("res://Pause.tscn")
var goal_scene   := preload("res://Goal.tscn")
var winner_scene := preload("res://Winner.tscn")
var is_paused    := false
var game_over    := false

func _ready() -> void:
	var size := get_viewport_rect().size
	paddle1.position = Vector2(40, size.y / 2)
	paddle2.position = Vector2(size.x - 40, size.y / 2)
	paddle1.start()
	paddle2.start()
	ball.scored.connect(_on_scored)
	if GameState.mode == "pvc":
		paddle2.is_cpu   = true
		paddle2.ball_ref = ball
		paddle2.setup_cpu()

func reset_paddles() -> void:
	var size := get_viewport_rect().size
	paddle1.position = Vector2(40, size.y / 2)
	paddle2.position = Vector2(size.x - 40, size.y / 2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not game_over:
		if is_paused:
			return
		is_paused = true
		get_tree().paused = true
		var pause_menu := pause_scene.instantiate()
		pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS
		add_child(pause_menu)

func _on_scored(player: int) -> void:
	if game_over:
		return
	score[player] += 1
	score_p1.text = str(score[1])
	score_p2.text = str(score[2])
	reset_paddles()

	if score[player] >= GameState.max_goals:
		game_over = true
		ball.set_physics_process(false)
		paddle1.set_physics_process(false)
		paddle2.set_physics_process(false)
		var goal_overlay := goal_scene.instantiate()
		goal_overlay.process_mode = Node.PROCESS_MODE_ALWAYS
		add_child(goal_overlay)
		await get_tree().create_timer(1.6).timeout
		var winner_overlay := winner_scene.instantiate()
		winner_overlay.process_mode = Node.PROCESS_MODE_ALWAYS
		winner_overlay.setup(player)
		add_child(winner_overlay)
	else:
		var goal_overlay := goal_scene.instantiate()
		goal_overlay.process_mode = Node.PROCESS_MODE_ALWAYS
		add_child(goal_overlay)
