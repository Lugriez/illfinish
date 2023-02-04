extends Enemy
class_name FlyingEnemy, "res://Enemies/FlyingPidor/fly_anim_f3.png"


onready var hitbox: Area2D = get_node("Hitbox")


func _physics_process(delta):
	hitbox.knockback_direction = vel.normalized()*3

func _ready():
	pass # Replace with function body.

func _on_PathTimer_timeout():
	if is_instance_valid(player):
		path = navi.get_simple_path(global_position, player.position)
		#print(path)
	else:
		path_timer.stop()
		path = []
		move_direction = Vector2.ZERO
