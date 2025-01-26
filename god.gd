extends StaticBody2D


@onready var areaZone : Area2D = $Area2D

var health : int = 30

func _ready() -> void:
	self.add_to_group("enemy_body")
	areaZone.area_entered.connect(BeenHit)
	

func BeenHit(body : Node2D):
	if body.is_in_group("player_bullet"):
		TakeDamage()
		

func TakeDamage():
	health -= 5
	if health <= 0:
		GameSingleton.end.emit()
		print("Game done")
