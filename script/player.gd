class_name Player extends CharacterBody2D


@export var speed = 400
@export var fire_rate = .3
@onready var muzzle = $Muzzle
@onready var sfx_shot = $shot
@onready var sfx_player_dead = $deadplayer
signal laser_shot(laser_scene, location)
signal dead

var laser_scene = preload("res://scene/laser.tscn")

var shoot_cd := false


func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(fire_rate).timeout
			shoot_cd = false

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	velocity = direction * speed
	move_and_slide()

	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position) 
	sfx_shot.play()
	

func die():
	sfx_player_dead.play()
	dead.emit() 
	queue_free()
