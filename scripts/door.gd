extends Node2D

@onready var icon: Sprite2D = $icon

func _ready() -> void:
	icon.visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	icon.visible = true
	

func _on_area_2d_area_exited(area: Area2D) -> void:
	icon.visible = false
