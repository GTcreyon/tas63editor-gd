class_name Frame
extends Button

onready var label = $Label
onready var main = $"/root/Main"

var keys = {
	"U": false,
	"D": false,
	"L": false,
	"R": false,
	"Z": false,
	"X": false,
	"C": false,
	"P": false,
	"S": false,
	";": false,
	"-": false,
	"+": false,
}

var mouse_held: bool = false
var mouse_pos: Vector2


func _ready() -> void:
	set_input_string()


func set_input_string() -> void:
	set_key_string()
	set_mouse_string()
	label.text = "%-5s %s %d~%03d~%03d" % ["%d:" % get_index(), _get_key_string(), int(mouse_held), mouse_pos.x, mouse_pos.y]


func set_key_string() -> void:
	keys = main.get_keys()


func set_mouse_string() -> void:
	mouse_held = main.get_mouse_held()
	mouse_pos = main.get_mouse_pos()


func _get_key_string() -> String:
	var output = ""
	for key in keys:
		if keys[key]:
			output += key
		else:
			output += "_"
	return output


func _on_Frame_button_down():
	main.frame_pressed(self)
