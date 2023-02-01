extends Character
class_name Enemy

onready var ray = $CollisionShape2D/RayCast2D
onready var animatedSprite = $AnimatedSprite
onready var animTree = $AnimationTree
onready var weapon_anim_player = $WeaponMelee/WeaponAnimPlayer
onready var health_point_bar = $"HP bar/HealthBar"

var chase_availability:bool = true
var path: PoolVector2Array
onready var navi: Navigation2D = get_tree().current_scene.get_node("Navi4mo")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")


func chase():
	#print(path)
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < 1:
			path.remove(0)
			if not path:
				return
		move_direction = vector_to_next_point
		
		
		

func _ready():
	pass # Replace with function body.


func _physics_process(delta):		
	health_point_bar.rect_scale.x = hp/max_hp
	move()
	if chase_availability:
		chase()
	if vel == Vector2.ZERO:
		animTree.get("parameters/playback").travel("idle")
	else:
		animTree.get("parameters/playback").travel("move")
