extends Control


@export var score_manager: ScoreManager


@onready var current_s_core_label: Label = $MarginContainer/HBoxContainer/CurrentSCoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.on_missed_ball.connect(on_missed_ball)
	hide()


func on_missed_ball(lives: int) -> void:
	if lives <= 0:
		current_s_core_label.text = "%d" % score_manager._score
		show()


func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")
	hide()
