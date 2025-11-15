extends Node2D

var MOVING = 0
var t = 0

func _ready():
	get_child(0).can_move = false
	get_child(0).visible = false
	get_child(0).gun.can_rot = false
	$"Robot Dude/Camera2D".enabled = false


#re-write this later
func _process(delta):
	if MOVING == 1:
		$StaticBody2D2/CollisionShape2D.position.y -= 100*delta
	else:
		if MOVING != 2:
			get_child(0).velocity = Vector2.UP * -1000
	
	if $StaticBody2D2/CollisionShape2D.global_position.y < 509:
		MOVING = 2
		get_child(0).gun.can_rot = true
		get_child(0).can_move = true


func _on_button_pressed() -> void:
	get_child(0).visible = true
	$"../Button".disabled = true
	$"Robot Dude/Camera2D".enabled = true
	$"../Camera2D".queue_free()
	MOVING = 1
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		get_tree().change_scene_to_file("res://Main.tscn")
