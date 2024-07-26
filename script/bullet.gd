extends Node2D

const speed = 100

func _process(delta):
	position += transform.x * speed * delta

func _on_Kill_cd_timeout() -> void:
	queue_free()
