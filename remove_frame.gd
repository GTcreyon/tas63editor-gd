extends Button

onready var main = $"/root/Main"


func _on_RemoveFrame_pressed():
	var min_index = INF
	for frame in main.selected_frames:
		min_index = min(frame.get_index(), min_index)
		main.frame_list.remove_child(frame)
		frame.queue_free()
	main.selected_frames = []
	main.update_after(min_index)
	main.mark_unsaved()
