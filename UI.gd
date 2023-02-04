extends CanvasLayer

const MIN_HEALTH: int = 16

var max_hp: int = 4

onready var player: KinematicBody2D = get_parent().get_node("Player")
onready var health_bar: TextureProgress = get_node("Health_bar")
onready var health_bar_tween: Tween = get_node("Health_bar/Tween")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	max_hp = player.hp
	_update_health_bar(100)

func _update_health_bar(new_value: float) -> void:
	var __ = health_bar_tween.interpolate_property(health_bar, "value",
	health_bar.value, new_value, 0.5,Tween.TRANS_QUINT, Tween.EASE_OUT)
	__ = health_bar_tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_hp_changed(new_hp: float):
	var new_health = (100-MIN_HEALTH) * new_hp/max_hp + MIN_HEALTH
	_update_health_bar(new_health)
	
