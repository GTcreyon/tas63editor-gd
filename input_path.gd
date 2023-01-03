extends LineEdit


func _ready():
	var file = File.new()
	if file.open("user://input_path.txt", File.READ) == OK:
		text = file.get_as_text()
		file.close()


func _on_Button_pressed():
	var file = File.new()
	file.open("user://input_path.txt", File.WRITE)
	file.store_string(text)
	file.close()
