extends CharacterBody2D
class_name Player_Body


@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var bubbleGun : Gun = $Gun

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var facingRight : bool = true

func _ready() -> void:
	self.add_to_group("player_body")
	animationPlayer.Init(self)
	bubbleGun.Init(self)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift_right_key"):
		bubbleGun.Shoot()
		
	

func _physics_process(delta: float) -> void:
	GameSingleton.playerPosition = self.global_position
	
	#Check what direction is faced
	if velocity.x < 0:
		facingRight = true
	elif velocity.x > 0:
		facingRight = false
	
	
	if is_on_floor() != true:
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("space_key") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var direction := Input.get_axis("left_key", "right_key")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
