extends Node2D

@export var hp = 1
@onready var sfx_danmaku = $danmaku

signal killed(scoring)

var bullet_scene = load("res://scene/enemy_bullet.tscn")

func _ready():
	$Timer.start()

func _process(delta):
	rotate(30)
	spawn_bullet()
	sfx_danmaku.play()

func spawn_bullet():
	var b1 = bullet_scene.instantiate()
	b1.position = self.position
	b1.rotation = self.rotation
	get_parent().add_child(b1)
	

func _spawn_timeout():
	die()

func die():
	queue_free()
	
