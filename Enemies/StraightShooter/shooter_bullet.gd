extends Area2D
class_name Shooter_Bullet_Straight

@onready var animationPlayer : AnimatedSprite2D = $AnimatedSprite2D


var speed : float = 750.0
var shootRight : bool = true
var wallContact : bool = false

func _ready() -> void:
	self.add_to_group("enemy_bullet")
	self.top_level = true
	self.body_entered.connect(ContactObject)
	self.area_entered.connect(ContactArea)
	animationPlayer.animation_finished.connect(FreeObject)
	animationPlayer.play("flying")
	if shootRight != true:
		animationPlayer.flip_h = false
	else:
		animationPlayer.flip_h = true
	


func Init(isRight : bool):
	shootRight = isRight
	


func _physics_process(delta: float) -> void:
	if wallContact == false:
		if shootRight == false:
			self.position += self.transform.x * speed * delta
		else:
			self.position -= self.transform.x * speed * delta


func Impact():
	wallContact = true
	if shootRight == false:
		rotation -= PI/2
	else:
		rotation += PI/2
	animationPlayer.play("impact")
	

func ContactObject(body : Node2D):
	if body.is_in_group("player_body") == true:
		return
	Impact()
	

func ContactArea(body : Node2D):
	if body.is_in_group("player_body") == true:
		Impact()
	

func FreeObject():
	self.queue_free()
	
