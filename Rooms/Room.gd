extends Node2D
class_name Roompj

const SPAWN_EXPLOSION_SCENE: PackedScene = preload("res://Enemies/SpawnExplosion.tscn")

const ENEMY_SCENES: Dictionary = {
	"FLYING_PIDOR": preload("res://Enemies/FlyingPidor/EnemyFlyingPid.tscn"),
	"GOBLIN": preload("res://Enemies/goblin/EnemyGoblin.tscn")
}
var num_enemies: int

onready var tilemap: TileMap = get_node("TileMap3")

onready var entrance: Node2D = $Entrance
onready var door_container: Node2D = $Doors
onready var enemy_position_container: Node2D = $EnemyPositions
onready var player_detector: Area2D = $PlayerDetector
# Called when the node enters the scene tree for the first time.

func _ready()->void:
	num_enemies = enemy_position_container.get_child_count()

func _on_enemy_killed()->void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()

func _open_doors()->void:
	for door in door_container.get_children():
		door.open()
		
func _close_entrance()->void:
	
	for entry_position in entrance.get_children():
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position), 3)
		tilemap.set_cellv(tilemap.world_to_map(entry_position.position)+Vector2.UP , 4)
	for door in door_container.get_children():
		door.close()
		
func _spawn_enemies()->void:
	for enemy_position in enemy_position_container.get_children():
		var enemy: KinematicBody2D
		if randi()%2 == 0:
			enemy = ENEMY_SCENES.FLYING_PIDOR.instance()
		else:
			enemy = ENEMY_SCENES.GOBLIN.instance()
		var __ = enemy.connect("tree_exited", self, "_on_enemy_killed")
		enemy.position = enemy_position.position
		call_deferred("add_child", enemy)
		var spawn_explosion: AnimatedSprite = SPAWN_EXPLOSION_SCENE.instance()
		spawn_explosion.position = enemy_position.position
		call_deferred("add_child", spawn_explosion)


func _on_PlayerDetector_body_entered(_body: KinematicBody2D)->void:
	player_detector.queue_free()
	if num_enemies>0:
		_close_entrance()
		_spawn_enemies()
	else:
		_close_entrance()
		_open_doors()
