extends AnimatedSprite2D


var gameBody : CharacterBody2D

func _ready() -> void:
	pass


func Init(newBody : CharacterBody2D):
	gameBody = newBody
	

func _physics_process(delta: float) -> void:
	return
	#if gameBody.is_on_floor() == true:
		#if gameBody.velocity == Vector2.ZERO:
			#play("idle")
		#else:
			#play("move")
	#else:
		#play("idle")
		
	
