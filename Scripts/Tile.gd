extends ColorRect
class_name Tile

enum {TILE_DEFAULT, TILE_INITIAL, TILE_FINAL, TILE_BLOCKED}

var mouse_over = false
var type = TILE_DEFAULT
var position_in_grid : Vector2
var default_color : Color

const DEFAULT_COLOR1 = Color.gray
const DEFAULT_COLOR2 = Color.lightgray
const MOUSE_OVER_COLOR = Color(1.0, 0.0, 0.0, 0.98)
const NOT_MOUSE_OVER_COLOR = Color.white
const IS_INITIAL_COLOR = Color.green
const IS_FINAL_COLOR = Color.orange
const IS_BLOCKED_COLOR = Color(0.0, 0.0, 0.0, 0.5)


func _ready():
	set_tile_color()


func set_tile_type(tile_type):
	type = tile_type
	set_tile_color()


func set_tile_color():
	if mouse_over:
		modulate = MOUSE_OVER_COLOR
	else:
		modulate = NOT_MOUSE_OVER_COLOR

	match type:
		TILE_DEFAULT:
			color = default_color
		TILE_INITIAL:
			color = IS_INITIAL_COLOR
		TILE_FINAL:
			color = IS_FINAL_COLOR
		TILE_BLOCKED:
			color = IS_BLOCKED_COLOR


func _on_Tile_mouse_entered():
	mouse_over = true
	set_tile_color()


func _on_Tile_mouse_exited():
	mouse_over = false
	set_tile_color()


func _on_Tile_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			match type:
				TILE_DEFAULT:
					set_tile_type(TILE_BLOCKED)
				TILE_BLOCKED:
					set_tile_type(TILE_DEFAULT)
				TILE_FINAL:
					return
				TILE_INITIAL:
					return

#			set_tile_color()
