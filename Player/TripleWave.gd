extends Projectile

onready var animation_player:AnimationPlayer = $AnimationPlayer

func _collide(body: KinematicBody2D)->void:
	if enemy_exited:
		if body != null:
			body.take_damage(damage, knockback_direction, knockback_force)
		animation_player.play("disap")
		
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "disap":
		queue_free()
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
