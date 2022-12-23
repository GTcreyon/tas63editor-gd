extends MenuButton

const FRAME_PREFAB = preload("res://frame.tscn")
const EVENT_PREFAB = preload("res://event.tscn")

var current_file = ""

onready var main = $"/root/Main"
onready var frame_list = $"%InputFrames"
onready var event_list = $"%RNGEvents"
onready var file_dialog = $FileDialog


func _ready():
	get_popup().connect("id_pressed", self, "_selected")


func _selected(id):
	match id:
		0: # New
			_clear_frames()
			_clear_events()
			current_file = ""
		1: # Open
			file_dialog.mode = file_dialog.MODE_OPEN_FILE
			file_dialog.popup_centered(Vector2(450, 300))
		2: # Save
			if current_file == "":
				_save_as()
			else:
				_save_file(current_file)
		3: # Save As
			_save_as()


func _save_as() -> void:
	file_dialog.mode = file_dialog.MODE_SAVE_FILE
	file_dialog.popup_centered(Vector2(450, 300))
	


func _clear_frames() -> void:
	main.selected_frames = []
	for child in frame_list.get_children():
		# Explicitly remove child to clear indexes
		frame_list.remove_child(child)
		child.queue_free()


func _clear_events() -> void:
	main.selected_event = null
	for child in event_list.get_children():
		child.queue_free()


func _load_data(content: String) -> void:
	if content.begins_with("{"):
		content = content.substr(content.find("}") + 1)
	var segments = content.split("/")
	var frames = []
	for run in segments[0].split("#"):
		var split = run.split("&")
		var amount
		if split.size() > 1:
			amount = int(split[1]) + 2
		else:
			amount = 1
		for i in range(amount):
			var inst = FRAME_PREFAB.instance()
			frame_list.add_child(inst)
			inst.give_keys(split[0])
			frames.append(inst)
	
	var index = 0
	for run in segments[1].split("#"):
		var split = run.split("&")
		var amount
		if split.size() > 1:
			amount = int(split[1]) + 2
		else:
			amount = 1
		for i in range(amount):
			var mouse = split[0].split("~")
			frames[index].give_mouse(bool(int(mouse[0].substr(0, 1))), Vector2(mouse[0].substr(1), mouse[1]))
			frames[index].update_input_string()
			index += 1
	
	for event in segments[2].split("#"):
		var split = event.split("~")
		var inst = EVENT_PREFAB.instance()
		inst.index = split[0]
		inst.value = split[1]
		event_list.add_child(inst)
		inst.update_event_string()


func _generate_file() -> String:
	var keys = ""
	var mouse = ""
	var rng = ""
	var run_count_key = 0
	var run_count_mouse = 0
	var prev_keys = "*"
	var prev_mouse = "*"
	for frame in frame_list.get_children():
		var key_string = frame.get_key_string(true)
		if key_string == prev_keys:
			run_count_key += 1
		else:
			if prev_keys != "*":
				if run_count_key == 0:
					keys += prev_keys
				else:
					keys += "%s&%d" % [prev_keys, run_count_key - 1]
				keys += "#"
			prev_keys = key_string
			run_count_key = 0
		
		var mouse_string = frame.get_mouse_string(true)
		if mouse_string == prev_mouse:
			run_count_mouse += 1
		else:
			if prev_mouse != "*":
				if run_count_mouse == 0:
					mouse += prev_mouse
				else:
					mouse += "%s&%d" % [prev_mouse, run_count_mouse - 1]
				mouse += "#"
			prev_mouse = mouse_string
			run_count_mouse = 0
	
	if run_count_key == 0:
		keys += prev_keys
	else:
		keys += "%s&%d" % [prev_keys, run_count_key - 1]
	
	if run_count_mouse == 0:
		mouse += prev_mouse
	else:
		mouse += "%s&%d" % [prev_mouse, run_count_mouse - 1]
	
	var first_event = true
	for event in event_list.get_children():
		if first_event:
			first_event = false
		else:
			rng += "#"
		rng += "%s~%s" % [event.index, event.value]
	
	var output = "{2}%s/%s/%s" % [keys, mouse, rng]
	return output


func _on_FileDialog_file_selected(path):
	current_file = path
	match file_dialog.mode:
		file_dialog.MODE_OPEN_FILE:
			var file = File.new()
			file.open(path, File.READ)
			var content = file.get_as_text()
			file.close()
			_clear_frames()
			_clear_events()
			_load_data(content)
		file_dialog.MODE_SAVE_FILE:
			_save_file(path)


func _save_file(path: String) -> void:
	var content = _generate_file()
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(content)
	file.close()
