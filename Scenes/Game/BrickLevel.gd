extends Node2D


class_name BrickLevel


@export var columns: int = 10
@export var rows: int = 5
@export var spacing: Vector2 = Vector2(80, 36) # Width and Height of your brick + gap
@export var start_pos: Vector2 = Vector2(75, 50) # Top-left corner of the grid


const brick: PackedScene = preload("res://Scenes/Brick/Brick.tscn")


func _ready() -> void:
	create_level()


func create_level() -> void:
	for r in rows:
		for c in columns:
			var new_brick: Brick = brick.instantiate()
			
			var x_pos: float = start_pos.x + (c * spacing.x)
			var y_pos: float = start_pos.y + (r * spacing.y)
			
			new_brick.position = Vector2(x_pos, y_pos)
			new_brick.set_bricks(Constants.BRICK_TEXTURE.YELLOW)
			add_child(new_brick)
