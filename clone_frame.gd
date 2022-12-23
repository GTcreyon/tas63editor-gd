extends Button

const FRAME_PREFAB = preload("res://frame.tscn")

onready var main = $"/root/Main"


func _on_CloneFrame_pressed():
	var end_index = main.selected_frames[main.selected_frames.size() - 1].get_index()
	var i = 0
	for frame in main.selected_frames:
		i += 1
		var inst = FRAME_PREFAB.instance()
		inst.keys = frame.keys
		inst.mouse_held = frame.mouse_held
		inst.mouse_pos = frame.mouse_pos
		main.frame_list.add_child(inst)
		main.frame_list.move_child(inst, end_index + i)
	main.update_after(end_index)
	main.mark_unsaved()
