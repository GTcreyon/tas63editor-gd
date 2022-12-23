extends Button

onready var main = $"/root/Main"


func _on_RemoveEvent_pressed():
	if main.selected_event != null:
		main.selected_event.queue_free()
		main.selected_event = null
		main.mark_unsaved()
