extends FiniteStateMachine

func _init():
	_add_state("idle")
	_add_state("move")
	_add_state("hurt")
	
func _ready() -> void:
	set_state(states.idle)

func _state_logic(delta: float):
	if state == states.idle or state == states.move:
		parent.get_input()
		parent.move()

func _get_transition() -> int:
	#print (animation_player.get_current_animation())
	match state:
		states.idle:
			if parent.vel.length() > 10:
				return (states.move)
		states.move:
			if parent.vel.length() <= 10:
				return (states.idle)
		states.hurt:
			if !animation_player.is_playing():
				return (states.idle)
	return -1

func _enter_state(_previous_state: int, _new_state: int)->void:
	match _new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move")
		states.hurt:
			animation_player.play("hurt")

