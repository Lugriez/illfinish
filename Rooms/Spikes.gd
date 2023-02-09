extends Hitbox

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	animation_player.play("pierce")

func _collide(body: KinematicBody2D) -> void:
	if !body.flying:
		knockback_direction = (body.global_position - global_position).normalized()
		body.take_damage(damage, knockback_direction, knockback_force)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
