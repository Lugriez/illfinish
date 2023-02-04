extends FiniteStateMachine

func _init():
	_add_state("idle")
	_add_state("chase")
	_add_state("hurt")
	_add_state("dead")

func _ready() -> void:
	set_state(states.chase)

func _state_logic(delta: float):
	if state == states.chase:
		parent.chase()
		parent.move()
		

func _enter_state(_previous_state: int, _new_state: int)->void:
	match _new_state:
		states.idle:
			animation_player.play("idle")
		states.chase:
			animation_player.play("move")
		states.hurt:
			animation_player.play("hurt")

func _get_transition() -> int:
	match state:
		states.hurt:
			if not animation_player.is_playing():
				return states.chase
	return -1
#	match state:
#		states.idle:
#			return (states.chase)
#		states.chase:
#			return (states.idle)
#		states.hurt:
#			if !animation_player.is_playing():
#				return (states.chase)

