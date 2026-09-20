extends Node2D

var target_color = "red"
var target_score = 20
var score = 0
var time_left = 30
var game_active = true

@onready var score_label: Label = $UI/ScoreLabel
@onready var timer_label: Label = $UI/TimerLabel
@onready var target_label: Label = $UI/TargetLabel
@onready var spawn_timer: Timer = $BalloonSpawner/SpawnTimer
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
		end_game(false)

func balloon_popped(balloon_color: String):
	if not game_active:
		return
	score += 1 if balloon_color == target_color else -1
	update_ui()
	if score >= target_score:
		end_game(true)
	
func end_game(won: bool):
	game_active = false
	game_timer.stop()
	spawn_timer.stop()
	target_label.text = "🎉 Congrats!" if won else "Time's up!"
	print("Player WON!" if won else "Player LOST!")
