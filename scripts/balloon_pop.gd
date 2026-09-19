extends Node2D

var target_color = "red"
var target_score = 20
var score = 0
var time_left = 30.0

@onready var score_label: Label = $UI/ScoreLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var target_label: Label = $UI/TargetLabel

@onready var game_timer: Timer = $GameTimer

func _ready():
	target_label.text = "Pop " + target_color.to_upper() + " Balloons!"
	update_ui()

func update_ui():
	score_label.text = "Score: " + str(score)
	timer_label.text = "Time: " + str(time_left)

func _on_game_timer_timeout():
	time_left -= 1
	update_ui()
	
	if time_left <= 0:
		end_game()

func balloon_popped(balloon_color: String):
	if balloon_color == target_color:
		score += 1
	else:
		score -= 1
	
	update_ui()
	
	if score >= target_score:
		win_game()

func win_game():
	game_timer.stop()
	
	target_label.text = "🎉 Congrats!"
	
	print("Player WON!")

func end_game():
	game_timer.stop()
	
	if score >= target_score:
		win_game()
	else:
			target_label.text = "Time's up!"
			print("Player LOST!")
