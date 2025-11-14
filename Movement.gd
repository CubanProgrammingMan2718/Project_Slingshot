extends CharacterBody2D

var bdir = 0

var GRAVITY = 500
@onready var gun_set = $Guns

var gun

var curr_gun = 0

var can_move = true
var can_swap = true


func _ready():
	$"Pointing Vector".target_position.x = 1
	gun_set = $Guns
	if gun_set.get_child_count():
		gun = gun_set.get_child(curr_gun)
		gun.switchOut()
		curr_gun = (curr_gun + 1)%gun_set.get_child_count()
		gun = gun_set.get_child(curr_gun)
		
		gun.switchIn()
	

func _process(delta):
	gun_set = $Guns
	var dir = Input.get_axis("LEFT", "RIGHT")
	var p = $"Pointing Vector"
	if dir:
		p.target_position = 12*dir*Vector2.RIGHT
	if p.is_colliding():
		velocity.y += (-.2 * GRAVITY - 2*velocity.y) * delta
		if dir:
			bdir = dir
		if Input.is_action_just_pressed("JUMP") and !is_on_floor():
			velocity += Vector2(-300*bdir, -500)
	$DEBUG_VEL.points[1] = velocity/10
	if can_move:
		if is_on_floor():
			velocity.x += 5*(360*dir - velocity.x)*delta;
		else:
			velocity += (360*dir * Vector2.RIGHT - .5*velocity)*delta;
		
		if Input.is_action_just_pressed("JUMP") and is_on_floor():
			velocity.y = -400
		velocity.y += GRAVITY * delta
		
		
			
	move_and_slide()
	
	if Input.is_action_just_pressed("SWITCH") and can_swap:
		var gun = gun_set.get_child(curr_gun)
		gun.switchOut()
		curr_gun = (curr_gun + 1)%gun_set.get_child_count()
		gun = gun_set.get_child(curr_gun)
		
		gun.switchIn()
		

func _on_hurt_box_body_entered(_body: Node2D) -> void:
	position = Vector2(0 , 0)
