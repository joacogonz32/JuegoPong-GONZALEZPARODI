extends Node2D

const HUD_H  := 50.0
const WALL   := 6.0
const LINE_W := 4.0
const AREA_W := 180.0

var sw : float
var sh : float

func _ready() -> void:
	var size := get_viewport_rect().size
	sw = size.x
	sh = size.y

func _draw() -> void:
	var white  := Color.WHITE
	var dimmed := Color(1, 1, 1, 0.15)

	draw_rect(Rect2(0, 0, sw, sh), Color.BLACK)
	draw_rect(Rect2(0, HUD_H, sw, WALL), white)
	draw_rect(Rect2(0, sh - WALL, sw, WALL), white)

	draw_rect(Rect2(0, HUD_H + WALL, AREA_W, sh - HUD_H - WALL * 2), dimmed)
	draw_rect(Rect2(AREA_W, HUD_H + WALL, LINE_W, sh - HUD_H - WALL * 2), white)

	draw_rect(Rect2(sw - AREA_W, HUD_H + WALL, AREA_W, sh - HUD_H - WALL * 2), dimmed)
	draw_rect(Rect2(sw - AREA_W - LINE_W, HUD_H + WALL, LINE_W, sh - HUD_H - WALL * 2), white)

	var center_x := sw / 2 - LINE_W / 2
	var y        := HUD_H + WALL + 14.0
	while y < sh - WALL:
		var h := minf(20.0, sh - WALL - y)
		draw_rect(Rect2(center_x, y, LINE_W, h), white)
		y += 34.0

	draw_arc(Vector2(sw / 2, (sh + HUD_H) / 2), 60.0, 0, TAU, 64, white, LINE_W)
