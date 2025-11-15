extends Area2D

var velo = Vector2.ZERO
@onready var spawn_point = global_position


func _process(delta):
	position += velo * delta
	if (spawn_point - global_position).length() > 100000: #Despawns if you are too far from origin, fix this in full release
		queue_free()
