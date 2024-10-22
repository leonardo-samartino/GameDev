extends CharacterBody2D


@export var speed = 160.0
@export var jump_velocity = -300.0

var dir
var gravity = 980

@onready var animator = $AnimatedSprite2D
@onready var run_particle = $CPUParticles2D
@onready var jump_particle = $CPUParticles2D2

var jumps = 1

func _physics_process(delta):
	
	Move(delta)
	Animations()
	
	pass


func Move(delta):
	
	dir = Input.get_axis("Left" , "Right")
	
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = 0
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_particle.restart()
	
	if Input.is_action_just_pressed("Jump") and jumps > 0:
		jumps -= 1
		velocity.y = jump_velocity
		animator.play("DoubleJump")
		jump_particle.restart()

	
	if is_on_floor():
		jumps = 1
	
	move_and_slide()
	
	
	pass

func Animations():
	
	if velocity.x != 0 and is_on_floor():
		animator.play("Run")
		run_particle.emitting = true
		
	elif velocity.x == 0 and is_on_floor():
		animator.play("Idle")
		run_particle.emitting = false
	
	
	if not is_on_floor() and jumps >= 1:
		animator.play("Jump")
		run_particle.emitting = false
	
	
	if dir > 0:
		animator.flip_h = false
	elif dir < 0:
		animator.flip_h = true
	
	pass



func _on_detection_area_body_entered(body):
	
	if body.is_in_group("Box"):
		body.Hit()
		velocity.y = jump_velocity * 1.5
	
	if body.is_in_group("Slime"):
		body.Hit()
		velocity.y = jump_velocity * 1.0
	
	pass 

