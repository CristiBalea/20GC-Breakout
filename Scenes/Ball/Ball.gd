extends CharacterBody2D


class_name Ball

@export var initial_speed: float = 400.0
@export var speed_multiplier: float = 1.01
@export var max_speed: float = 650.0
@export var paddle: Paddle

var _remaining_balls: int = 3
var _y_offset: float = -30.0 
var _is_active: bool = false
var _can_increase_speed: bool = false
var _can_launch: bool = false


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("launch") and _can_launch:
		prepare_launch_ball()
		_can_launch = false 


func _ready() -> void:
	position = paddle.position + Vector2(0, -30)
	_is_active = false
	_can_launch = true

func _physics_process(delta: float) -> void:
	if not _is_active:
		global_position.x = paddle.global_position.x
		global_position.y = paddle.global_position.y + _y_offset
		return
	
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var collider: Object = collision.get_collider()
		velocity = velocity.bounce(collision.get_normal())
		var current_speed: float = velocity.length()
		
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
	var new_dir: Vector2 = Vector2(ratio, -1.0).normalized()
	
	velocity = new_dir * speed


func prepare_launch_ball() -> void:
	if _is_active: 
		return 
	_is_active = true
	velocity = Vector2.UP * initial_speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	_remaining_balls -= 1
	Signals.on_missed_ball.emit(_remaining_balls)
	_is_active = false
	_can_launch = true
	if _remaining_balls < 0:
		get_tree().paused = true
