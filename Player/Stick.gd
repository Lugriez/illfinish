extends Weapon


const TRIPLE_ATTACK: PackedScene = preload("res://Player/TripleWave.tscn")


func _throw_knife()->void:
	var gg = global_position
	var mm = get_global_mouse_position()	
	var projectile: Area2D = TRIPLE_ATTACK.instance()
	projectile.launch(gg, mm, 200)
	get_tree().current_scene.add_child(projectile)


