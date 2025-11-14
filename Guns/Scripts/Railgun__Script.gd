extends Gun2D

var SHOOT = false

var shoot_time = 3
var charging = false

var shoot_dir = Vector2.ZERO

const slowing_factor = .01

@onready var plasma = $Sprite2D/Icon

func _process(delta):
	var mouse_pos = get_local_mouse_position()
	
	get_child(0).rotation = atan2(mouse_pos.y, mouse_pos.x)
	if Input.is_action_just_pressed("SHOOT") and can_shoot and ammo > 0:
		can_shoot = false
		charging = true
		player.can_move = false
		player.can_swap = false
	
	if charging:
		shoot_time -= delta
		var v = player.velocity
		var d = mouse_pos.normalized()
		var sx = slowing_factor**delta
		var sy = .4**delta
		
		var diagonal = (sx - sy)*d.x*d.y

		#Slows down the player in the "d" direction (aka the direction that we are shooting)
		player.velocity.x = (sx*d.x*d.x + sy*d.y*d.y)*v.x + diagonal * v.y
		player.velocity.y = diagonal * v.x + (sx*d.y*d.y + sy*d.x*d.x) * v.y
		
		
		
		if shoot_time <= 0:
			SHOOT = true
			charging = false
			shoot_time = 3
		plasma.scale = Vector2(0.028,0.607) * (3 - shoot_time)
	
	if SHOOT:
		plasma.scale = Vector2.ZERO
		player.velocity += -mouse_pos.normalized() * propulsion
		ammo -= 1
		ammo_lab.text = str(ammo)
		if timer:
			timer.start(reload_time)
		
		SHOOT = false
		player.can_move = true
		player.can_swap = true
	if p_circ:
		p_circ.value = 100*(1 - timer.time_left/reload_time)
