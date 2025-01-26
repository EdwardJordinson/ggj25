extends CharacterBody2D
class_name Player_Body


@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var bubbleGun : Gun = $Gun
@onready var area : Area2D = $Area2D

const SPEED = 300.0
const JUMP_VELOCITY = -700.0

var facingRight : bool = true
var iCrouching : bool = false


var breakoutCount : int = 0
var trapped = false

func _ready() -> void:
	self.add_to_group("player_body")
	area.add_to_group("player_body")
	animationPlayer.Init(self)
	bubbleGun.Init(self)
	area.area_entered.connect(BeenHit)
	
	$MainMusicPlayer.play()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift_right_key"):
		bubbleGun.Shoot()
		
	

func BeenHit(body : Node2D):
	if body.is_in_group("enemy_bullet"):
		TakeDamage()
	elif body.is_in_group("enemy_trap") and body.get_parent().isTrapping == true:
		trapped = true
		breakoutCount = 0
		$TrappedSfxPlayer.play()
		

func TakeDamage():
	GameSingleton.playerHealth -= 5
	if GameSingleton.playerHealth <= 0:
		self.queue_free()
		

func _physics_process(delta: float) -> void:
	GameSingleton.playerPosition = self.global_position
	
	if trapped == true:
		self.rotation = +PI
		animationPlayer.play("trapped")
		if Input.is_action_just_pressed("shift_right_key"):
			breakoutCount += 1
		if breakoutCount >= 5:
			trapped = false
			self.rotation = 0.0
		return
	
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
	
	if Input.is_action_pressed("down_key"):
		iCrouching = true
	else:
		iCrouching = false
	
	if iCrouching == false:
		area.position = Vector2.ZERO
		var direction := Input.get_axis("left_key", "right_key")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		area.position = Vector2.DOWN * 70
		
	move_and_slide()
	
