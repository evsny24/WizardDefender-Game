extends RigidBody2D

var direction : Vector2 = Vector2.LEFT
var speed : float = 300

#we movin
func _process(delta):
	translate(direction*speed*delta)
	speed = speed + 1.05 * delta

#now I believe this is useless
func _on_timer_timeout():
	queue_free()

#block or ouchie
func _on_area_2d_body_entered(body):
	if body.is_in_group("shield"):
		queue_free()
	if body.is_in_group("player"):
		queue_free()

func _on_player_game_over():
	queue_free()
