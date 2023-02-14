extends Node2D
class_name Weapon

export(bool) var on_floor = false

onready var weapon_anim_player: AnimationPlayer = $AnimationPlayer
onready var charge_partical:Particles2D = $WeaponMelee/Node2D/Sprite/ChargeParticles
onready var hitbox:Area2D = $WeaponMelee/SplashSprite/HitboxSplash

onready var player_detector: Area2D = $PlayerDetector
onready var tween: Tween = $Tween

onready var can_pickup: bool = true
onready var pickable_timer: Timer = $Pickable

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

func interpolate_pos(init_pos, final_pos):
	var __ = tween.interpolate_property(self, "position", init_pos, final_pos, 0.6, Tween.TRANS_QUART, Tween.EASE_OUT)
	assert(__)
	__ = tween.start()
	assert(__)
	player_detector.set_collision_mask_bit(0, true)
	pickable_timer.start()



func _on_PlayerDetector_body_entered(_body: KinematicBody2D):
	
	if _body != null and can_pickup:
		player_detector.set_collision_mask_bit(0, false)
		player_detector.set_collision_mask_bit(1, false)
		can_pickup = false
		_body.pick_up_weapon(self)
		weapon_anim_player.play("RESET")
		position = Vector2.ZERO
	else:
		var __ = tween.stop_all()
		assert(__)
		player_detector.set_collision_mask_bit(1, true)
		on_floor = true
		pickable_timer.start()
		

func _on_Tween_tween_completed(object, key):
	player_detector.set_collision_mask_bit(1, true)
	on_floor = true
	pickable_timer.start()

func _on_Pickable_timeout():
	can_pickup = true

