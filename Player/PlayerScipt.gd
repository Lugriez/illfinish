extends Character

const TRIPLE_ATTACK: PackedScene = preload("res://Player/TripleWave.tscn")

onready var ray = $CollisionShape2D/RayCast2D
onready var animatedSprite = $AnimatedSprite


var current_weapon: Node2D
onready var weapons: Node2D = $Weapons

func _ready():
	current_weapon = weapons.get_child(0)





var smoothed_mouse_pos: Vector2

func rotationSystem():
	smoothed_mouse_pos = lerp(smoothed_mouse_pos, get_global_mouse_position(), 0.2)
	look_at(smoothed_mouse_pos)
	rotation_degrees = stepify((rotation_degrees), 45) - 90
	

func pick_up_weapon(weapon: Node2D)->void:
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	current_weapon.hide()
	current_weapon.cancel_attack()
	current_weapon = weapon
	current_weapon.show()

func get_input() -> void:
	rotationSystem()
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		move_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		move_direction.y += 1
	if Input.is_action_pressed("move_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		move_direction.x += 1
	current_weapon.get_input()



	

func cancel_attack()->void:
	current_weapon.cancel_attack()






