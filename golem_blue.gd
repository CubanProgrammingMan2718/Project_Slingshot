extends CharacterBody2D

var player = null

var jump_cooldown = 3

var jump = false
var moving = true

func _ready():
	for node in get_parent().get_children():
		if node.is_in_group("Player"):
			player = node;
			break
	$AnimatedSprite2D.play("default")


func _process(delta):
	if player:
		var dir = (player.position.x - position.x)
		$AnimatedSprite2D.flip_h = sign(dir) == -1
		velocity.x += dir * delta
		if not jump:
			velocity = Vector2(sign(player.position.x - position.x) * 1000, -600)
			jump = true
	if jump:
		jump_cooldown -= delta
		if jump_cooldown < 0:
			jump = false
			jump_cooldown = 3

		
	velocity.y += 500 * delta
	move_and_slide()
	$AnimatedSprite2D.speed_scale = velocity.x/1000
