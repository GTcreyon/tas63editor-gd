extends Panel

onready var mouse_x = $"%MouseX"
onready var mouse_y = $"%MouseY"


func _on_MousePanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			mouse_x.value = event.position.x * 2
			mouse_y.value = event.position.y * 2
