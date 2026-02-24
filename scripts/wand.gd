extends Node2D
signal silence

@onready var animated_sprite = $"Elementstäbe2/AnimatedSprite2D"
@onready var projectile = load("res://scenes/fireball.tscn")
@onready var main = get_tree().get_root().get_node("game")
@onready var animated_silence = $smoke
@onready var ready_shoot = true

var shoot_speed = 800
var silences = 3

#reset sprite anim cuz idk
func _ready():
	animated_sprite.play("attack")

#lookie and shootie
func _process(delta):
	
	#update shield count
	$"../../Control/RichTextLabel3".text = str(silences)
	
	look_at(get_global_mouse_position())
	#attacking animation
	if Input.is_action_just_pressed("shoot") or Input.is_action_just_pressed("shoot2"):
		if ready_shoot == true:
			$cooldown.start()
			ready_shoot = false
			animated_sprite.play("attack")
			_shoot(delta)
	if Input.is_action_just_pressed("silence"):
			if silences > 0:
				silences = silences - 1
				$silence.play()
				emit_signal("silence")
				animated_silence.play("silenceup")
				await get_tree().create_timer(1).timeout
				animated_silence.play("silencedown")
			else:
				$click.play()

#shootie math i stole
func _shoot(delta):
	$fireball.play()
	var new_fireball = projectile.instantiate()
	var fireball_rotation = get_angle_to(get_global_mouse_position()) + self.get_rotation()
	new_fireball.set_rotation(fireball_rotation)
	new_fireball.set_global_position(self.get_global_position())
	get_parent().add_child(new_fireball)
	var rigidbody_vector = (get_global_mouse_position() - self.get_position()).normalized()
	var mouse_distance = self.get_position().distance_to(get_global_mouse_position())
	new_fireball.set_linear_velocity(rigidbody_vector * shoot_speed * mouse_distance * delta)

func _on_fireball_remove_child_fireball():
	remove_child(self)


func _on_cooldown_timeout():
	ready_shoot = true
