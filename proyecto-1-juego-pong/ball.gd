extends CharacterBody2D

@export var initial_speed : float = 500.0
const RADIUS          := 10.0
const SPEED_INCREMENT := 50.0
const MAX_SPEED       := 3000.0
const HUD_H           := 50.0
const WALL            := 6.0
const RESET_DELAY     := 1.5

var current_speed : float  = 300.0
var direction     : Vector2 = Vector2.ZERO
var waiting       : bool   = false

signal scored(player: int)

func _ready() -> void:
	_build_circle()
	reset()

func _build_circle() -> void:
	var poly   := $Polygon2D
	var points := PackedVector2Array()
	for i in range(32):
		var angle := (2.0 * PI * i) / 32.0
		points.append(Vector2(cos(angle), sin(angle)) * RADIUS)
	poly.polygon = points
	poly.color   = Color.RED

func reset() -> void:
	var size      := get_viewport_rect().size
	position      = Vector2(size.x / 2, (size.y + HUD_H) / 2)
	direction     = Vector2.ZERO
	waiting       = true
	current_speed = initial_speed
	await get_tree().create_timer(RESET_DELAY).timeout
	waiting   = false
	var angle := randf_range(-PI / 4, PI / 4)
	direction = Vector2(cos(angle), sin(angle))
	if randf() > 0.5:
		direction.x *= -1

func _physics_process(delta: float) -> void:
	if waiting:
		return

	var collision := move_and_collide(direction * current_speed * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
		if collision.get_collider() is CharacterBody2D:
			current_speed = minf(current_speed + SPEED_INCREMENT, MAX_SPEED)

	var size      := get_viewport_rect().size
	var top_limit := HUD_H + WALL + RADIUS
	var bot_limit := size.y - WALL - RADIUS

	if position.y <= top_limit:
		position.y  = top_limit
		direction.y = abs(direction.y)
	elif position.y >= bot_limit:
		position.y  = bot_limit
		direction.y = -abs(direction.y)

	if position.x < 0:
		scored.emit(2)
		reset()
	elif position.x > size.x:
		scored.emit(1)
		reset()
