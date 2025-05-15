extends "res://Planets/Planet.gd"

func set_pixels(amount: int) -> void:
	$Ground.material.set_shader_parameter("pixels", amount)
	$Craters.material.set_shader_parameter("pixels", amount)

	$Ground.size = Vector2(amount, amount)
	$Craters.size = Vector2(amount, amount)

func set_light(pos: Vector2) -> void:
	$Ground.material.set_shader_parameter("light_origin", pos)
	$Craters.material.set_shader_parameter("light_origin", pos)

func set_seed(sd: int) -> void:
	var converted_seed: float = sd%1000/100.0
	$Ground.material.set_shader_parameter("seed", converted_seed)
	$Craters.material.set_shader_parameter("seed", converted_seed)

func set_rotate(r: float) -> void:
	$Ground.material.set_shader_parameter("rotation", r)
	$Craters.material.set_shader_parameter("rotation", r)

func update_time(t: float) -> void:
	$Ground.material.set_shader_parameter("time", t * get_multiplier($Ground.material) * 0.02)
	$Craters.material.set_shader_parameter("time", t * get_multiplier($Craters.material) * 0.02)

func set_custom_time(t: float) -> void:
	$Ground.material.set_shader_parameter("time", t * get_multiplier($Ground.material))
	$Craters.material.set_shader_parameter("time", t * get_multiplier($Craters.material))

func set_dither(d: bool) -> void:
	$Ground.material.set_shader_parameter("should_dither", d)

func get_dither() -> bool:
	return $Ground.material.get_shader_parameter("should_dither")
	
var color_vars1: Array[StringName] = ["color1","color2","color3"]
var color_vars2: Array[StringName] = ["color1","color2"]

func get_colors() -> PackedColorArray:
	return (_get_colors_from_vars($Ground.material, color_vars1)
	+ _get_colors_from_vars($Craters.material, color_vars2)
	)

func set_colors(colors: PackedColorArray) -> void:
	_set_colors_from_vars($Ground.material, color_vars1, colors.slice(0, 3))
	_set_colors_from_vars($Craters.material, color_vars2, colors.slice(3, 5))

func randomize_colors() -> void:
	var seed_colors := _generate_new_colorscheme(3 + randi()%2, randf_range(0.3, 0.6), 0.7)
	var cols := PackedColorArray()
	for i in 3:
		var new_col := seed_colors[i].darkened(i/3.0)
		new_col = new_col.lightened((1.0 - (i/3.0)) * 0.2)

		cols.append(new_col)

	set_colors(cols + PackedColorArray([cols[1], cols[2]]))
