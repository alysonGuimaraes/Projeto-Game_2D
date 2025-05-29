extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var fall_detect: RayCast2D = $fall_detect
@onready var player_detect: RayCast2D = $player_detect
@onready var damage_area_attack: Area2D = $damage_area_attack

const SPEED = 15
const JUMP_VELOCITY = -320

var state
var direction = 1

enum enemyState {
	IDLE,
	WALK,
	JUMP,
	FALL,
	ATTACK
}

func _ready() -> void:
	damage_area_attack.process_mode = Node.PROCESS_MODE_DISABLED
	go_to_walk()

func _physics_process(delta: float) -> void:
	
	if ! is_on_floor():
		velocity += get_gravity() * delta
	
	match state:
		enemyState.WALK: in_walk()
		enemyState.ATTACK: in_attack()
	
	move_and_slide()
	
func go_to_idle():
	anim.play("idle")
	state = enemyState.IDLE
	
func in_idle():
	pass

func go_to_walk():
	anim.play("walk")
	state = enemyState.WALK
	
func in_walk():
	if !fall_detect.is_colliding():
		direction = direction * -1
		scale.x *= -1
		
	if player_detect.is_colliding():
		go_to_attack()
		
	velocity.x = SPEED * direction
	
func go_to_attack():
	anim.play("attack")
	velocity.x = 0
	state = enemyState.ATTACK
	
func in_attack():
	if anim.frame == 2:
		damage_area_attack.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		damage_area_attack.process_mode = Node.PROCESS_MODE_DISABLED
		
	if ! player_detect.is_colliding():
		go_to_walk()
	
func take_damage():
	direction = 0
	anim.play("death")


func _on_damage_area_attack_area_entered(area: Area2D) -> void:
	area.take_damage()
