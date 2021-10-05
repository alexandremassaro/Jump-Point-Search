extends Node2D

onready var map_size_x_H_Scroll = get_node("CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer/MapSizeXAxis")
onready var map_size_y_H_Scroll = get_node("CanvasLayer/VBoxContainer/HBoxContainer/VBoxContainer2/MapSizeYAxis")

#onready var mapsize := Vector2(map_size_x_H_Scroll.value, map_size_y_H_Scroll.value)

onready var map_size_scroll = get_node("CanvasLayer/VBoxContainer/HBoxContainer2/MapSizeScroll")

var map_size = Vector2(20, 20)


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

