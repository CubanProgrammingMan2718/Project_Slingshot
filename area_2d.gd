extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if not (body is TileMapLayer):
		$"../Robot Dude".position = body.position
		$"../Robot Dude/Camera2D".enabled = true
		body.queue_free()
		queue_free()
