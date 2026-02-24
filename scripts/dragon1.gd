extends CharacterBody2D
signal update_health
signal game_over

var speed = 33 
var directionx = 1
var directiony = 1
var time_multiplier = 1 #control time
var duration = 3 #shooting duration
var currenthealth = 100
var damage = 1
var burst_amount = 5
var alive = "yes"
var game_done = "no"

@onready var animated_sprite = $enemy
@onready var projectile = load("res://scenes/bullet1.tscn")
@onready var player = get_tree().get_nodes_in_group("player")[0]

#moving back and fourth, shooting when w pressed
func _process(delta):
	if alive == "yes":
		emit_signal("update_health", currenthealth)

		#gradual difficulty increase
		speed = speed + 0.05 * time_multiplier

		# moving x
		if position.x > 650:
			directionx = -1
		if position.x < -650:
			directionx = 1
		position.x += directionx * speed * delta * 2

		#moving y
		if global_position.y > 300:
			directiony = -1
		if global_position.y < -400:
			directiony = 1
		position.y += directiony * speed * delta

		#flippie if l or r
		if directionx < 0:
			animated_sprite.flip_h = false
		elif directionx > 0:
			animated_sprite.flip_h = true

		#attempt to not run over the player
		#yoooo this actually worked!!!! sick
		if global_position.x < 200 and global_position.x > -200 and global_position.y < 200 and global_position.y > -200:
			if global_position.y >= 150 or global_position.y <= -150:
				directiony = directiony * -1
			if global_position.y < 150 and global_position.y > -150:
				directionx = directionx * -1

#shoot in direction of player 
func _shoot():
	$lazerballs.play()
	var shoot = projectile.instantiate()
	get_tree().get_root().add_child(shoot)
	shoot.global_position = global_position
	var dir = (player.global_position - global_position).normalized()
	shoot.global_rotation = dir.angle() + PI / 2.0
	shoot.direction = dir

#cooldown timer shooting
func _on_cooldown_timeout():
	if duration > 0.5:
		duration = duration - 0.1
	$cooldown.start()
	if alive == "yes":
		for i in range(1, burst_amount + 1):
			_shoot()
			await get_tree().create_timer(0.03).timeout

#damage
func _damage():
	$damage.play()
	currenthealth -= damage
	emit_signal("update_health", currenthealth)
	set_modulate(Color(1,0,0))
	await get_tree().create_timer(.1).timeout
	set_modulate(Color(1,1,1))
	if currenthealth <= 0:
		currenthealth = 0
		_win()
		emit_signal("game_over")
		alive = "no"

#take damage
func _on_area_2d_body_entered(body):
	if game_done == "no":
		if not body.is_in_group("enemy"):
			_damage()

#win
func _win():
	game_done = "yes"
	rotate(1.57)
	position.x -= 17
	$victory.play()
	
	#falling
	for i in range(1, 101):
		position.y -= -9
		await get_tree().create_timer(.01).timeout

	#Reseting after win
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_player_game_over():
	game_done = "yes"
