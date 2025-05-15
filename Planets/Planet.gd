extends Control

var time: float = 1000.0
var override_time: bool = false
var original_colors: PackedColorArray = PackedColorArray()
@export var relative_scale: float = 1.0
@export var gui_zoom: float = 1.0

func _ready() -> void:
	original_colors = get_colors()

func set_pixels(_amount: int) -> void:
	pass
func set_light(_pos: Vector2) -> void:
	pass
func set_seed(_sd: int) -> void:
	pass
func set_rotate(_r: float) -> void:
	pass
func update_time(_t: float) -> void:
	pass
func set_custom_time(_t: float) -> void:
	pass

func get_multiplier(mat: ShaderMaterial) -> float:
	return (round(mat.get_shader_parameter("size")) * 2.0) / mat.get_shader_parameter("time_speed")
	
func _process(delta: float) -> void:
	time += delta
	if !override_time:
		update_time(time)

func set_dither(_d: bool) -> void:
	pass

func get_dither() -> bool:
	return false

func get_colors() -> PackedColorArray:
	return []

func set_colors(_colors: PackedColorArray) -> void:
	pass

func _get_colors_from_gradient(mat: ShaderMaterial, grad_var: StringName) -> PackedColorArray:
	return mat.get_shader_parameter(grad_var).gradient.colors

func _set_colors_from_gradient(mat: ShaderMaterial, grad_var: StringName, new_gradient: PackedColorArray) -> void:
	mat.get_shader_parameter(grad_var).gradient.colors = new_gradient

func _get_colors_from_vars(mat: ShaderMaterial, vars: Array[StringName]) -> PackedColorArray:
	var colors := PackedColorArray()
	for v in vars:
		colors.append(Color(mat.get_shader_parameter(v)))
	return colors

func _set_colors_from_vars(mat: ShaderMaterial, vars: Array[StringName], colors: PackedColorArray) -> void:
	var index := 0
	for v in vars:
		mat.set_shader_parameter(v, colors[index])
		index += 1

func randomize_colors() -> void:
	pass

# Using ideas from https://iquilezles.org/articles/palettes/
func _generate_new_colorscheme(n_colors: int, hue_diff: float = 0.9, saturation: float = 0.5) -> PackedColorArray:
#	var a = Vector3(rand_range(0.0, 0.5), rand_range(0.0, 0.5), rand_range(0.0, 0.5))
	var a := Vector3(0.5,0.5,0.5)
#	var b = Vector3(rand_range(0.1, 0.6), rand_range(0.1, 0.6), rand_range(0.1, 0.6))
	var b := Vector3(0.5,0.5,0.5) * saturation
	var c := Vector3(randf_range(0.5, 1.5), randf_range(0.5, 1.5), randf_range(0.5, 1.5)) * hue_diff
	var d := Vector3(randf_range(0.0, 1.0), randf_range(0.0, 1.0), randf_range(0.0, 1.0)) * randf_range(1.0, 3.0)

	var cols := PackedColorArray()
	var n := float(n_colors - 1.0)
	n = max(1, n)
	for i in range(0, n_colors, 1):
		var vec3 := Vector3()
		vec3.x = (a.x + b.x *cos(6.28318 * (c.x*float(i/n) + d.x)))
		vec3.y = (a.y + b.y *cos(6.28318 * (c.y*float(i/n) + d.y)))
		vec3.z = (a.z + b.z *cos(6.28318 * (c.z*float(i/n) + d.z)))

		cols.append(Color(vec3.x, vec3.y, vec3.z))
	
	return cols

func get_layers() -> Array[Dictionary]:
	var layers: Array[Dictionary] = []
	for c in get_children():
		layers.append({"name": c.get_name(), "visible": c.visible})
	return layers

func toggle_layer(num: int) -> void:
	get_children()[num].visible = !get_children()[num].visible
