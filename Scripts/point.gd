extends Node
class_name Point

var id : int = 0
var pos : Vector2
var weight_scale : float = 0.0
var enabled : bool = false

var cardinal_neighbours : Array
var diagonal_neighbours : Array

var prev_point : Point
var g_score : float = 0.0
var f_score : float = 0.0
var open_pass : int = 0
var closed_pass : int = 0


class PointSorter:
	static func compare(a : Point, b : Point):
		if a.f_score > b.f_score:
			return true
		elif a.f_score < b.f_score:
			return false
		else:
			return a.g_score < b.g_score
	
	static func get_sorted_points(points : Array):
		return points.sort_custom(PointSorter, "compare")
