extends Button

onready var main = $"/root/Main"


func _on_RefreshWarps_pressed():
	main.refresh_args[1] = 1
