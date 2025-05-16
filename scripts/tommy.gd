extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("left", "right")
	
	if ! is_on_floor():
		velocity += get_gravity() * delta
	else:
		if Input.is_action_just_pressed("jump") :
			velocity.y = JUMP_VELOCITY
		
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 0:
		anim.flip_h = !direction
		anim.play("walking")
	elif velocity.x < 0:
		anim.flip_h = direction
		anim.play("walking")
	else: 
		anim.play("idle")
	
	move_and_slide()
