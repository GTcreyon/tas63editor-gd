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


func give_keys(keystring: String) -> void:
	for key in keystring:
		keys[key] = true


func give_mouse(held: bool, pos: Vector2) -> void:
	mouse_held = held
	mouse_pos = pos


func set_input_string() -> void:
	set_key_string()
	set_mouse_string()
	update_input_string()


func update_input_string() -> void:
	label.text = " %-5s %s %s" % ["%d:" % get_index(), get_key_string(), get_mouse_string()]


func set_key_string() -> void:
	keys = main.get_keys()


func set_mouse_string() -> void:
	mouse_held = main.get_mouse_held()
	mouse_pos = main.get_mouse_pos()


func get_key_string(stripped: bool = false) -> String:
	var output = ""
	for key in keys:
		if keys[key]:
			output += key
		elif !stripped:
			output += "_"
	return output


func get_mouse_string(stripped: bool = false) -> String:
	if stripped:
		return "%d%d~%d" % [int(mouse_held), mouse_pos.x, mouse_pos.y]
	return "%d~%03d~%03d" % [int(mouse_held), mouse_pos.x, mouse_pos.y]


func _on_Frame_button_down():
	main.frame_pressed(self)
