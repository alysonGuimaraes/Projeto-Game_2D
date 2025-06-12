extends Area2D
@export var speed = 10

func _physics_process(delta: float) -> void:
	position.x += 10 * delta
