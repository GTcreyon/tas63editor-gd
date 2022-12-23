extends Control

var selected_frames: Array = []
var last_selected: int = -1
var selected_event: Event = null
var unsaved: bool = false

onready var frame_list = $"%InputFrames"
onready var file_dialog = $"%FileDialog"
onready var file_menu = $"%FileDialog/.."


func mark_unsaved(mark: bool = true) -> void:
	if unsaved != mark:
		unsaved = mark
		file_menu.update_window_title()


func set_inputs(keys: Dictionary, mouse_held: bool, mouse_pos: Vector2) -> void:
	$"%KeyU".pressed = keys["U"]
	$"%KeyD".pressed = keys["D"]
	$"%KeyL".pressed = keys["L"]
	$"%KeyR".pressed = keys["R"]
	$"%KeyZ".pressed = keys["Z"]
	$"%KeyX".pressed = keys["X"]
	$"%KeyC".pressed = keys["C"]
	$"%KeyP".pressed = keys["P"]
	$"%KeyS".pressed = keys["S"]
	$"%KeySemi".pressed = keys[";"]
	$"%KeyMinus".pressed = keys["-"]
	$"%KeyPlus".pressed = keys["+"]
	$"%MouseHeld".pressed = mouse_held
	$"%MouseX".value = mouse_pos.x
	$"%MouseY".value = mouse_pos.y


func set_rng(index: String, value: String) -> void:
	$"%EventIndex".text = index
	$"%EventValue".text = value


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
	if Input.is_action_pressed("select_many"):
		var all_frames = frame_list.get_children()
		var end_indexes = [last_selected, frame.get_index()]
		if end_indexes[0] > end_indexes[1]:
			end_indexes.invert()
		for child in all_frames.slice(end_indexes[0] + 1, end_indexes[1] - 1):
			child.pressed = true
			selected_frames.append(child)
		selected_frames.append(all_frames[end_indexes[1]])
	else:
		if !Input.is_action_pressed("select_multi"):
			for frame in selected_frames:
				frame.pressed = false
			selected_frames = []
			set_inputs(frame.keys, frame.mouse_held, frame.mouse_pos)
		selected_frames.append(frame)
		last_selected = frame.get_index()


func select_event(event: Event) -> void:
	if selected_event != null:
		selected_event.pressed = false
	selected_event = event
	set_rng(event.index, event.value)


func set_frame_inputs(_dummy):
	for frame in selected_frames:
		frame.set_input_string()


func set_event_data(_dummy):
	selected_event.set_event_string($"%EventIndex".text, $"%EventValue".text)


func update_after(index: int) -> void:
	var all_frames = frame_list.get_children()
	for child in all_frames.slice(index, all_frames.size()):
		child.update_input_string()
