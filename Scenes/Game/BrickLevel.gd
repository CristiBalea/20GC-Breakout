extends Node2D


class_name BrickLevel


@export var columns: int = 10
@export var rows: int = 5
@export var spacing: Vector2 = Vector2(80, 36) # Width and Height of your brick + gap
@export var start_pos: Vector2 = Vector2(75, 50) # Top-left corner of the grid


var Levels: Dictionary[Variant, Variant] = {
	"LevelOne": "level_one",
	"LevelTwo": "level_two",
	"LevelThree": "level_three"
}


var level_one: Dictionary[Variant, Variant] = {
		Constants.BRICK_TEXTURE.GRAY: 5,
		Constants.BRICK_TEXTURE.YELLOW: 30,
		Constants.BRICK_TEXTURE.Green: 65,
		Constants.BRICK_TEXTURE.RED: 0
	}

var level_two: Dictionary[Variant, Variant] = {
		Constants.BRICK_TEXTURE.GRAY: 25,
		Constants.BRICK_TEXTURE.YELLOW: 15,
		Constants.BRICK_TEXTURE.Green: 55,
		Constants.BRICK_TEXTURE.RED: 5
	}
	
var level_three: Dictionary[Variant, Variant] = {
	Constants.BRICK_TEXTURE.GRAY: 25,
	Constants.BRICK_TEXTURE.YELLOW: 15,
	Constants.BRICK_TEXTURE.Green: 40,
	Constants.BRICK_TEXTURE.RED: 20
	}


const brick: PackedScene = preload("res://Scenes/Brick/Brick.tscn")


func _ready() -> void:
	create_level("LevelThree")


func create_level(level: String) -> void:
	var internal_name = Levels[level]
	var weight_data = get(internal_name) 
	
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
			print(type)
			return type
			
	return Constants.BRICK_TEXTURE.YELLOW 
