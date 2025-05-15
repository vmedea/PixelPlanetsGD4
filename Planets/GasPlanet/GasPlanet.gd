extends "res://Planets/Planet.gd"

func set_pixels(amount: int) -> void:
	$Cloud.material.set_shader_parameter("pixels", amount)
	$Cloud2.material.set_shader_parameter("pixels", amount)
	$Cloud.size = Vector2(amount, amount)
	$Cloud2.size = Vector2(amount, amount)

func set_light(pos: Vector2) -> void:
	$Cloud.material.set_shader_parameter("light_origin", pos)
	$Cloud2.material.set_shader_parameter("light_origin", pos)

func set_seed(sd: int) -> void:
	var converted_seed: float = sd%1000/100.0
	$Cloud.material.set_shader_parameter("seed", converted_seed)
	$Cloud2.material.set_shader_parameter("seed", converted_seed)
	$Cloud2.material.set_shader_parameter("cloud_cover", randf_range(0.28, 0.5))

func set_rotate(r: float) -> void:
	$Cloud.material.set_shader_parameter("rotation", r)
	$Cloud2.material.set_shader_parameter("rotation", r)
	
func update_time(t: float) -> void:
	$Cloud.material.set_shader_parameter("time", t * get_multiplier($Cloud.material) * 0.005)
	$Cloud2.material.set_shader_parameter("time", t * get_multiplier($Cloud2.material) * 0.005)
	
func set_custom_time(t: float) -> void:
	$Cloud.material.set_shader_parameter("time", t * get_multiplier($Cloud.material))
	$Cloud2.material.set_shader_parameter("time", t * get_multiplier($Cloud2.material))


var color_vars1: Array[StringName] = ["base_color", "outline_color", "shadow_base_color", "shadow_outline_color"]
var color_vars2: Array[StringName] = ["base_color", "outline_color", "shadow_base_color", "shadow_outline_color"]
func get_colors() -> PackedColorArray:
	return (_get_colors_from_vars($Cloud.material, color_vars1) + _get_colors_from_vars($Cloud2.material, color_vars2))

func set_colors(colors: PackedColorArray) -> void:
	_set_colors_from_vars($Cloud.material, color_vars1, colors.slice(0, 4))
	_set_colors_from_vars($Cloud2.material, color_vars2, colors.slice(4, 8))

func randomize_colors() -> void:
	var seed_colors := _generate_new_colorscheme(8 + randi()%4, randf_range(0.3, 0.8), 1.0)
	var cols1 := PackedColorArray()
	var cols2 := PackedColorArray()
	for i in 4:
		var new_col := seed_colors[i].darkened(i/6.0).darkened(0.7)
#		new_col = new_col.lightened((1.0 - (i/4.0)) * 0.2)
		cols1.append(new_col)
	
	for i in 4:
		var new_col := seed_colors[i+4].darkened(i/4.0)
		new_col = new_col.lightened((1.0 - (i/4.0)) * 0.5)
		cols2.append(new_col)

	set_colors(cols1 + cols2)
