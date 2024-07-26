extends Area2D

var bspeed = 7

func die():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += Vector2(0, 1 ).rotated(self.rotation) * bspeed
	

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()
		

func _on_timer_timeout():
	queue_free()
