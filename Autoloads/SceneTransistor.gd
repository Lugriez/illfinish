extends CanvasLayer

var new_scene: String

onready var animation_player:AnimationPlayer = $AnimationPlayer

func start_transition(path_to_scene: String):
	new_scene = path_to_scene
	animation_player.play("change_scene")

func change_scene():
	assert(get_tree().change_scene(new_scene) == OK)
		
