extends Node


signal on_missed_ball(lives: int)
signal on_brick_destroyed(points: int)
signal on_game_completed


func emit_on_brick_destroyed(points: int) -> void:
	on_brick_destroyed.emit(points)
	

func emit_on_game_completed()-> void:
	on_game_completed.emit()