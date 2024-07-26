extends CharacterBody2D


@export var speed = 50
var player_chase = false
var player = null

signal killed

func _physics_process(delta):
	global_position.y += speed * delta
	if player_chase:
		position += (player.position - position) / speed



func _on_findplayer_body_entered(body):
	player = body
	player_chase = true


func _on_findplayer_body_exited(body):
	player = body
	player_chase = false



func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
	#deletes enemy outside screen bounds

func _on_timer_timeout():
	queue_free()
