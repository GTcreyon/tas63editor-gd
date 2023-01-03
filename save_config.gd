extends Button

var path = ""
export var file_name: String = ""
onready var text_edit: TextEdit = $"../TextEdit"


func _ready():
	var file = File.new()
	if file.open("user://input_path.txt", File.READ) == OK:
		path = file.get_as_text()
		file.close()
		if file.open("%s/%s" % [path, file_name], File.READ) == OK:
			text_edit.text = file.get_as_text()
			file.close()


func _on_press():
	var file = File.new()
	if file.open("%s/%s" % [path, file_name], File.WRITE) == OK:
		file.store_string(text_edit.text)
		file.close()
