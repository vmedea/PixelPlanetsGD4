extends "res://Planets/Planet.gd"

func set_pixels(amount: int) -> void:
	$Asteroid.material.set_shader_parameter("pixels", amount)
	$Asteroid.size = Vector2(amount, amount)

func set_light(pos: Vector2) -> void:
	$Asteroid.material.set_shader_parameter("light_origin", pos)

func set_seed(sd: int) -> void:
	var converted_seed: float = sd%1000/100.0
	$Asteroid.material.set_shader_parameter("seed", converted_seed)

func set_rotate(r: float) -> void:
	$Asteroid.material.set_shader_parameter("rotation", r)

func update_time(_t: float) -> void:
	pass

func set_custom_time(t: float) -> void:
	$Asteroid.material.set_shader_parameter("rotation", t * PI * 2.0)

func set_dither(d: bool) -> void:
	$Asteroid.material.set_shader_parameter("should_dither", d)

func get_dither() -> bool:
	return $Asteroid.material.get_shader_parameter("should_dither")

var color_vars: Array[StringName] = ["color1", "color2", "color3"]
func get_colors() -> PackedColorArray:
	return _get_colors_from_vars($Asteroid.material, color_vars)

func set_colors(colors: PackedColorArray) -> void:
	_set_colors_from_vars($Asteroid.material, color_vars, colors)

func randomize_colors() -> void:
	var seed_colors := _generate_new_colorscheme(3 + randi()%2, randf_range(0.3, 0.6), 0.7)
	var cols := PackedColorArray()
	for i in 3:
		var new_col := seed_colors[i].darkened(i/3.0)
		new_col = new_col.lightened((1.0 - (i/3.0)) * 0.2)

		cols.append(new_col)

	set_colors(cols)
