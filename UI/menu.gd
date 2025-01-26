extends Control

@onready var mainMenu : Control = $MarginContainer
@onready var settings : Control = $MarginContainer2
@onready var credits : Control = $MarginContainer3

func _on_play_pressed() -> void:
	self.visible=false


func _on_options_pressed() -> void:
	mainMenu.visible=false
	settings.visible=true


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	settings.visible=false
	credits.visible=true

func _on_back_pressed() -> void:
	mainMenu.visible=true
	settings.visible=false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu_button"):
		self.visible=true


func _on_back_2_pressed() -> void:
	settings.visible=true
	credits.visible=false
