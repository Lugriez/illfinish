extends Node2D



func _init():
	randomize()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	$UI/ScoreLabel/Score.text = SavedData.score
	pass # Replace with function body.



