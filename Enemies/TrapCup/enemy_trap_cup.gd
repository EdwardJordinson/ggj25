extends CharacterBody2D

@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var hitBox : Area2D = $Area2D
@onready var strafeTimer : Timer = $Strafe_Timer
@onready var shootTimer : Timer = $Shoot_Timer
@onready var actionTimer : Timer = $Action_Timer

var health : int = 20
var speed : int = 100

var facingRight : bool = false

var currentAction : String = "idle"

var actionDone : bool = true

func _ready() -> void:
	self.add_to_group("enemy_body")
	hitBox.add_to_group("enemy_body")
	hitBox.area_entered.connect(BulletHit)
	animationPlayer.Init(self)
	actionTimer.timeout.connect(ActionDone)
	strafeTimer.timeout.connect(StrafeDone)
	shootTimer.timeout.connect(ShootDone)
	


func _physics_process(delta: float) -> void:
	#Check what direction is faced
	if velocity.x < 0:
		facingRight = true
	elif velocity.x > 0:
		facingRight = false
	
	if is_on_floor() != true:
		velocity += get_gravity() * delta
	else:
		if actionDone == true:
			NewAction()
	
	move_and_slide()
	


func NewAction():
	var randNumber : int = randi_range(0,1)
	match randNumber:
		0:
			currentAction = "move"
			Movement()
		1: 
			currentAction = "shoot"
			Shooting()
	

func Movement():
	print("moving")
	actionDone = false
	var actionTime :float = randf_range(1.5,3.0)
	actionTimer.set_wait_time(actionTime)
	actionTimer.start()
	StrafeDone()
	
	
	

func Shooting():
	print("shooting")
	actionDone = false
	var actionTime :float = randf_range(1.5,3.0)
	actionTimer.set_wait_time(actionTime)
	actionTimer.start()
	ShootDone()
	

func StrafeDone():
	var strafeTime : float = randf_range(0.5, 1.0)
	strafeTimer.set_wait_time(strafeTime)
	strafeTimer.start()
	if facingRight == true:
		self.velocity.x = 100
	else:
		self.velocity.x = -100
	

func ShootDone():
	var shootTime : float = 7.5
	shootTimer.set_wait_time(shootTime)
	shootTimer.start()
	

func ActionDone():
	actionDone = true
	


func BulletHit(body : Node2D):
	if body.is_in_group("player_bullet"):
		TakeDamage()
		

func TakeDamage():
	health -= 5
	if health <= 0:
		Killed()
	

func Killed():
	self.queue_free()
	
