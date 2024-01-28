extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

const DEFAULT_TEXT = "Mash the 'S' and 'D' keys!"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = DEFAULT_TEXT
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_completion(completion):
	$CompletionLabel.text = str(completion)+"%"

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()


func _on_backbutton_pressed():
	get_tree().change_scene_to_file("res://scenes/menu2.tscn")
