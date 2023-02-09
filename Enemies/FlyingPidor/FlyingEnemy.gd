extends Enemy
class_name FlyingEnemy, "res://Enemies/FlyingPidor/fly_anim_f3.png"


onready var hitbox: Area2D = get_node("Hitbox")


func _physics_process(delta):
	hitbox.knockback_direction = vel.normalized()*3

func _ready():
	pass # Replace with function body.


