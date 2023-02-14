extends Character
class_name Enemy

onready var animatedSprite = $AnimatedSprite
onready var health_point_bar = $"HP bar/HealthBar"

var chase_availability:bool = true
var path: PoolVector2Array
onready var navi: Navigation2D = get_tree().current_scene.get_node("Rooms")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")
onready var path_timer: Timer = get_node("PathTimer")

func chase():
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < 5:
			path.remove(0)
			if not path:
				return
		move_direction = vector_to_next_point
		
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	health_point_bar.rect_scale.x = hp/max_hp

func _on_PathTimer_timeout():
	if is_instance_valid(player):
		_get_path_to_player()
	else:
		path_timer.stop()
		path = []
		move_direction = Vector2.ZERO
		
func _get_path_to_player()->void:
	path = navi.get_simple_path(global_position, player.position)

