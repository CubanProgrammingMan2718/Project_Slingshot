@icon("res://mc2robo1.png")
class_name Gun2D
extends Node2D

const UNLIMITED = -1

@export var COLOR : Color
@export var propulsion : int
@export var ammo : int
@export var reload_ms : int 
@export var max_ammo : int
@onready var reload_time = reload_ms/1000.0

var can_rot = true

func ammo_av():
	return (ammo > 0 or ammo == UNLIMITED)

#This color is really nice, use later Color(0.2,0.2,0.3)

@onready var player = get_parent().get_parent()

var can_shoot = true

var timer : Timer
var p_circ : TextureProgressBar


func abstract_ready():
	
	if max_ammo == 0:
		max_ammo = ammo;
	set_process(false)
	visible = false
	if reload_ms:
		var reload_timer = Timer.new()
		reload_timer.wait_time = reload_ms/1000.0
		add_child(reload_timer)
		timer = reload_timer
		timer.connect("timeout", reload)
		
		var progress_bar = TextureProgressBar.new()
		progress_bar.fill_mode = TextureProgressBar.FillMode.FILL_CLOCKWISE
		progress_bar.texture_progress = preload("res://mc2robo1.png") #This is a placeholder, replace with proper texture
		progress_bar.position = Vector2(10, -30)
		add_child(progress_bar)
		p_circ = progress_bar

var rot_p = 0

@warning_ignore("unused_parameter")
func abstract_process(delta):
	if player.flip:
		rot_p = PI
	else:
		rot_p = 0
	var mouse_pos = get_local_mouse_position()
	
	if can_rot:
		get_child(0).rotation = atan2(mouse_pos.y, mouse_pos.x)
	if Input.is_action_just_pressed("SHOOT") and can_shoot and (ammo > 0 or ammo == UNLIMITED):
		player.velocity += -mouse_pos.normalized() * propulsion
		can_shoot = false
		if ammo != UNLIMITED:
			ammo -= 1
		if timer:
			timer.start(reload_time)
	if p_circ:
		p_circ.value = 100*(1 - timer.time_left/reload_time)

func abstract_switchIn():
	visible = true
	set_process(true)
	var mouse_pos = get_local_mouse_position()
	get_child(0).rotation = atan2(mouse_pos.y, mouse_pos.x)

func abstract_switchOut():
	visible = false
	set_process(false)

func abstract_reload():
	can_shoot = true
	timer.stop()

func _ready():
	abstract_ready()

func _process(delta):
	abstract_process(delta)

func switchIn():
	abstract_switchIn()

func switchOut():
	abstract_switchOut()

func reload():
	abstract_reload()
