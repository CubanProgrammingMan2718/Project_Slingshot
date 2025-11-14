extends Area2D

var ammo_num = 5

func _process(delta): 
	pass
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		(body.gun_set.get_child(body.curr_gun)).ammo += ammo_num
