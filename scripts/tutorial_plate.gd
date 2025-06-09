extends Node2D

@onready var sign: Area2D = $sign

@export var text_message: Array[String] = []

func _unhandled_input(event: InputEvent) -> void:
	if sign.get_overlapping_bodies().size() > 0:
		if !DialogManager.is_message_active:
			DialogManager.start_message(global_position, text_message)
			
	else:
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
