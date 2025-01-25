extends Area2D


@export var areaToTrigger : int = 0

var isTriggered : bool = false

func _ready() -> void:
	self.area_entered.connect(TriggerArea)


func TriggerArea(body : Node2D):
	if isTriggered == false:
		GameSingleton.areaActive.emit(areaToTrigger)
		isTriggered = true
	
