extends Button

const FRAME_PREFAB = preload("res://frame.tscn")

onready var list = $"%InputFrames"


func _on_AddInput_pressed():
	var inst = FRAME_PREFAB.instance()
	list.add_child(inst)
