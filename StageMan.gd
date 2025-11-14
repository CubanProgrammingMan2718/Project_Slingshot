extends Node2D

var paused : bool = false

var prev_time_scale = 1

var osc = 0

@onready var start_color = modulate;
var end_color
const PULSE_INTENSITY = 1.2

var t_extra = 0
var should_extra = false

#This is probably unstable, find better later
func pulse(delta):
	osc += 4*delta
	modulate *= PULSE_INTENSITY**(sin(osc) * delta) 

func call_extrapolate(color : Color):
	t_extra = 0
	should_extra = true
	end_color = color
	start_color = modulate

func extrapolate(delta):
	t_extra += 10*delta
	if t_extra >= 10:
		should_extra = false
		t_extra = 10
		start_color = end_color
	
	modulate = (end_color - start_color) * (t_extra/10) + start_color

func _process(delta):
	if should_extra:
		extrapolate(delta)
	else:
		pulse(delta)
	
	if Input.is_action_just_pressed("PAUSE"):
		if !paused:
			for child in get_children():
				child.set_process(false)
			prev_time_scale = Engine.time_scale
			Engine.time_scale = 0
		else:
			for child in get_children():
				child.set_process(true)
			Engine.time_scale = prev_time_scale
		paused = !paused
	
	
