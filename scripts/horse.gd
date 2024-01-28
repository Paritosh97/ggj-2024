extends CharacterBody2D


@export var SPEED = 50.0
@export var PUSH_INERTIA = 100.0
var current_direction = 0

var horse_side_scene = load("res://scenes/horse_side.tscn")
var horse_back_scene = load("res://scenes/horse_back.tscn")
var horse_face_scene = load("res://scenes/horse_face.tscn")

var horse_side = null
var horse_face = null
var horse_back = null

func _ready():
	horse_side = horse_side_scene.instantiate()
	horse_side.scale = Vector2(0.1, 0.1)
	
	horse_back = horse_back_scene.instantiate()
	horse_back.scale = Vector2(0.1, 0.1)
	
	horse_face = horse_face_scene.instantiate()
	horse_face.scale = Vector2(0.1, 0.1)

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = direction_x * SPEED
		velocity.y = 0
		if direction_x < 0:
			current_direction = 1
		else:
			current_direction = 2
	elif direction_y:
		velocity.y = direction_y * SPEED
		velocity.x = 0
		if direction_y < 0:
			current_direction = 3
		else:
			current_direction = 4
	else:
		velocity.x = 0
		velocity.y = 0
		
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			collider.apply_central_force(-collision.get_normal() * PUSH_INERTIA)
		
	move_and_slide()
	#play_anim()
	
func play_anim():
	var anim = $AnimatedSprite2D
	
	if current_direction == 1:
		add_child(horse_side_scene)
	elif current_direction == 2:
		add_child(horse_side_scene)
	elif current_direction == 3:
		add_child(horse_back_scene)
	elif current_direction == 4:
		add_child(horse_face_scene)
