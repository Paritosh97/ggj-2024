extends Node


@export var no_of_items: int = 500

var items = [load("res://scenes/hat.tscn"), load("res://scenes/key.tscn"), load("res://scenes/tent.tscn")]

var rng = RandomNumberGenerator.new()

func _ready():
	
	for i in range(0, 50/2):
		var random_x1 = rng.randf_range($x1_start.position.x, $x1_end.position.x)
		var random_x2 = rng.randf_range($x2_start.position.x, $x2_end.position.x)
		
		var random_y = rng.randf_range($y_start.position.y, $y_end.position.y)
		
		var random_item_index = rng.randi_range(0, 2)
		
		var item1 = items[random_item_index].instantiate()
		item1.position = Vector2(random_x1, random_y)
		add_child(item1)
		
		random_item_index = rng.randi_range(0, 2)
		
		var item2 = items[random_item_index].instantiate()
		item2.position = Vector2(random_x2, random_y)
		add_child(item2)
	
	# TODO music for winning
	
func _process(delta):
	
	if $player.position.y <= $finish.position.y:
		get_tree().change_scene_to_file("res://scenes/winning_boulder.tscn")
		 
		
