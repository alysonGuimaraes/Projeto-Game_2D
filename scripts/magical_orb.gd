extends Area2D

const SPEED = 150
var direction = 1

func _physics_process(delta: float) -> void:
	position.x += SPEED * delta * direction
