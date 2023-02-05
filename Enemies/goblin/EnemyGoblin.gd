extends Enemy

const THROWABLE_KNIFE: PackedScene = preload("res://Enemies/goblin/ThrowableKnife.tscn")

const MIN_DISTANCE_TO_PLAYER: int = 40
const MAX_DISTANCE_TO_PLAYER: int = 80

export(int) var projecile_speed = 150

var can_attack: bool = true

var distance_to_player: float

onready var attack_timer: Timer = $AttackTimer

func _on_PathTimer_timeout()->void:
	if is_instance_valid(player):
		distance_to_player = (player.position - global_position).length()
		if distance_to_player > MAX_DISTANCE_TO_PLAYER:
			_get_path_to_player()
		elif distance_to_player < MIN_DISTANCE_TO_PLAYER:
			_get_path_to_move_away_from_player()
		else:
			if can_attack:
				can_attack = false
				_throw_knife()
				attack_timer.start()
	else:
		path_timer.stop()
		path = []
		move_direction = Vector2.ZERO
		

	
func _get_path_to_move_away_from_player() -> void:
	var dir: Vector2 = (global_position - player.position).normalized()
	path = navi.get_simple_path(global_position, global_position + dir * 100)

func _throw_knife()->void:
	var projectile: Area2D = THROWABLE_KNIFE.instance()
	projectile.launch(global_position, player.position, projecile_speed)
	get_tree().current_scene.add_child(projectile)

func _on_AttackTimer_timeout() -> void:
	can_attack = true
	pass # Replace with function body.
