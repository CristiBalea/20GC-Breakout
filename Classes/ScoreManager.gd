extends Node


class_name ScoreManager


var _score: int = 0


func _ready() -> void:
	Signals.on_brick_destroyed.connect(on_brick_destroyed)
	
	
func on_brick_destroyed(points: int) -> void:
	_score += points
