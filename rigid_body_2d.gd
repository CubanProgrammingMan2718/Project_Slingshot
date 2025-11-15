extends RigidBody2D

func NOT_ready():
	pass
	$"../Robot Dude/Camera2D".enabled = true
	$"../AudioStreamPlayer".play()
	queue_free()
	
