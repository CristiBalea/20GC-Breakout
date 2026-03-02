extends Node


signal on_missed_ball(lives: int)
signal on_brick_destroyed(points: int)


func emit_on_brick_destroyed(points: int) -> void:
	on_brick_destroyed.emit(points)