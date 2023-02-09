extends Hitbox

func _on_HitboxSplash_area_entered(area: Area2D):
	area.queue_free()
