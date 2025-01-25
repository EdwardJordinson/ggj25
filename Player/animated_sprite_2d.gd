extends AnimatedSprite2D
class_name Animator

var playerbody : Player_Body


func _ready() -> void:
	animation_finished.connect(AnimationDone)
	


func Init(newBody):
	playerbody = newBody
	


func _physics_process(delta: float) -> void:
	var bodyVelocity : Vector2 = playerbody.velocity
	
	if playerbody.facingRight == true:
		flip_h = true
	elif playerbody.facingRight == false:
		flip_h = false
	
	
	if playerbody.is_on_floor() != true:
		if bodyVelocity.y < 0:
			if animation != "air_accent":
				play("air_accent")
		else:
			if animation != "air_deccent":
				play("air_deccent")
	else:
		if bodyVelocity == Vector2.ZERO:
			play("ground_stopped")
		else:
			play("ground_moving")
		if playerbody.iCrouching == true:
			play("ground_crouch")
			
		
	


func AnimationDone():
	pass
	
