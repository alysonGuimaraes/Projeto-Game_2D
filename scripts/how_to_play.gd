extends Control

const MOUSE_CURSOR = preload("res://sprites/ui/Mini UI/mouse icons/New Piskel-1.png")
const MOUSE_CLICK = preload("res://sprites/ui/Mini UI/mouse icons/New Piskel-2.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CURSOR, Input.CURSOR_ARROW)


func _on_back_button_pressed() -> void:
	call_deferred("load_scene", "Screen_menu")
	
func load_scene(scene):
	get_tree().change_scene_to_file("res://scenes/" + scene + ".tscn")
	

func _on_back_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CLICK, Input.CURSOR_ARROW)
	

func _on_back_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CURSOR, Input.CURSOR_ARROW)
	
