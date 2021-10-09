extends Node2D

onready var map_size_x_H_Scroll = get_node("CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/MapSizeXAxis")
onready var map_size_y_H_Scroll = get_node("CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer2/MapSizeYAxis")

onready var map_size_scroll = get_node("CanvasLayer/VBoxContainer/HBoxContainer2/MapSizeScroll")

var map_size = Vector2(20, 20)

var jps_search : JPS


func create_jps_grid():
	jps_search = JPS.new()
	
	var grid : Grid = get_node("CanvasLayer/VBoxContainer/HBoxContainer2/CenterContainer/Grid")
	for tile in grid.get_children():
		var new_point := Point.new()
		new_point.position = tile.position_in_grid
		new_point.enabled = tile.type != Tile.TILE_BLOCKED
		new_point.id = int(String(int(tile.position_in_grid.x)) + String(int(tile.position_in_grid.y)))
		
		jps_search.points.append(new_point)
		
	for point in jps_search.points:
		if point.position.x > 0:
			point.cardinal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(-1, 0)))
			if point.position.y > 0:
				point.diagonal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(-1, -1)))
			if point.position.y < map_size.y:
				point.diagonal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(-1, 1)))
		
		if point.position.y > 0:
			point.cardinal_neighbours.append(jps_search.get_point_by_position(point.position - Vector2(0, 1)))
		
		if point.position.x < map_size.x:
			point.cardinal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(1, 0)))
			if point.position.y > 0:
				point.diagonal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(1, -1)))
			if point.position.y < map_size.y:
				point.diagonal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(1, 1)))
		
		if point.position.y < map_size.y:
			point.cardinal_neighbours.append(jps_search.get_point_by_position(point.position + Vector2(0, 1)))
			
		

func _ready():
	calculate_grid()
	map_size_x_H_Scroll.connect("scrolling", self, "calculate_grid")
	map_size_y_H_Scroll.connect("scrolling", self, "calculate_grid")


func calculate_grid():
	map_size.x = map_size_x_H_Scroll.value
	map_size.y = map_size_y_H_Scroll.value
	var grid : Grid = get_node("CanvasLayer/VBoxContainer/HBoxContainer2/CenterContainer/Grid")
	
	grid.size = map_size
	
	if map_size.x >= map_size.y * 1.5:
		grid.tile_size = get_viewport().size.x / map_size.x * 1.1
	else:
		grid.tile_size = get_viewport().size.y / map_size.y * 1.1
	grid.update_grid()

