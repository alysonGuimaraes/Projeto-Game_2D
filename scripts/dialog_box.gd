extends MarginContainer

@onready var text_label: Label = $label_margin/text_label

const MAX_WIDTH = 256

var text = ""
var letter_index = 0

func display_text(text_to_display: String):
	text = text_to_display
	text_label.text = text_to_display
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	
	await resized
	
