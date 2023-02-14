extends Character

const TRIPLE_ATTACK: PackedScene = preload("res://Player/TripleWave.tscn")

onready var camera = $PlayerCamera
onready var animatedSprite = $AnimatedSprite


var current_weapon: Node2D
onready var weapons: Node2D = $Weapons

func _ready():
	restoreSavedData()
	
func restoreSavedData()->void:
	self.hp = SavedData.hp
	current_weapon = weapons.get_child(0)
	for weapon1 in SavedData.weapons:
		weapon1 = weapon1.duplicate()
		weapons.add_child(weapon1)
		current_weapon.queue_free()
		current_weapon = weapon1
		current_weapon.position = Vector2.ZERO
	


var smoothed_mouse_pos: Vector2

func rotationSystem():
	smoothed_mouse_pos = lerp(smoothed_mouse_pos, get_global_mouse_position(), 0.2)
	look_at(smoothed_mouse_pos)
	rotation_degrees = stepify((rotation_degrees), 45) - 90
	

func pick_up_weapon(weapon: Node2D)->void:
	SavedData.weapons.append(weapon.duplicate())
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	weapon.on_floor = false
	#current_weapon.hide()
	current_weapon.cancel_attack()
	drop_weapon(current_weapon)
	current_weapon = weapon
	#current_weapon.show()

func drop_weapon(weapon: Node2D):
	weapons.call_deferred("remove_child", weapon)
	get_parent().call_deferred("add_child", weapon)
	weapon.set_owner(get_parent())
	yield(weapon.tween, "tree_entered")
	weapon.can_pickup = false
	var throw_dir: Vector2 = (get_global_mouse_position() - position).normalized()
	weapon.interpolate_pos(position, position + throw_dir*50)
	
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






