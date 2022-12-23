extends MenuButton

onready var popup = $PopupDialog


func _ready():
	get_popup().connect("id_pressed", self, "_selected")


func _selected(id):
	match id:
		0:
			popup.popup_centered()
		1:
			OS.shell_open("https://github.com/GTcreyon/tas63editor-gd")
		2:
			OS.shell_open("https://discord.gg/c3q9pqn33s")
