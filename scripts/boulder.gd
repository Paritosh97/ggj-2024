extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true
	max_contacts_reported = 10

func _on_body_exited(body):
	if body is CharacterBody2D:
		linear_velocity = Vector2(0, 0)
