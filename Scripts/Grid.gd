extends GridContainer
class_name Grid

var tile_size := 10.0
var size := Vector2(20, 20)
export (PackedScene) var tile_scene = preload("res://Scenes/Tile.tscn")

var is_moving_initial = false
var is_moving_final = false
var is_clicking_left = false

var mouse_tile : Tile
var main_node : Node2D


func _process(_delta):
	if mouse_tile:
		mouse_tile.rect_position = get_global_mouse_position() + Vector2(20, 20)

	
func update_grid():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	columns = int(size.x)
	
	for x in range(size.x):
		for y in range(size.y):
			var tile = tile_scene.instance()
			tile.position_in_grid = Vector2(x, y)
			if x == 0 and y == 0:
				tile.set_tile_type(Tile.TILE_INITIAL)
			elif x == size.x - 1 and y == size.y - 1:
				tile.set_tile_type(Tile.TILE_FINAL)
				
			tile.rect_min_size = Vector2(tile_size, tile_size)
			tile.rect_size = Vector2(tile_size, tile_size)
			if x % 2:
				if y % 2:
					tile.default_color = Tile.DEFAULT_COLOR1
				else:
					tile.default_color = Tile.DEFAULT_COLOR2
			else:
				if y % 2:
					tile.default_color = Tile.DEFAULT_COLOR2
				else:
					tile.default_color = Tile.DEFAULT_COLOR1
		
			add_child(tile)


func _on_Grid_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			is_clicking_left = true
			for child in get_children():
				if child is Tile:
					if child.mouse_over:
						if is_moving_final and child.type != Tile.TILE_INITIAL:
							is_moving_final = false
							main_node.get_node("MouseGrab").remove_child(mouse_tile)
							mouse_tile.queue_free()
							mouse_tile = null
							child.set_tile_type(Tile.TILE_FINAL)
							
						elif child.type == Tile.TILE_FINAL:
							mouse_tile = child.duplicate()
							mouse_tile.set_tile_type(Tile.TILE_FINAL)
							main_node = get_viewport().get_child(0)
							main_node.get_node("MouseGrab").add_child(mouse_tile)
							child.set_tile_type(Tile.TILE_DEFAULT)
							is_moving_final = true
							
						elif is_moving_initial and child.type != Tile.TILE_FINAL:
							is_moving_initial = false
							main_node.get_node("MouseGrab").remove_child(mouse_tile)
							mouse_tile.queue_free()
							mouse_tile = null
							child.set_tile_type(Tile.TILE_INITIAL)
							
						elif child.type == Tile.TILE_INITIAL:
							mouse_tile = child.duplicate()
							mouse_tile.set_tile_type(Tile.TILE_INITIAL)
							main_node = get_viewport().get_child(0)
							main_node.get_node("MouseGrab").add_child(mouse_tile)
							child.set_tile_type(Tile.TILE_DEFAULT)
							is_moving_initial = true
		elif event.button_index == BUTTON_LEFT and not event.pressed:
			is_clicking_left = false






