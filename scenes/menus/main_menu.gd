extends CanvasLayer

signal sub_menu_opened
signal sub_menu_closed

@export var play_packed_scene : PackedScene
@export var options_packed_scene : PackedScene
@export var stats_packed_scene : PackedScene
@export var credits_packed_scene : PackedScene
@export var exit_packed_scene : PackedScene

@onready var buttons_margin_container = $ButtonsMarginContainer
@onready var buttons_vbox_container = $ButtonsMarginContainer/VBoxContainer
@onready var exit_button = $ButtonsMarginContainer/VBoxContainer/ExitButton

var sub_menu : OverlaidMenu

func _open_sub_menu(menu : PackedScene) -> Node:
	sub_menu = menu.instantiate()
	add_child(sub_menu)
	buttons_margin_container.hide()
	sub_menu.hidden.connect(_close_sub_menu, CONNECT_ONE_SHOT)
	sub_menu.tree_exiting.connect(_close_sub_menu, CONNECT_ONE_SHOT)
	sub_menu_opened.emit()
	return sub_menu

func _close_sub_menu() -> void:
	if sub_menu == null:
		return
	sub_menu.queue_free()
	sub_menu = null
	buttons_margin_container.show()
	sub_menu_closed.emit()

func _input(event : InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		_close_sub_menu()
	if event.is_action_released("ui_accept") and get_viewport().gui_get_focus_owner() == null:
		buttons_vbox_container.focus_first()

func _ready() -> void:
	if not OS.has_feature("pc"):
		exit_button.hide()

func _on_play_button_pressed() -> void:
	_open_sub_menu(play_packed_scene)

func _on_options_button_pressed() -> void:
	_open_sub_menu(options_packed_scene)

func _on_stats_button_pressed() -> void:
	_open_sub_menu(stats_packed_scene)

func _on_credits_button_pressed() -> void:
	_open_sub_menu(credits_packed_scene)

func _on_exit_button_pressed() -> void:
	_open_sub_menu(exit_packed_scene)
