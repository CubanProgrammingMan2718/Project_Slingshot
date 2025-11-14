extends Panel

var T = 0

func _ready():
	modulate = Color(1, 1, 1, 0)


func _process(delta):
	modulate = Color(1,1,1,T)
	T += delta
	position.y -= delta * 10
	
