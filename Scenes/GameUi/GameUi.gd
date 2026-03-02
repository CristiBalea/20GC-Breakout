extends Control


@onready var hbox_container: HBoxContainer = $MarginContainer/HBoxContainer


var _hearts: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.on_missed_ball.connect(on_missed_ball)
	_hearts = hbox_container.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_missed_ball(lives: int) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = lives > index
	if lives <= 0:
		print("restart screen")