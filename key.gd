extends CheckBox

export var action: String = ""


func _process(delta):
	if text != "":
		action = text
		text = ""
	if Input.is_action_just_pressed("key_" + action):
		pressed = !pressed
