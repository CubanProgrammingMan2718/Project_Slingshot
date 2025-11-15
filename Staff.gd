extends Area2D

var t = 0

@onready var init_pos = position

var way_points = [Vector2(9339.0, -728.0), Vector2(9523.0, -2401.645), Vector2(1546.0, -2564.0)]
var hit_count = -1

var standby = true

func _process(delta):
	if hit_count < 3:
		if standby:
			position = init_pos + Vector2(120 * cos(t) * sin(3*t), 240*sin(t))
		else:
			position = position.move_toward(way_points[hit_count], 300*t * delta)
			if not is_zero_approx((position - way_points[hit_count]).length()):
				look_at(way_points[hit_count])
			if is_zero_approx((position - way_points[hit_count]).length()):
				standby = true
				rotation = -TAU/4
				t = 0
				init_pos = position

		
	t += delta
	
	
		


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if standby:
			standby = false
			t = 0
		if hit_count < 2:
			hit_count += 1
		else:
			body.get_child(2).add_child(preload("res://Guns/Scenes/Laser__Scene.tscn").instantiate())
			var l = Label.new()
			get_tree().root.add_child(l)
			l.text = "Congratulations! You won! Press right click to look at your shiny reward
			More to come in the final game ! " + "By the way, you finished in " + str(round(Speedrun_Timer.time)) + " seconds! 
			Try to get a better time if you wish." 
			l.position = body.position - Vector2(0, 100)
			$"../AudioStreamPlayer".volume_db -= 5
			$"../CharacterBody2D".queue_free()
			queue_free()
		
