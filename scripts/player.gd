extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -320

enum playerState {
	GROUND,
	AIR,
	HURT,
	ATTACK,
	DUCK
}

var state

func _ready() -> void:
	go_to_ground()

func _physics_process(delta: float) -> void:
	
	if ! is_on_floor():
		velocity += get_gravity() * delta
		
	match state:
		playerState.GROUND: in_ground()
		playerState.AIR: in_air()
		playerState.DUCK: in_duck()
	
	move_and_slide()

func go_to_ground():
	state = playerState.GROUND
	

func in_ground():
	var direction := Input.get_axis("left", "right")
	
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
		
	if Input.is_action_just_pressed("crouch"):
		go_to_duck()
		
	if Input.is_action_just_pressed("jump") :
		velocity.y = JUMP_VELOCITY
		go_to_air()
			
	if ! is_on_floor():
		go_to_air()
	

func go_to_air():
	if velocity.y < 0:
		anim.play("jump")
		state = playerState.AIR
	elif velocity.y > 0:
		anim.play("fall")
		state = playerState.AIR
	

func in_air():
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if velocity.x > 0:
		anim.flip_h = !direction
	elif velocity.x < 0:
		anim.flip_h = direction
		
	if velocity.y < 0:
		anim.play("jump")
	elif velocity.y > 0:
		anim.play("fall")
		
	if is_on_floor():
		go_to_ground()
	

func go_to_hurt():
	anim.play("hurt")
	state = playerState.HURT
	

func in_hurt():
	pass
	

func go_to_attack():
	anim.play("attack_in_ground")
	state = playerState.ATTACK
	

func in_attack():
	pass
	

func go_to_duck():
	anim.play("duck")
	state = playerState.DUCK
	

func in_duck():
	velocity.x = 0
	if Input.is_action_just_released("crouch"):
		go_to_ground()
	
