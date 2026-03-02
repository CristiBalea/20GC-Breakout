extends Node2D


@export var ball: Ball
@export var paddle: Paddle


func _ready() -> void:
	Signals.on_missed_ball.connect(on_missed_ball)
	

func on_missed_ball(lives: int) -> void:
	ball.prepare_launch_ball()
	paddle.respawn_paddle()
