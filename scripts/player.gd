extends CharacterBody2D


@export var SPEED = 700.0
@export var PUSH_INERTIA = 250.0
var current_direction = 0
var is_moving = false

func _physics_process(delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	is_moving = true
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
		is_moving = false
		
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			$push_sound.play()
			collider.apply_central_force(-collision.get_normal() * PUSH_INERTIA)
		
	move_and_slide()
	play_anim()
	
func play_anim():
	var anim = $AnimatedSprite2D
	
	var walk_sound = $walk
	var idle_sound = $idle
	
	if not is_moving:
		if current_direction == 1:
			anim.play("left_idle")
		elif current_direction == 2:
			anim.play("right_idle")
		elif current_direction == 3:
			anim.play("back_idle")
		elif current_direction == 4:
			anim.play("face_idle")
		if $Timer.time_left <= 0:
			walk_sound.play()
	else:
		if current_direction == 1:
			anim.play("left_walk")
		elif current_direction == 2:
			anim.play("right_walk")
		elif current_direction == 3:
			anim.play("back_walk")
		elif current_direction == 4:
			anim.play("face_walk")
		idle_sound.play()
