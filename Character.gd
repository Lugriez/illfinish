extends KinematicBody2D
class_name Character

export(int) var hp: float = 10 setget set_hp
signal hp_changed(new_hp)
export(int) var moveSpeed: int = 100
export(int) var acceleration: int = 20
export(bool) var flying: bool = false

var max_hp: float

var move_direction: Vector2 = Vector2.ZERO
const FRICTION: float = 0.1
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()

onready var state_machine: Node = get_node("FiniteStateMachine")
onready var animation_player: Node = get_node("AnimationPlayer")


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

func take_damage(dmg: int, dir: Vector2, force: int):
	if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		self.hp-=dmg
		state_machine.set_state(state_machine.states.hurt)
		if hp<0.284:
			queue_free() 
		vel += dir * force

# Called when the node enters the scene tree for the first time.
func _ready():
	if hp>0:
		max_hp = hp
	else:
		max_hp = 1

func set_hp(new_hp: float) -> void:
	hp = new_hp
	emit_signal("hp_changed", new_hp)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
