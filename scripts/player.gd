extends CharacterBody2D
signal game_over

var SPEED = 0
var JUMP_VELOCITY = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	
	#hide game over text unless game over
	$"you died".visible = false
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	
	#flip player correct orientation
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#play animations
	if direction == 0:
		animated_sprite.play("idle")
	if not direction == 0:
		animated_sprite.play("run")

#Game over
func _on_area_2d_body_entered(body):
	if body.is_in_group("enemy"):
		_falling_and_dying()
		set_collision_layer_value(1,false)
		emit_signal("game_over")
		$lose.play()
		$Area2D/CollisionShape2D.queue_free()

#Dying
func _falling_and_dying():
	rotate(1.57)
	position.x -= 17
	
	#falling
	for i in range(1, 125):
		position.y -= -3
		$Camera2D.zoom.x += .01
		$Camera2D.zoom.y += .01
		await get_tree().create_timer(.02).timeout
	
	#Reseting after contemplation
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_dragon_1_game_over():
	set_collision_layer_value(1,false)
