extends AnimatedSprite2D


var gameBody : CharacterBody2D

func _ready() -> void:
	pass


func Init(newBody : CharacterBody2D):
	gameBody = newBody
	

func _physics_process(delta: float) -> void:
	if gameBody.facingRight == true:
		flip_h = true
	elif gameBody.facingRight == false:
		flip_h = false
	
	
	
	if gameBody.is_on_floor() == true:
		if gameBody.velocity == Vector2.ZERO:
			play("idle")
		else:
			play("move")
	else:
		play("idle")
		
	
