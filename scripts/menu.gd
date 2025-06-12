extends Control

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
			call_deferred("load_scene", "scene_outside_house")
		"how_to_play_button":
			call_deferred("load_scene", "screen_how_to_play")
		"credits_button":
			call_deferred("load_scene", "screen_credits")
		"exit_button":
			call_deferred("quit_game")
		"menu_button": 
			call_deferred("load_scene","screen_menu")
		"playAgain_button":
			call_deferred("load_scene", "scene_outside_house")
	

func load_scene(scene):
	get_tree().change_scene_to_file("res://scenes/" + scene + ".tscn")
	

func quit_game() -> void:
	get_tree().quit()
