class_name Enemy extends Area2D

@export var speed = 200
@export var hp = 6
@export var scoring = 100
@export var particleDeath : PackedScene	
@onready var sfx_hurt = $enemyhurt
@onready var sfx_dead = $enemydead



signal killed(scoring)

func _physics_process(delta):
	global_position.y +=speed * delta

func die():
	queue_free()


func _on_body_entered(body):
	if body is Player:
		body.die()
		die()
		

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
	#deletes enemy outside screen bounds

func	damage_taken(amount):
	sfx_hurt.play()
	hp -= amount
	if hp <= 0:
		sfx_dead.play()
		killed.emit(scoring)
		die()
	
