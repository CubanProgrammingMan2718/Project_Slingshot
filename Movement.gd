extends CharacterBody2D

var bdir = 0

var GRAVITY = 500
@onready var gun_set = $Guns

var gun

var curr_gun = -1

var can_move = true
var can_swap = true
var flip = false

@onready var spr = $AnimatedSprite2D


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
	p.target_position = Vector2(12,0)
	if dir:
		bdir = dir
	if dir:
		p.target_position = 18*dir*Vector2.RIGHT
	flip = bdir == -1
	
	if dir and is_on_floor():
		spr.play("Walking")
	if not dir and is_on_floor():
		spr.play("Standing")
	if not p.is_colliding() and not is_on_floor():
		spr.play("Falling")
	
	if p.is_colliding():
		
		velocity.y += (-.5 * GRAVITY - 2*velocity.y) * delta
		spr.play("Sliding")
		
		if Input.is_action_just_pressed("JUMP") and !is_on_floor():
			spr.play("Falling")
			velocity.y = -400 
			velocity.x = -200*bdir
	$DEBUG_VEL.points[1] = velocity/10
	if can_move:
		
		if is_on_floor(): 
			velocity.x += 5*(360*dir - velocity.x)*delta
			
			
			if curr_gun != -1:
				gun_set.get_child(curr_gun).ammo = gun_set.get_child(curr_gun).max_ammo
			
		
		else: velocity += (360*dir * Vector2.RIGHT - .5*velocity)*delta
		
		if Input.is_action_just_pressed("JUMP") and is_on_floor(): velocity.y = -400
		
		velocity.y += GRAVITY * delta
		$AnimatedSprite2D.flip_h = flip
		
			
	move_and_slide()
	
	if Input.is_action_just_pressed("SWITCH") and can_swap:
		gun = gun_set.get_child(curr_gun)
		gun.switchOut()
		curr_gun = (curr_gun + 1)%gun_set.get_child_count()
		gun = gun_set.get_child(curr_gun)
		
		gun.switchIn()
		

func _on_hurt_box_body_entered(_body: Node2D) -> void:
	position = Vector2(0 , 0)
