extends CharacterBody2D


class_name Ball


@export var initial_speed: float = 400.0
@export var speed_multiplier: float = 1.01
@export var paddle: Paddle


var _launch_position: Vector2
var _direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	position = paddle.position + Vector2(0, -30)


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	print(collision)
	if collision:
		# 1. Reflect the velocity based on the surface normal
		# The 'normal' is a vector pointing straight out of the surface hit
		velocity = velocity.bounce(collision.get_normal())
		
		if collision.get_collider().is_in_group(Constants.PADDLE_GROUP):
			handle_paddle_hit(initial_speed)
		
		if collision.get_collider().is_in_group(Constants.BRICK_GROUP):
			pass


func handle_paddle_hit(speed):
	var impact_offset: float = position.x - paddle.position.x
	var ratio = clampf(impact_offset / (paddle._paddle_size / 2), -1, 1)
	velocity = Vector2(ratio, -1.0).normalized() * speed


func launch_ball() -> void:
	_direction.x = [1, -1].pick_random()
	_direction.y = -1
	velocity = _direction.normalized() * initial_speed
