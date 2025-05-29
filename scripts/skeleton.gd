extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var fall: RayCast2D = $RayCast2D

const SPEED = 1
const JUMP_VELOCITY = -320

var state
var direction = 1

enum enemyState {
	GROUND,
	AIR,
	HURT,
	ATTACK
}

func _ready() -> void:
	go_to_ground()

func _physics_process(delta: float) -> void:
	
	if ! is_on_floor():
		velocity += get_gravity() * delta
	
	match state:
		enemyState.GROUND: in_ground()
	
	move_and_slide()

func go_to_ground():
	anim.play("idle")
	state = enemyState.GROUND
	
func in_ground():
	if !fall.is_colliding():
		velocity.x = 0
		direction *= -1
		scale.x *= -1
		
	velocity.x += direction * SPEED
	
func take_damage():
	anim.play("death")
