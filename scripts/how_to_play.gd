extends Control

const MOUSE_CURSOR = preload("res://sprites/ui/Mini UI/mouse icons/New Piskel-1.png")
const MOUSE_CLICK = preload("res://sprites/ui/Mini UI/mouse icons/New Piskel-2.png")

func _ready() -> void:
	var button = get_tree().get_first_node_in_group("Button")
	button.pressed.connect(_on_button_pressed.bind(button))
	button.mouse_entered.connect(_on_button_mouse_entered)
	button.mouse_exited.connect(_on_button_mouse_exited)
	
	Input.set_custom_mouse_cursor(MOUSE_CURSOR, Input.CURSOR_ARROW)


func _on_button_pressed(_button: Button) -> void:
	call_deferred("load_scene", "screen_menu")
	

func load_scene(scene):
	get_tree().change_scene_to_file("res://scenes/" + scene + ".tscn")
	

func _on_button_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CLICK, Input.CURSOR_ARROW)
	

func _on_button_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(MOUSE_CURSOR, Input.CURSOR_ARROW)
	
