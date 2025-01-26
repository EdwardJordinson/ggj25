extends Node

var player : CharacterBody2D
var playerPosition : Vector2 = Vector2.ZERO

func _spawn_trap_cup():
	var mainScene = get_node("/root/Main")
	var cupTemplate = load("res://Enemies/TrapCup/enemy_trap_cup.tscn")
	var cup = cupTemplate.instantiate()
	mainScene.add_child(cup)
	
func _remove_all_enemies():
	var shooter = get_node("/root/Main/Enemy_Straight_Shooter")
	if (shooter):
		shooter.get_parent().remove_child(shooter)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("spawn_trap_cup"):
		_remove_all_enemies()
		_spawn_trap_cup()
