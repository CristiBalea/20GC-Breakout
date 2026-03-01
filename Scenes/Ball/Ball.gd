extends CharacterBody2D


class_name Ball


@export var initial_speed: float = 400.0
@export var speed_multiplier: float = 1.01
@export var max_speed: float = 650.0
@export var paddle: Paddle


var _launch_position: Vector2
var _direction: Vector2 = Vector2.ZERO

var _can_increase_speed: bool = false

func _ready() -> void:
	position = paddle.position + Vector2(0, -30)


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var collider: Object = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
		var current_speed: float = velocity.length()
		
		print(current_speed)
		if _can_increase_speed:
			current_speed = clampf(current_speed * speed_multiplier, initial_speed, max_speed)
			velocity *= speed_multiplier
			_can_increase_speed = false
		
		# 3. Apply the speed back to the direction
		velocity = velocity.normalized() * current_speed
			
		if collider.is_in_group(Constants.PADDLE_GROUP):
			handle_paddle_hit(current_speed)
		
		if collider.is_in_group(Constants.BRICK_GROUP):
			if collider.has_method("hit"):
				collider.hit()
			_can_increase_speed = true

func handle_paddle_hit(speed: float) -> void:
	var impact_offset: float = position.x - paddle.position.x
	var ratio: float = clampf(impact_offset / (paddle._paddle_size / 2.0), -1.0, 1.0)
	
	# We create the new direction
	var new_dir: Vector2 = Vector2(ratio, -1.0).normalized()
	
	# SAFETY: Ensure the ball always has at least a 0.3 upward 'push'
	# This prevents the ball from going perfectly horizontal
	if abs(new_dir.y) < 0.3:
		new_dir.y = -0.3
		new_dir = new_dir.normalized()
	
	velocity = new_dir * speed

func launch_ball() -> void:
	_direction.x = [1, -1].pick_random()
	_direction.y = -1
	velocity = _direction.normalized() * initial_speed
