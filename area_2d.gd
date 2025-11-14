extends Area2D

var b
var count = 0


func _on_body_entered(body: RigidBody2D) -> void:
	
	if body is RigidBody2D:
		body.physics_material_override.bounce = 0;
		b = body
		body.constant_force = Vector2(0, -400)
	
	
func _process(delta):
	if b:
		if Input.is_action_just_pressed("JUMP"):
			count += 1
	if count > 10:
		$"../Robot Dude".position = b.position
		$"../Robot Dude/Camera2D".enabled = true
		b.queue_free()
		queue_free()


	
