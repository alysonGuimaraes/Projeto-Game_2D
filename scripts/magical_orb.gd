extends Area2D
@onready var magical_orb: Area2D = $"."
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D



var speed = 150
var direction = 1

func _process(delta: float) -> void:
	position.x += speed * delta * direction


func set_direction(dir):
	direction = dir	
	

func _on_timer_timeout() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	area.take_damage()
	queue_free()
