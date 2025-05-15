extends ColorRect
signal cancel_gif


@onready var export_button: Button = $PopupFront/VBoxContainer/HBoxContainer/ExportButton
@onready var progressbar: TextureProgressBar = $PopupFront/VBoxContainer/TextureProgress
@onready var set_framecount: SpinBox = $PopupFront/VBoxContainer/SpritesheetSettings/VBoxContainer/GifFrameCount
@onready var set_giftime: SpinBox = $PopupFront/VBoxContainer/SpritesheetSettings/VBoxContainer/GifTime
@onready var set_delay: SpinBox = $PopupFront/VBoxContainer/SpritesheetSettings/VBoxContainer/FrameDelay


@onready var frames: int = 60
@onready var length: float = 10
@onready var frame_delay: float = 0.167

func _on_CancelButton_pressed() -> void:
	visible = false
	emit_signal("cancel_gif")

func _on_ExportButton_pressed() -> void:
	progressbar.visible = true
	get_parent().export_gif(frames, frame_delay, progressbar)

func _on_FrameDelay_value_changed(value: float) -> void:
	frame_delay = int(value)
	length = frames * frame_delay
	
	set_giftime.value_changed.disconnect(_on_GifTime_value_changed)
	set_giftime.value = length
	set_giftime.value_changed.connect(_on_GifTime_value_changed)

func _on_GifTime_value_changed(value: float) -> void:
	length = value
	frame_delay = length/frames
	
	set_delay.value_changed.disconnect(_on_FrameDelay_value_changed)
	set_delay.value = frame_delay
	set_delay.value_changed.connect(_on_FrameDelay_value_changed)

func _on_GifFrameCount_value_changed(value: float) -> void:
	frames = int(value)
	frame_delay = length/frames
	
	set_delay.value_changed.disconnect(_on_FrameDelay_value_changed)
	set_delay.value = frame_delay
	set_delay.value_changed.connect(_on_FrameDelay_value_changed)
