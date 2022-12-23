extends Button

const FRAME_PREFAB = preload("res://frame.tscn")

onready var list = $"%InputFrames"
onready var main = $"/root/Main"


func _on_AddInput_pressed():
	var inst = FRAME_PREFAB.instance()
	list.add_child(inst)
	if main.last_selected != -1:
		list.move_child(inst, main.last_selected + 1)
	inst.set_input_string()
	main.update_after(main.last_selected + 2)
