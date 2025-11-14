extends RigidBody2D

func _ready():
	pass
	$"../Robot Dude/Camera2D".enabled = true
	$"../AudioStreamPlayer".play()
	queue_free()
	
