extends Node

#@export var mob_scene: PackedScene$
@export var mashLimit = 210 #mash input limit (by default 210 input)
@export var timeLimit = 35 #time limit (in sec) to complete the mashing challenge

var completion = 0
var inputCount = 0
var gameOn = false

var keys = ["S", "D"]
var nextKey = keys[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	$Music_intensity1.play()
	$Zebra1.show()
	$Zebra2.show()
	$Zebra3.show()
	$Zebra4.show()
	$Zebra5.show()
	$Zebra6.show()
	$Zebra7.show()
	$Zebra8.show()
	$Zebra9.show()
	$Zebra10.show()
	
	$Zebra11.show()
	$Zebra12.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gameOn :
		if Input.is_action_pressed("o_press") && nextKey == keys[0] && !Input.is_action_pressed("p_press") :
			inputCount += 1
			nextKey = keys[1]
		if Input.is_action_pressed("p_press") && nextKey == keys[1] && !Input.is_action_pressed("o_press") :
			inputCount += 1
			nextKey = keys[0]
		
		var timeCompletion = (timeLimit - $GameTimer.get_time_left())*100/timeLimit
		if(timeCompletion > 0 && timeCompletion < 33):
			$strongman.play("poseDown")
		elif(timeCompletion >= 33 && timeCompletion <= 66):
			$strongman.play("poseMid")
		elif(timeCompletion > 66 && timeCompletion <= 80):
			$strongman.play("poseUp")
		elif(timeCompletion > 99):
			$strongman.play("poseSuccess")
			
		completion = 100*(inputCount)/mashLimit
		if(completion >= 0  && completion < 33):	
			$horse.play("poseDown")
		elif(completion >= 33 && completion <= 66):
			var musicTime = $Music_intensity1.get_playback_position()
			$Music_intensity2.play(musicTime)
		elif(completion > 66):
			$horse.play("poseUp")
			var musicTime = $Music_intensity2.get_playback_position()
			$Music_intensity3.play(musicTime)
		
		if(completion >= 100):
			game_over(true)
		
		$HUD.update_completion(completion)
		

func game_over(win):
	$HUD.show_game_over()
	if win :
		$HUD.show_message("Success !")
		
	gameOn = false;
	$HUD.update_completion(0)
	$WaitTimer.start()

func new_game():
	$Music_intensity2.stop()
	$Music_intensity3.stop()
	$Music_intensity1.play()
	completion = 0
	inputCount = 0
	nextKey = keys[0]
	gameOn = true
	$HUD.show_message("Get Ready")
	$StartTimer.start()
	$HUD.update_completion(completion)

func _on_game_timer_timeout():
	game_over(false)

func _on_start_timer_timeout():
	$GameTimer.set_wait_time(timeLimit)
	$GameTimer.start()
	$HUD.show_message("")


func _on_wait_timer_timeout():
	new_game()
