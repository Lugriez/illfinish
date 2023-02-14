extends Area2D

onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _on_Stairs_body_entered(body):
	collision_shape.set_deferred("disabled", true)
	SceneTransistor.start_transition("res://MainScene.tscn")
