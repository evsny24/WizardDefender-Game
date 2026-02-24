extends RigidBody2D

#when to delete itself
func _on_area_2d_body_entered(body):
	if body.is_in_group("drag"):
		queue_free()
	if body.is_in_group("enemy"):
		queue_free()

func _on_life_timeout():
	queue_free()
