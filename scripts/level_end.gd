extends Area2D

var next_level = ""

var can_change_level = false

enum levels {
	TUTORIAL,
	FIRST_LEVEL,
	SECOND_LEVEL,
	THIRD_LEVEL
}

@export var current_level: levels


func _on_body_entered(body: Node2D) -> void:
	
	#print("vamos..")
	
	can_change_level = true
	
	match current_level:
		levels.TUTORIAL: next_level = 'scene_tropic'
		levels.FIRST_LEVEL: next_level = 'scene_winter'
		levels.SECOND_LEVEL: next_level = 'jogo'
		levels.THIRD_LEVEL: next_level = 'screen_finished'
		
func _on_body_exited(body: Node2D) -> void:
	can_change_level = false
	
func _unhandled_input(event: InputEvent) -> void:
	if can_change_level and event.is_action_pressed("action"):
		load_next_scene()
	
func load_next_scene():
	get_tree().change_scene_to_file("res://scenes/"+ next_level + ".tscn")
