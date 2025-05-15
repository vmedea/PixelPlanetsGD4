extends ColorRect

signal set_colors

@onready var textedit: TextEdit = $PopupFront/HBoxContainer/VBoxContainer/TextEdit
@onready var apply_button: Button = $PopupFront/HBoxContainer/VBoxContainer2/ApplyColors

var current_colors := PackedColorArray()

func set_current_colors(colors: PackedColorArray) -> void:
	current_colors = colors
	textedit.text = ""
	var index := 0
	for c in colors:
		textedit.text += "#" + c.to_html(false)
		if index < colors.size() - 1:
			textedit.text += "\n"
		index += 1

func _on_CloseButton_pressed() -> void:
	visible = false

func _on_CopyToClipboard_pressed() -> void:
	DisplayServer.clipboard_set(textedit.text)

func _on_PasteFromClipboard_pressed() -> void:
	textedit.text = DisplayServer.clipboard_get()

func _convert_to_colors() -> PackedColorArray:
	var text := textedit.text.replace(",", "").split("\n")
	var colors := PackedColorArray()
	for t in text:
		t = t.replace(",", "")
		colors.append(Color(t))
	
	for i in range(current_colors.size() - colors.size()):
		colors.append(Color())
	return colors

func _on_ApplyColors_pressed() -> void:
	var colors := _convert_to_colors()
	emit_signal("set_colors", colors)
	visible = false
