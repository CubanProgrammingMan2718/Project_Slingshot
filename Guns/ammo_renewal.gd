extends Area2D

@export var ammo_num = 5

func _process(delta): 
	pass
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var gun = (body.gun_set.get_child(body.curr_gun))
		gun.ammo = min(gun.max_ammo, gun.ammo + ammo_num)
		gun.ammo_lab.text = str(gun.ammo)
