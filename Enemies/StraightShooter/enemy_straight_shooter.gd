extends CharacterBody2D
class_name Enemy_Straight_Shooter

@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var gun : NPC_Gun = $Gun
@onready var hitBox : Area2D = $Area2D
@onready var strafeTimer : Timer = $Strafe_Timer
@onready var shootTimer : Timer = $Shoot_Timer
@onready var actionTimer : Timer = $Action_Timer
@onready var stunTimer : Timer = $Action_Timer

@export var areaCode : int = 0
var isActive : bool = false

var health : int = 20
var speed : int = 100

var facingRight : bool = false

var currentAction : String = "idle"

var actionDone : bool = true
var stunned : bool = false

func _ready() -> void:
	GameSingleton.areaActive.connect(setActive)
	self.add_to_group("enemy_body")
	hitBox.add_to_group("enemy_body")
	hitBox.area_entered.connect(BulletHit)
	animationPlayer.Init(self)
	animationPlayer.animation_finished.connect(AnimationDone)
	gun.Init(self)
	actionTimer.timeout.connect(ActionDone)
	strafeTimer.timeout.connect(StrafeDone)
	shootTimer.timeout.connect(ShootDone)
	stunTimer.timeout.connect(StunDone)
	stunTimer.set_wait_time(0.5)
	


func _physics_process(delta: float) -> void:
	if velocity.x < 0:
		facingRight = true
	elif velocity.x > 0:
		facingRight = false
	
	if is_on_floor() != true:
		velocity += get_gravity() * delta
	else:
		if actionDone == true and stunned == false and isActive == true:
			NewAction()
	
	move_and_slide()
	

func setActive(areaID : int):
	if areaCode == areaID:
		isActive = true
	

func NewAction():
	var randNumber : int = randi_range(0,10)
	if randNumber > 3:
		currentAction = "shoot"
		Shooting()
	else:
		currentAction = "move"
		Movement()
	

func HitStunned():
	print("stunned")
	self.velocity = Vector2.ZERO
	animationPlayer.play("hit")
	stunTimer.start()
	stunned = true
	

func Movement():
	print("moving")
	currentAction = "movement"
	actionDone = false
	var actionTime :float = randf_range(1.5,3.0)
	actionTimer.set_wait_time(actionTime)
	actionTimer.start()
	StrafeDone()
	

func Shooting():
	print("shooting")
	currentAction = "shooting"
	actionDone = false
	var actionTime :float = randf_range(1.5,3.0)
	actionTimer.set_wait_time(actionTime)
	actionTimer.start()
	ShootDone()
	

func StrafeDone():
	if currentAction == "movement" and stunned == false:
		var strafeTime : float = randf_range(0.5, 1.0)
		strafeTimer.set_wait_time(strafeTime)
		strafeTimer.start()
		if facingRight == true:
			self.velocity.x = 100
		else:
			self.velocity.x = -100
		

func ShootDone():
	if currentAction == "shooting" and stunned == false:
		animationPlayer.play("shoot")
		var shootTime : float = 1.5
		shootTimer.set_wait_time(shootTime)
		shootTimer.start()
		self.velocity.x = 0.0
		LookAtPlayer()
		

func LookAtPlayer():
	var direction = (self.global_position - GameSingleton.playerPosition)
	if direction.x > 0:
		facingRight = true
	else:
		facingRight = false
	gun.Shoot()

func StunDone():
	animationPlayer.play("idle")
	stunned = false
	

func AnimationDone():
	animationPlayer.play("idle")
	

func ActionDone():
	actionDone = true
	

func BulletHit(body : Node2D):
	if body.is_in_group("player_bullet"):
		TakeDamage()
	
	

func TakeDamage():
	health -= 5
	if health <= 0:
		Killed()
	HitStunned()
	

func Killed():
	if areaCode == 2:
		GameSingleton.areaActive.emit(3)
	self.queue_free()
	
