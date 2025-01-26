extends CharacterBody2D
class_name JumpCup


@onready var timeDelay : Timer = $Timer
@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D
@onready var areaZone : Area2D = $Area2D

@export var areaCode : int = 0

var isActive : bool = true

var health : int = 20

var actionDone : bool = true
var stunned : bool = false

var isTrapping : bool = false
var isTrapped : bool = false

func _ready() -> void:
	self.add_to_group("enemy_trap")
	areaZone.add_to_group("enemy_trap")
	areaZone.area_entered.connect(BulletHit)
	timeDelay.timeout.connect(Active)
	animationPlayer.animation_finished.connect(AnimDone)
	

func _physics_process(delta: float) -> void:
	if isTrapped == true:
		TrapMode(delta)
		return
	
	
	if is_on_floor() != true:
		JumpFalling(delta)
	else:
		if actionDone == true and stunned == false and isActive == true:
			TryJump(delta)
	
	move_and_slide()
	


func TrapMode(delta):
	animationPlayer.play("idle")
	rotation = PI
	velocity += Vector2.DOWN * 300 * delta
	self.visible = false
	

func setActive(areaID : int):
	if areaCode == areaID:
		isActive = true
	

func Active():
	actionDone = true
	

func TryJump(delta):
	rotation = 0.0
	velocity = Vector2.ZERO
	animationPlayer.play("jump")
	
	

func JumpFalling(delta):
	isTrapping = true
	velocity += Vector2.DOWN * 300 * delta
	rotation = velocity.angle() + PI/2
	

func AnimDone():
	velocity = Vector2.UP * 400
	var playerPos = GameSingleton.playerPosition
	var playerDir : Vector2 = (playerPos - self.global_position)
	velocity += playerDir
	actionDone = false
	timeDelay.start()
	


func BulletHit(body : Node2D):
	if body.is_in_group("player_bullet"):
		TakeDamage()
	elif body.is_in_group("player_body") and isTrapping == true:
		isTrapped = true
	

func TakeDamage():
	health -= 5
	if health <= 0:
		self.queue_free()
	
