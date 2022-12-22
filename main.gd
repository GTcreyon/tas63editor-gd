extends Control

var selected_frames: Array = []
var last_selected: Frame = null

onready var frame_list = $"%InputFrames"


func get_keys() -> Dictionary:
	var keys = {}
	keys["U"] = $"%KeyU".pressed
	keys["D"] = $"%KeyD".pressed
	keys["L"] = $"%KeyL".pressed
	keys["R"] = $"%KeyR".pressed
	keys["Z"] = $"%KeyZ".pressed
	keys["X"] = $"%KeyX".pressed
	keys["C"] = $"%KeyC".pressed
	keys["P"] = $"%KeyP".pressed
	keys["S"] = $"%KeyS".pressed
	keys[";"] = $"%KeySemi".pressed
	keys["-"] = $"%KeyMinus".pressed
	keys["+"] = $"%KeyPlus".pressed
	return keys


func get_mouse_held() -> bool:
	return $"%MouseHeld".pressed


func get_mouse_pos() -> Vector2:
	return Vector2($"%MouseX".value, $"%MouseY".value)


func frame_pressed(frame: Frame) -> void:
	if Input.is_action_pressed("shift"):
		var all_frames = frame_list.get_children()
		var end_indexes = [last_selected.get_index(), frame.get_index()]
		if end_indexes[0] > end_indexes[1]:
			end_indexes.invert()
		for child in all_frames.slice(end_indexes[0] + 1, end_indexes[1] - 1):
			child.pressed = true
			selected_frames.append(child)
		selected_frames.append(all_frames[end_indexes[0]])
		selected_frames.append(all_frames[end_indexes[1]])
	else:
		if !Input.is_action_pressed("ctrl"):
			for frame in selected_frames:
				frame.pressed = false
			selected_frames = []
		selected_frames.append(frame)
		last_selected = frame


func set_frame_inputs(button_pressed):
	for frame in selected_frames:
		frame.set_input_string()
