extends Control


@export var score_manager: ScoreManager
@export var brick_level: BrickLevel


@onready var hbox_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var score_label: Label = $MarginContainer/HBoxContainer2/ScoreLabel
@onready var vbox_container: VBoxContainer = $MarginContainer/VBoxContainer


var _hearts: Array

func _ready() -> void:
	Signals.on_brick_destroyed.connect(on_brick_destroyed)
	Signals.on_missed_ball.connect(on_missed_ball)
	Signals.on_game_completed.connect(on_game_completed)
	_hearts = hbox_container.get_children()
	vbox_container.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_game_completed() -> void:
	vbox_container.show()
	get_tree().paused = true


func on_missed_ball(lives: int) -> void:
	if lives <= 0:
		get_tree().paused = true
		
	for index in range(_hearts.size()):
		_hearts[index].visible = lives > index
	

func on_brick_destroyed(points: int) -> void:
	score_label.text = "Score: %d" % score_manager._score
