extends Button

const EVENT_PREFAB = preload("res://event.tscn")

onready var list = $"%RNGEvents"
onready var main = $"/root/Main"


func _on_AddEvent_pressed():
	var inst = EVENT_PREFAB.instance()
	list.add_child(inst)
	inst.set_event_string("0", "0")
	main.mark_unsaved()
