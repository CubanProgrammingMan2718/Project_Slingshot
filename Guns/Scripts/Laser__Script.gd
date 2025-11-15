extends Gun2D

func shoot(vel : Vector2):
	var bull = preload("res://Laser_bullet.tscn").instantiate()
	get_tree().root.get_child(0).add_child(bull)
	bull.velocity = vel
	bull.position = get_child(0).global_position
	bull.rotation = atan2(vel.y, vel.x)


func _process(_delta):
	var mouse_pos = get_local_mouse_position()
	
	if can_rot:
		get_child(0).rotation = atan2(mouse_pos.y, mouse_pos.x)
		if Input.is_action_pressed("SHOOT") and can_shoot and ammo_av():
			player.velocity += -mouse_pos.normalized() * propulsion
			shoot(mouse_pos.normalized() * 3750)
			can_shoot = false
			if(ammo != UNLIMITED):
				ammo -= 1
			if timer:
				timer.start(reload_time)
		p_circ.value = 100*(1 - timer.time_left/reload_time)
