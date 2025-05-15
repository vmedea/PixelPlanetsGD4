extends Button

signal color_picked

var index: int = 0
var own_color: Color
var is_active: bool = false

func _ready() -> void:
	add_theme_stylebox_override("normal", get_theme_stylebox("normal").duplicate())
	add_theme_stylebox_override("hover", get_theme_stylebox("hover").duplicate())
	add_theme_stylebox_override("pressed", get_theme_stylebox("pressed").duplicate())

func set_index(i: int) -> void:
	index = i

func set_color(color: Color) -> void:
	own_color = color
	get_theme_stylebox("normal").bg_color = color
	get_theme_stylebox("hover").bg_color = color
	get_theme_stylebox("pressed").bg_color = color

func _on_picker_color_changed(color: Color) -> void:
	if is_active:
		set_color(color)
		emit_signal("color_picked", color, index)
