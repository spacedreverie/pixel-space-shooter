extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnerPeriod
@onready var enemy_container = $MobsContainer
@onready var hud = $UI/HUD_sys
@onready var gameover = $UI/restart_overlay
@onready var pbg  = $Parallax
@onready var pause_ui = $UI/Pause
@onready var sfxover = $gameoverplayer

var paused = false
var startmenuoverlay = false

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score

var scroll_spd = 100

func _ready():
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.laser_shot.connect(_on_player_laser_shot)
	player.dead.connect(_on_player_dead)
	if score > 1000:
		pass
		
	
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("pause"):
		pauseActive()
	pbg.scroll_offset.y += delta*scroll_spd

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)

func _on_enemy_spawner_period_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(0, 520),50)
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)

	
func _on_enemy_killed(scoring):
	score += scoring
	print(score)
	

func _on_player_dead():
	gameover.set_score(score)
	await get_tree().create_timer(.5).timeout
	gameover.visible =  true
	sfxover.play()

func pauseActive():
	if paused:
		pause_ui.hide()
		Engine.time_scale = 1 
	else:
		pause_ui.show()
		Engine.time_scale = 0
		
	paused = !paused
