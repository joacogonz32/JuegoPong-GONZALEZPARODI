extends CharacterBody2D

@export var speed   : float = 500.0
@export var player  : int   = 1
@export var is_cpu  : bool  = false

const HUD_H       := 50.0
const WALL        := 6.0
const HALF_HEIGHT := 60.0

var ball_ref      : Node2D = null
var ready_to_move : bool   = false
var cpu_speed     : float  = 500.0
# error máximo en píxeles: cuanto más alto, peor apunta la IA
var cpu_error     : float  = 0.0

func start() -> void:
	ready_to_move = true

# Se llama desde Main.gd después de asignar is_cpu y ball_ref
func setup_cpu() -> void:
	match GameState.difficulty:
		"easy":
			cpu_speed = 450.0
			cpu_error = 60.0   # se desvia hasta 60px del centro de la pelota
		"medium":
			cpu_speed = 900.0
			cpu_error = 25.0   # se desvia poco
		"hard":
			cpu_speed = 2700.0
			cpu_error = 0.0    # apunta perfecto al centro

func _physics_process(delta: float) -> void:
	if not ready_to_move:
		return

	var direction := 0.0

	if is_cpu and ball_ref != null:
		# target es donde apunta la IA, con un error aleatorio según dificultad
		var target := ball_ref.position.y + randf_range(-cpu_error, cpu_error)
		if target < position.y - 10:
			direction = -1.0
		elif target > position.y + 10:
			direction = 1.0
	else:
		if player == 1:
			if Input.is_action_pressed("p1_up"):
				direction = -1.0
			elif Input.is_action_pressed("p1_down"):
				direction = 1.0
		else:
			if Input.is_action_pressed("p2_up"):
				direction = -1.0
			elif Input.is_action_pressed("p2_down"):
				direction = 1.0

	var spd := cpu_speed if is_cpu else speed
	velocity.y = direction * spd
	move_and_collide(velocity * delta)

	var sh  := get_viewport_rect().size.y
	var top := HUD_H + WALL + HALF_HEIGHT
	var bot := sh - WALL - HALF_HEIGHT
	position.y = clamp(position.y, top, bot)
