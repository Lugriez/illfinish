extends Enemy
class_name FlyingEnemy, "res://Enemies/FlyingPidor/fly_anim_f3.png"

func detect() -> bool:
	#print (position.distance_to(player.position))
	if position.distance_to(player.position)<250:
		return true
	else:
		return false
	
func _ready():
	pass # Replace with function body.

func _on_PathTimer_timeout():
	path = navi.get_simple_path(global_position, player.position)
