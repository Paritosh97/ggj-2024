extends Node

var map_scene = load("res://scenes/map1.tscn")
var player_scene = load("res://scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_map = map_scene.instantiate()
	add_child(new_map)
	
	var new_player = player_scene.instantiate()
	new_player.position = new_map.get_node("spawn_position").position
	add_child(new_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
