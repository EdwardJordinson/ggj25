extends AnimatedSprite2D


var gameBody : Enemy_Straight_Shooter

func _ready() -> void:
	pass


func Init(newBody : Enemy_Straight_Shooter):
	gameBody = newBody
	

func _physics_process(delta: float) -> void:
	if gameBody.facingRight == true:
		flip_h = true
	elif gameBody.facingRight == false:
		flip_h = false
	
	
	
	if gameBody.is_on_floor() == true:
		if gameBody.velocity != Vector2.ZERO:
			play("move")
		
	
