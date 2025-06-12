extends CharacterBody2D


enum EnemyState {
	andando,
	atacando,
	morto
}

var speed = 20.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

@onready var collision_shape_2d: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var fall_detect: RayCast2D = $FallDetect

@onready var player_detect: RayCast2D = $PlayerDetect
@onready var terrain: RayCast2D = $terrain
@onready var attack_area: Area2D = $AttackArea


var direction = 1

var status: EnemyState

func _ready() -> void:
	attack_area.process_mode = Node.PROCESS_MODE_DISABLED
	ir_para_andando()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	match status:
		EnemyState.andando:
			andando()
		EnemyState.atacando:
			atacando()
		EnemyState.morto:
			morto()

	move_and_slide()

func ir_para_andando():
	status = EnemyState.andando
	anim.play("andando")

func andando():
	if !fall_detect.is_colliding():
		direction = direction * -1
		scale.x *= -1
		
	velocity.x = speed * direction
	
	if player_detect.is_colliding():
		ir_para_atacando()

func ir_para_atacando():
	status = EnemyState.atacando
	velocity.x = 0
	anim.play("atacando")

func atacando():
	if anim.frame == 2:
		attack_area.process_mode = Node.PROCESS_MODE_INHERIT
	else:
		attack_area.process_mode = Node.PROCESS_MODE_DISABLED

func ir_para_morto():
	status = EnemyState.morto
	velocity.x = 0
	anim.play("morto")
	hitbox.queue_free()
	collision_shape_2d.queue_free()
	
func morto():
	pass

func take_damage():
	ir_para_morto()


func _on_animated_sprite_2d_animation_finished() -> void:
	if anim.animation == "atacando":
		ir_para_andando()


func _on_attack_area_area_entered(area: Area2D) -> void:
	area.take_damage()
