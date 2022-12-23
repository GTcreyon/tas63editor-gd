class_name Event
extends Button

var index = 0
var value = 0

onready var label = $Label
onready var main = $"/root/Main"


func set_event_string(new_index, new_value) -> void:
	index = new_index
	value = new_value
	update_event_string()


func update_event_string() -> void:
	label.text = " %-5s %d" % ["%d:" % index, value]


func _on_Event_button_down():
	main.select_event(self)
