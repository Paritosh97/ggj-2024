extends CharacterBody2D


const SPEED = 300.0
var current_direction = 0

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
		
	move_and_slide()
	play_anim()
	
func play_anim():
	var anim = $AnimatedSprite2D
	
	if current_direction == 1:
		anim.play("left")
	elif current_direction == 2:
		anim.play("right")
	elif current_direction == 3:
		anim.play("up")
	elif current_direction == 4:
		anim.play("down")
