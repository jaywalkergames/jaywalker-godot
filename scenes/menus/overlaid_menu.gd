class_name OverlaidMenu
extends Control

func close() -> void:
	if not visible:
		return
	hide()

func _on_back_button_pressed() -> void:
	close()

func _unhandled_input(event : InputEvent) -> void:
	if visible and event.is_action_released("ui_cancel"):
		close()
		get_viewport().set_input_as_handled()

func _exit_tree():
	if Engine.is_editor_hint(): return
	close()
