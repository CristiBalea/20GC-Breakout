extends Node2D


@export var ball: Ball


var _can_launch: bool


func _ready() -> void:
	_can_launch = true


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("launch") and _can_launch:
		ball.launch_ball()
		_can_launch = false
