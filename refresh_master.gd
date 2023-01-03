extends Button

onready var main = $"/root/Main"


func _on_RefreshMaster_pressed():
	main.refresh_args[0] = 1
