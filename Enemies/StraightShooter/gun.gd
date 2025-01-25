extends Node2D
class_name NPC_Gun

@onready var bullet : PackedScene = load("res://Enemies/StraightShooter/shooter_bullet.tscn")

var gameBody : Enemy_Straight_Shooter


func Init(newbody : Enemy_Straight_Shooter):
	gameBody = newbody
	

func Shoot():
	var newBullet : Shooter_Bullet_Straight = bullet.instantiate()
	newBullet.Init(gameBody.facingRight)
	self.add_child(newBullet)
	
	if gameBody.facingRight == false:
		newBullet.position = self.global_position + (Vector2.RIGHT * 80)
	else:
		newBullet.position = self.global_position + (Vector2.LEFT * 80)
	
