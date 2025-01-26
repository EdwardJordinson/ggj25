extends Node2D
class_name Gun

@onready var bullet : PackedScene = load("res://Player/bulllet.tscn")

var playerBody : Player_Body


func Init(newBody : Player_Body):
	playerBody = newBody
	

func Shoot():
	$GunSfxPlayer2D.play()
	
	var newBullet : Bullet = bullet.instantiate()
	newBullet.Init(playerBody.facingRight)
	self.add_child(newBullet)
	
	if playerBody.facingRight == false:
		newBullet.position = self.global_position + (Vector2.RIGHT * 80)
	else:
		newBullet.position = self.global_position + (Vector2.LEFT * 80)
