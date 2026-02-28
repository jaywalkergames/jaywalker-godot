extends OverlaidMenu


func _on_exit_button_pressed():
	if not OS.has_feature("pc"):
		return
	get_tree().quit()
