extends Button

onready var main = $"/root/Main"


func _on_RandomEvent_pressed():
	if main.selected_event != null:
		var index = main.selected_event.index
		main.selected_event.set_event_string(main.selected_event.index, str(randi() % 2147483647))
		var value = main.selected_event.value
		main.set_rng(index, value)
		main.mark_unsaved()
