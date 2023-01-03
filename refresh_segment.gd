extends Button

onready var main = $"/root/Main"
onready var segment_key = $"../SegmentKey"


func _on_RefreshSegment_pressed():
	main.refresh_args[2] = segment_key.value
