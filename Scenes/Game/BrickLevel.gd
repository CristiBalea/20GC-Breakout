extends Node2D


class_name BrickLevel


@export var difficulty_level: String = "hard"
@export var columns: int = 10
@export var rows: int = 5
@export var spacing: Vector2 = Vector2(80, 36) # Width and Height of your brick + gap
@export var start_pos: Vector2 = Vector2(75, 50) # Top-left corner of the grid

const brick: PackedScene = preload("res://Scenes/Brick/Brick.tscn")

var easy: Dictionary[Variant, Variant] = {
		Constants.BRICK_TEXTURE.GRAY: 5,
		Constants.BRICK_TEXTURE.YELLOW: 30,
		Constants.BRICK_TEXTURE.Green: 60,
		Constants.BRICK_TEXTURE.RED: 5
	}
var medium: Dictionary[Variant, Variant] = {
		Constants.BRICK_TEXTURE.GRAY: 10,
		Constants.BRICK_TEXTURE.YELLOW: 30,
		Constants.BRICK_TEXTURE.Green: 50,
		Constants.BRICK_TEXTURE.RED: 10
	}
var hard: Dictionary[Variant, Variant] = {
	Constants.BRICK_TEXTURE.GRAY: 25,
	Constants.BRICK_TEXTURE.YELLOW: 15,
	Constants.BRICK_TEXTURE.Green: 40,
	Constants.BRICK_TEXTURE.RED: 20
	}
	
var _bricks_ammount: Array


func _ready() -> void:
	create_level(difficulty_level)

func _process(_delta: float) -> void:
	_bricks_ammount = get_tree().get_nodes_in_group(Constants.BRICK_GROUP)
	if _bricks_ammount.size() == 0:
		Signals.emit_on_game_completed()
	
func create_level(level: String) -> void:
	var weight_data = get(level) 
	
	if weight_data is Dictionary:
		generate_blocks(weight_data)


func generate_blocks(weight_data: Dictionary) -> void:
	for r in rows:
		for c in columns:
			var new_brick: Brick = brick.instantiate()
			var brick_type: Constants.BRICK_TEXTURE = get_random_brick_type(weight_data)
			var x_pos: float = start_pos.x + (c * spacing.x)
			var y_pos: float = start_pos.y + (r * spacing.y)
			
			add_child(new_brick)
			new_brick.set_level_one_bricks(brick_type, x_pos, y_pos)


func get_random_brick_type(weight_dict: Dictionary) -> Constants.BRICK_TEXTURE:
	var total_weight: int = 0
	for w in weight_dict.values():
		total_weight += w
	
	var roll: int = randi() % total_weight + 1
	var cursor: int = 0
	
	for type in weight_dict:
		cursor += weight_dict[type]
		if roll < cursor:
			return type
			
	return Constants.BRICK_TEXTURE.YELLOW 
