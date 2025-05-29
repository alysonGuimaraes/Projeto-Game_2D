extends Area2D

const SPEED = 150
var direction = 1

func _physics_process(delta: float) -> void:
	position.x += SPEED * delta * direction


func _on_timer_timeout() -> void:
	pass # Replace with function body.
	

func _on_area_entered(area: Area2D) -> void:
	area.take_damage()
