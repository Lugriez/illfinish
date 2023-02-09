extends Node2D
class_name Weapon

export(bool) var on_floor = false

onready var weapon_anim_player: AnimationPlayer = $AnimationPlayer
onready var charge_partical:Particles2D = $WeaponMelee/Node2D/Sprite/ChargeParticles
onready var hitbox:Area2D = $WeaponMelee/SplashSprite/HitboxSplash

onready var player_detector: Area2D = $PlayerDetector


func _ready():
	hitbox.knockback_force = 150
	if not on_floor:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
	
func get_input()-> void:
	hitbox.knockback_direction = (get_global_mouse_position() - global_position).normalized()
	
	if Input.is_action_just_pressed("ui_attack") and not weapon_anim_player.is_playing():
		weapon_anim_player.play("charge_attack")
	elif Input.is_action_just_released("ui_attack"):
		if weapon_anim_player.is_playing() and weapon_anim_player.current_animation == "charge_attack":
			weapon_anim_player.play("attack")
		elif charge_partical.emitting:
			weapon_anim_player.play("strong_attack")	
			
func cancel_attack()->void:
	weapon_anim_player.play("cancel_attack")

func is_busy()->bool:
	if weapon_anim_player.is_playing() or charge_partical.emitting:
		return true
	else:
		return false


func _on_PlayerDetector_body_entered(_body: KinematicBody2D):
	if _body != null:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
		_body.pick_up_weapon(self)
		position = Vector2.ZERO
