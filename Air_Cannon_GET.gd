extends Area2D

var t = 0;

var q = false

var w = 100

@onready var init_pos = position

func _process(delta):
	
	if q:
		t += delta/w ##REMOVE THE ZERO FOR PROPER FUNCTION
		position = init_pos + 120*Vector2(6*sin(5*t), 3*sin(TAU*t)*cos(t)) 
		var vel = Vector2(30*cos(5*t), -3*sin(TAU*t)*sin(t) + 3*TAU*cos(TAU*t)*cos(t))
		look_at(position - vel*delta);
		if w > 3:
			w *= 1-3*delta

#Bad code, fix later
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if not q:
			q = true
		else:
			var shotgun = preload("res://Guns/Scenes/Shotgun__Scene.tscn").instantiate()
			
			body.get_child(2).add_child(shotgun)
			body.curr_gun = 0
			shotgun.switchIn()
			
			queue_free()
