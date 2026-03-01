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
	

func hit() -> void:
	if is_invulnerable:
		return
	initial_health -= 1
	damage_brick()
		


func damage_brick() -> void:
	if initial_health == 2:
		set_brick_texture(brick_color + 1)
	elif initial_health == 1:
		set_brick_texture(brick_color + 2)
	
	if initial_health == 0:
		collision_shape2d.disabled = true
		TweenFX.pop_out(self, 0.1)
		await TweenFX.pop_out(self).finished
		queue_free()


func set_bricks(brick_texture: Constants.BRICK_TEXTURE) -> void:
	match brick_texture:
		Constants.BRICK_TEXTURE.GRAY:
			set_brick_texture(Constants.BRICK_TEXTURE.GRAY)
			is_invulnerable = true
			initial_health = 99
		Constants.BRICK_TEXTURE.YELLOW:
			set_brick_texture(Constants.BRICK_TEXTURE.YELLOW)
			initial_health = 1
		Constants.BRICK_TEXTURE.ORANGE:
			set_brick_texture(Constants.BRICK_TEXTURE.ORANGE)
			initial_health = 2
		Constants.BRICK_TEXTURE.RED:
			set_brick_texture(Constants.BRICK_TEXTURE.RED)
			initial_health = 3			


func set_brick_texture(brick_texture: Constants.BRICK_TEXTURE) -> void:
	sprite2d.frame = brick_texture
