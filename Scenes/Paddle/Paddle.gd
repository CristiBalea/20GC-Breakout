extends CharacterBody2D


class_name Paddle


@onready var sprite2d: Sprite2D = $Sprite2D


const SPEED: float = 500.0


var _paddle_size: int


func _ready() -> void:
	add_to_group(Constants.PADDLE_GROUP)
	_paddle_size = sprite2d.texture.get_width()

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	var screen_viewport: Vector2 = get_viewport().get_visible_rect().size
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	position.x = clampf(position.x, 0,screen_viewport.x)
	position.y = clampf(position.y, 0,screen_viewport.y)
	
	move_and_slide()
