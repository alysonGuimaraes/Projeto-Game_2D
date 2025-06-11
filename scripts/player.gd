extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
const MAGICAL_ORB = preload("res://entities/magical_orb.tscn")

const SPEED = 200.0
const JUMP_VELOCITY = -400

var damage_count = 3
var last_direction = 1

enum playerState {
	IDLE,
	WALK,
	JUMP,
	FALL,
	HURT,
	ATTACK,
	DUCK
}

var state: playerState

func _ready() -> void:
	go_to_idle()

func _physics_process(delta: float) -> void:
	
	if ! is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("shot"):
		var new_orb = MAGICAL_ORB.instantiate()
		new_orb.position = position
		new_orb.direction = last_direction
		add_sibling(new_orb)
		
		
	match state:
		playerState.IDLE: in_idle()
		playerState.WALK: in_walk()
		playerState.JUMP: in_jump()
		playerState.FALL: in_fall()
		playerState.DUCK: in_duck()
		playerState.ATTACK: pass
		playerState.HURT: in_hurt()
	
	move_and_slide()
	
func go_to_idle():
	state = playerState.IDLE
	anim.play("idle")
	

func in_idle():
	move()
	
	if velocity.x != 0:
		go_to_walk()
		return
		
	if Input.is_action_just_pressed("jump"):
		go_to_jump()
		return
		
	if ! is_on_floor():
		go_to_fall()
		return
	

func go_to_walk():
	anim.play("walking")
	state = playerState.WALK
	

func in_walk():
	move()
	
	if velocity.x == 0:
		go_to_idle()
		return
		
	if Input.is_action_just_pressed("crouch"):
		go_to_duck()
		return
		
	if Input.is_action_just_pressed("jump") :
		go_to_jump()
		return
			
	if ! is_on_floor():
		go_to_fall()
		return
	

func go_to_jump():
	anim.play("jump")
	velocity.y += JUMP_VELOCITY
	state = playerState.JUMP
	

func in_jump():
	move()
	
	if velocity.x != 0 and is_on_floor():
		go_to_walk()
	elif velocity.x == 0 and is_on_floor():
		go_to_idle()
		

func go_to_fall():
	anim.play("fall")
	state = playerState.FALL
	

func in_fall():
	move()
	
	if velocity.x != 0 and is_on_floor():
		go_to_walk()
	elif velocity.x == 0 and is_on_floor():
		go_to_idle()
	

func go_to_hurt():
	anim.play("hurt")
	state = playerState.HURT
	

func in_hurt():
	if damage_count > 0:
		call_deferred("reload_scene")
		damage_count == 3
		
	damage_count -= 1
	

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
		go_to_idle()
	

func move():
	var direction := Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
		last_direction = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if velocity.x > 0:
		anim.flip_h = !direction
	elif velocity.x < 0:
		anim.flip_h = direction
	

func take_damage():
	go_to_hurt()
	
	
func reload_scene():
	get_tree().reload_current_scene()
	
