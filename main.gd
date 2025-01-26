extends Node


@onready var moviePlayer : VideoStreamPlayer = $CanvasLayer/Movieplayer/VideoStreamPlayer
@onready var movieNode : Control = $CanvasLayer/Movieplayer
@onready var menu : Control = $CanvasLayer/Menu
@onready var ui : Control = $CanvasLayer/Ui

@onready var endNode : Control = $CanvasLayer/EndMovie
@onready var endPlayer : VideoStreamPlayer = $CanvasLayer/EndMovie/VideoStreamPlayer


func _ready() -> void:
	moviePlayer.finished.connect(movieDone)
	endPlayer.finished.connect(finished)
	GameSingleton.end.connect(startEnd)
	


func movieDone():
	movieNode.visible = false
	


func startEnd():
	endNode.visible = true
	endPlayer.play()
	

func finished():
	get_tree().quit()
