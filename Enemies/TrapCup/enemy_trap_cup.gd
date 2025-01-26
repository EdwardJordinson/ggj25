extends CharacterBody2D
class_name Enemy_Trap_Cup

@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var hitBox : Area2D = $Area2D
@onready var shakeTimer : Timer
#@onready var shootTimer : Timer = $Shoot_Timer
@onready var actionTimer : Timer

var health : int = 20
var speed : int = 100

var facingRight : bool = false

var currentAction : String = "idle"

var actionDone : bool = true

func _ready() -> void:
	actionTimer = Timer.new()
	shakeTimer = Timer.new()
	
	self.add_to_group("enemy_body")
	hitBox.add_to_group("enemy_body")
	hitBox.area_entered.connect(BulletHit)
	animationPlayer.Init(self)
	animationPlayer.animation_finished.connect(AnimationFinished)
	actionTimer.timeout.connect(ActionDone)
	#shakeTimer.timeout.connect(ShakeDone)
	#shootTimer.timeout.connect(ShootDone)
	


func _physics_process(delta: float) -> void:
	#print("in _physics_process is_on_floor():", is_on_floor())
	if !is_on_floor():
		velocity += get_gravity() * delta
	else:
		if actionDone == true:
			NewAction()
	#Check what direction is faced
	#if velocity.x < 0:
		#facingRight = true
	#elif velocity.x > 0:
		#facingRight = false
	
	move_and_slide()
	


func NewAction():
	var randNumber : int = randi_range(0,1)
	match randNumber:
		0:
			currentAction = "shake"
			Shake()
		#1: 
			#currentAction = "shake"
			#Shooting()
	

func Shake():
	print("trap cup is shaking")
	if (!is_instance_valid(GameSingleton.player)):
		# The player is dead.
		return
		
	# The player is alive; try to jump on them.
	animationPlayer.play("shake")
	actionDone = false
	shakeTimer.set_wait_time(2)
	shakeTimer.start()
	
#func ShakeDone():
	#jumpTimer.set_wait_time(strafeTime)
	#jumpTimer.start()
	#if facingRight == true:
		#self.velocity.x = 100
	#else:
		#self.velocity.x = -100
	
	

#func Shooting():
	#print("shooting")
	#actionDone = false
	#var actionTime :float = randf_range(1.5,3.0)
	#actionTimer.set_wait_time(actionTime)
	#actionTimer.start()
	#ShootDone()
#
#func ShootDone():
	#var shootTime : float = 7.5
	#shootTimer.set_wait_time(shootTime)
	#shootTimer.start()
	

func ActionDone():
	actionDone = true
	

func AnimationFinished():
	print("anim finished")

func BulletHit(body : Node2D):
	if body.is_in_group("player_bullet"):
		TakeDamage()
		

func TakeDamage():
	health -= 5
	if health <= 0:
		Killed()
	

func Killed():
	self.queue_free()
	
