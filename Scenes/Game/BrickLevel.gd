extends Node2D


class_name BrickLevel


@export var columns: int = 10
@export var rows: int = 5
@export var spacing: Vector2 = Vector2(80, 36) # Width and Height of your brick + gap
@export var start_pos: Vector2 = Vector2(75, 50) # Top-left corner of the grid


var weights_one: Dictionary[Variant, Variant] = {
		Constants.BRICK_TEXTURE.GRAY: 15,
		Constants.BRICK_TEXTURE.YELLOW: 30,
		Constants.BRICK_TEXTURE.Green: 50,
		Constants.BRICK_TEXTURE.RED: 5
	}


const brick: PackedScene = preload("res://Scenes/Brick/Brick.tscn")


func _ready() -> void:
	create_level()


func create_level() -> void:
	for r in rows:
		for c in columns:
			var new_brick: Brick = brick.instantiate()
			
			var x_pos: float = start_pos.x + (c * spacing.x)
			var y_pos: float = start_pos.y + (r * spacing.y)
			
			var random_type: Constants.BRICK_TEXTURE = get_random_brick_type()
			add_child(new_brick)
			new_brick.set_level_one_bricks(random_type, x_pos, y_pos)


func get_random_brick_type() -> Constants.BRICK_TEXTURE:
	var total_weight: int = 0
	for w in weights_one.values():
		total_weight += w
	
	var roll: int = randi() % total_weight + 1
	var cursor: int = 0
	
	for type in weights_one:
		cursor += weights_one[type]
		if roll < cursor:
			print(type)
			return type
			
	return Constants.BRICK_TEXTURE.YELLOW # Fallback
