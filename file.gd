extends MenuButton

const FRAME_PREFAB = preload("res://frame.tscn")

onready var frame_list = $"%InputFrames"
onready var file_dialog = $FileDialog


func _ready():
	get_popup().connect("id_pressed", self, "_selected")


func _selected(id):
	match id:
		0: # New
			_clear_frames()
		1: # Open
			file_dialog.mode = file_dialog.MODE_OPEN_FILE
			file_dialog.popup_centered(Vector2(450, 300))
		2: # Save
			file_dialog.mode = file_dialog.MODE_SAVE_FILE
			file_dialog.popup_centered(Vector2(450, 300))


func _clear_frames() -> void:
	for child in frame_list.get_children():
		# Explicitly remove child to clear indexes
		frame_list.remove_child(child)
		child.queue_free()


func _load_frames(content: String) -> void:
	if content.begins_with("{"):
		content = content.substr(content.find("}") + 1)
	print(content)
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
	print(frames.size())
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
			print(bool(int(mouse[0].substr(0, 1))))
			frames[index].give_mouse(bool(int(mouse[0].substr(0, 1))), Vector2(mouse[0].substr(1), mouse[1]))
			frames[index].update_input_string()
			index += 1
	


func _on_FileDialog_file_selected(path):
	match file_dialog.mode:
		file_dialog.MODE_OPEN_FILE:
			var file = File.new()
			file.open(path, File.READ)
			var content = file.get_as_text()
			file.close()
			_clear_frames()
			_load_frames(content)
		file_dialog.MODE_SAVE_FILE:
			var file = File.new()
			file.open(path, File.WRITE)
			file.store_string("gay")
			file.close()
