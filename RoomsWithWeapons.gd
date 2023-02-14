extends Roompj

const WEAPONS:Array = [preload("res://Player/Stick.tscn"),
preload("res://Player/Pickaxe.tscn"),]

onready var weapon_pos: Position2D = $WeaponPos2D


func _ready():
	var weapon = WEAPONS[randi()%WEAPONS.size()].instance()
	weapon.position  = weapon_pos.position
	weapon.on_floor = true
	add_child(weapon)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
