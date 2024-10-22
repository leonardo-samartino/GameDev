extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

@export var speed = 40.0
@export var range = 1

var dirX = -2
var life = 3

func _ready():
	
	$Timer.wait_time = range
	
	pass


func _physics_process(delta):
	
	Move(delta)
	
	pass


func Move(delta):
	
	velocity.x = dirX * speed
	
	move_and_slide()
	
pass



func ChangeSide():
	
	if dirX == 2:
		dirX = -2
		anim.flip_h = false
	else:
		dirX = 2
		anim.flip_h = true
	
	pass


func _on_timer_timeout():
	
	ChangeSide()
	
	pass 



func Hit():
	
	anim.play("Hit")
	speed = 0
	life -= 1
	await get_tree().create_timer(0.4).timeout
	anim.play("Idle")
	speed = 20
	
	if life <= 0:
		queue_free()
	
	pass




func _on_area_2d_body_entered(body):
	
	
	if body.name == "Player":
		
		Global.life -= 1
		
	
	
	
	pass
