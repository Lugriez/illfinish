extends KinematicBody2D
class_name Character

export var hp: float
export var moveSpeed: int = 100
export var acceleration: int = 20

var max_hp: float

var move_direction: Vector2 = Vector2.ZERO
const FRICTION: float = 0.1
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _physics_process(delta):
	vel = move_and_slide(vel)
	vel = lerp(vel, Vector2.ZERO, FRICTION)
	
func move():
	move_direction = move_direction.normalized()
	vel += move_direction * acceleration
	vel = vel.clamped(moveSpeed)
	print (vel)

func take_damage(dmg: int, dir: Vector2, force: int):
	hp-=dmg
	if hp<0.284:
		queue_free()
	vel = dir * force
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	if hp>0:
		max_hp = hp
	else:
		max_hp = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
