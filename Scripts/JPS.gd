extends Node
class_name JPS


###
#	This project's goal is to make an implementation of the Jump Point Search
#	algorithm, and test it to confirm if it is a better pathfinding strategy
#	than the standart A* algorithm that comes with Godot.
#	For more information about the JPS algorithm and other pathfinding researches
#	visit it's creator's (Daniel Darabhor) webpage in: 
#	https://users.cecs.anu.edu.au/~dharabor/home.html
###


var points : Array
var iteration : int = 1
var last_free_id = 0

const CARDINAL_COST = 1.0
const DIAGONAL_COST = sqrt(2.0)


func solve(begin_point : Point, end_point : Point):
	iteration += 1
	var found_route := false
	var open_list := []
	
	begin_point.g_score = 0
	begin_point.f_score = estimate_cost(begin_point, end_point)
	open_list.push_back(begin_point)
	
	while not open_list.empty():
		var point : Point = open_list[0]
		
		if point == end_point:
			found_route = true
			break
		
		open_list.remove(open_list.size() - 1)
		point.closed_pass = iteration
		
		for neighbour in point.cardinal_neighbours:
			if (not neighbour.enabled) or neighbour.closed_pass == iteration:
				continue
			
			var tentative_g_score = point.g_score + compute_cost(point, neighbour)
			
			var new_point : bool  = false
			
			if not neighbour in open_list:
				neighbour.open_pass = iteration
				open_list.push_back(neighbour)
				new_point = true
			elif tentative_g_score >= neighbour.g_score:
				continue
			
			neighbour.prev_point = point
			neighbour.g_score = tentative_g_score
			neighbour.f_score = neighbour.g_score + estimate_cost(neighbour, end_point)
	
	return found_route


func estimate_cost(from : Point, to : Point):
#	assert(from in points, "From point not in array")
#	assert(from in points, "To point not in array")
	return from.position.distance_to(to.position)


func get_point_by_id(id : int):
	for point in points:
		if point.id == id:
			return point


func get_point_by_position(position : Vector2):
	for point in points:
		if point.position == position:
			return point

func compute_cost(point : Point, neighbour : Point):
#	assert(neighbour in point.cardinal_neighbours and neighbour in point.diagonal_neighbours, "Not a neighbour of the point")	
	if neighbour in point.cardinal_neighbours:
		return CARDINAL_COST
	if neighbour in point.diagonal_neighbours:
		return DIAGONAL_COST
	return false







