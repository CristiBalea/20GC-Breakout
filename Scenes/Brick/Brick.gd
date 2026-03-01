extends StaticBody2D


@export var health: int = 1



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(Constants.BRICK_GROUP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func die() -> void:
	if health == 0:
		queue_free()