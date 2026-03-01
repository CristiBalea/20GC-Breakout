extends StaticBody2D


class_name Brick


@export var initial_health: int = 1
@export var is_invulnerable: bool = false
@export var brick_color: int = 3

@onready var collision_shape2d: CollisionShape2D = $CollisionShape2D
@onready var sprite2d: Sprite2D = $Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Constants.BRICK_GROUP)
	set_brick_texture(brick_color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func hit() -> void:
	if is_invulnerable:
		return
	initial_health -= 1
	damage_brick()
		


func damage_brick() -> void:
	if initial_health == 0:
			collision_shape2d.set_deferred("disabled", true)
			TweenFX.pop_out(self, 0.1)
			await TweenFX.pop_out(self).finished
			queue_free()
	brick_color += 1
	set_brick_texture(brick_color)


func set_level_one_bricks(brick_texture: Constants.BRICK_TEXTURE, pos_x: float, pos_y: float) -> void:
	position = Vector2(pos_x, pos_y)
	brick_color = brick_texture
	match brick_texture:
		Constants.BRICK_TEXTURE.GRAY:
			is_invulnerable = true
			initial_health = 99
		Constants.BRICK_TEXTURE.YELLOW:
			initial_health = 1
		Constants.BRICK_TEXTURE.Green:
			initial_health = 2
		Constants.BRICK_TEXTURE.RED:
			initial_health = 3

	if is_node_ready():
		set_brick_texture(brick_color)

func set_brick_texture(brick_texture: int) -> void:
	brick_color = brick_texture
	sprite2d.frame = brick_texture
