extends Control

@export var scene_to_load: String
const MOUSE_CURSOR = preload("res://sprites/ui/Mini UI/mouse icons/New Piskel-1.png")
const MOUSE_CLICK = preload("res://sprites/ui/Mini UI/mouse icons/New Piskel-2.png")

func _ready() -> void:
	for _button in get_tree().get_nodes_in_group("Buttons"):
		_button.pressed.connect(_on_button_pressed.bind(_button))
		_button.mouse_entered.connect(_on_button_mouse_entered)
		_button.mouse_exited.connect(_on_button_mouse_exited)
		#print(_button)
		
	Input.set_custom_mouse_cursor(MOUSE_CURSOR, Input.CURSOR_ARROW)
	
func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CLICK, Input.CURSOR_ARROW)
	

func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CURSOR, Input.CURSOR_ARROW)
	

func _on_button_pressed(_button: Button) -> void:
	match _button.name:
		"new_game_button": 
			call_deferred("load_scene", "scene_winter")
		"how_to_play_button":
			call_deferred("load_scene", "screen_how_to_play")
		"credits_button":
			pass
		"exit_button":
			pass
	

func load_scene(scene):
	get_tree().change_scene_to_file("res://scenes/" + scene + ".tscn")
