extends Area2D

var velocity = Vector2.ZERO
@onready var spawn_point = position

func _process(delta):
	position += velocity * delta
	if (spawn_point - position).length() > 10000:
		queue_free()
