extends Character

onready var ray = $CollisionShape2D/RayCast2D
onready var animatedSprite = $AnimatedSprite
onready var animTree = $AnimationTree
onready var weapon_anim_player = $WeaponMelee/WeaponAnimPlayer
onready var weapon_melee_hitbox: Area2D = $WeaponMelee/SplashSprite/HitboxSplash


# Called when the node enters the scene tree for the first time.
func _ready():
	weapon_melee_hitbox.knockback_force = 1000
	pass # Replace with function body.


var smoothed_mouse_pos: Vector2

func rotationSystem():
	smoothed_mouse_pos = lerp(smoothed_mouse_pos, get_global_mouse_position(), 0.2)
	#var s = stepify(rad2deg(get_global_mouse_position().angle()), 45)
	look_at(smoothed_mouse_pos)
	rotation_degrees = stepify((rotation_degrees), 45) - 90
	weapon_melee_hitbox.knockback_direction = (get_global_mouse_position() - global_position).normalized()
	#rint(weapon_melee_hitbox.knockback_direction)

func _physics_process(delta):
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		move_direction.y -= 1
	if Input.is_action_pressed("move_down"):
		move_direction.y += 1
	if Input.is_action_pressed("move_left"):
		move_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		move_direction.x += 1
	
	move()
	rotationSystem()
	
	if vel == Vector2.ZERO:
		animTree.get("parameters/playback").travel("idle")
	else:
		animTree.get("parameters/playback").travel("move")
	#vel = vel.normalized()
	#vel = move_and_slide(vel * moveSpeed)
	
	if Input.is_action_just_pressed("ui_attack") and not weapon_anim_player.is_playing():
		weapon_anim_player.play("attack")




