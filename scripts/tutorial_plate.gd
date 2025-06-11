extends Node2D

@export var text_message: Array[String] = []

func _unhandled_input(event: InputEvent) -> void:
	var found = false
	for area in get_tree().get_nodes_in_group("signs"):
		var node = area.get_parent()
		if area is Area2D and area.get_overlapping_bodies().size() > 0:
			found = true
			if !DialogManager.is_message_active:
				DialogManager.start_message(area.global_position, node.text_message)	
	
	if !found and DialogManager.dialog_box != null:
		DialogManager.dialog_box.queue_free()
		DialogManager.is_message_active = false
