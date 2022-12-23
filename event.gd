class_name Event
extends Button

var index: String = "0"
var value: String = "0"

onready var label = $Label
onready var main = $"/root/Main"


func set_event_string(new_index: String, new_value: String) -> void:
	index = new_index
	value = new_value
	main.mark_unsaved()
	update_event_string()


func update_event_string() -> void:
	label.text = " %-5s %s" % ["%s:" % index, value]


func _on_Event_button_down():
	main.select_event(self)
