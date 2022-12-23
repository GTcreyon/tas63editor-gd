extends CheckBox

export var action: String = ""

onready var main = $"/root/Main"


func _process(delta):
	if !main.file_dialog.visible:
		if text != "":
			action = text
			text = ""
		if Input.is_action_just_pressed("key_" + action):
			pressed = !pressed
