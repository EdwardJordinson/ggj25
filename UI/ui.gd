extends Control


@onready var title : RichTextLabel = $PanelContainer/VBoxContainer/RichTextLabel
@onready var textLine : Label = $PanelContainer/VBoxContainer/RichTextLabel2

@onready var textTimer : Timer = $Text_Timer
@onready var holdTimer : Timer = $Hold_Timer

var currentTimingDict : Dictionary
var defaultTiming : float
var currentArray : int

#Max character count 118
var textArray1 : Array[String] = [
	"Hello there!",#0
	"Welcome to Boba Bubble Blast!",#1
	"Where the boba are bubbles and they blast! ...",#2
	"...Who wrote this crap?",#3
	"...Anyway. Use the WASD keys to move our heroin around!",#4
	"Her name is Jill. This world is her boba bubble dream and its your job to help her make it out safely!",#5
	"Harness the power of bubbles. And lay down the hurt on the bubble tea gang.",#6
	"'Pfft', the bubble tea gang? You can't be serious."#7
	
]

var timingDict1 : Dictionary = {
	2 : [[28,29,43],[1.0,0.01,0.8]],
	4 : [[11,12],[0.9,0.05]],
	5 : [[18,19],[1.0,0.05]],
	7 : [[0,7,8,29,30],[0.01,1.0,0.05,1.0,0.05]]
}

var textArray2 : Array[String] = [
	"EW! WHAT THE FUCK IS THAT THING?!!!",#0
	"KILL IT! [SHIFT]! PRESS [SHIFT] TO SHOOT!",#1
	"DON'T JUST STAND THERE! DO SOMETHING!",#2
	"WHAT ARE YOU WAITING FOR?!!!",#3
	"JUST PRESS [SHIFT] ALREADY AND KILL THAT THING!"#4
	
]

var timingDict2 : Dictionary = {
	0 : [[4,5],[1.5,0.01]],
	1 : [[9,10,18,19,42],[1.5,0.01,1.0,0.01,1.5]],
	2 : [[24,25],[1.0,0.01]]
}

var textArray3 : Array[String] = [
	"Is it dead? I think its dead...",#0
	"What the hell WAS that thing? Some. Kind of boba tea monster?",#1
	"Thank goodness we were here though.",#2
	"Who knows what would have happened to Jill if we were'nt here to help.",#3
	"Do you know what that thing was Jill? Its your dream after all.",#4
	"...Jill?",#5
	"She must be in shock. We should'nt push her on it.",#6
	"We need to get out of here regardless, lets keep moving and find a way out."#7
	
]

var timingDict3 : Dictionary = {
	0 : [[12,13],[1.0,0.05]],
	1 : [[14,15,18,30,31,36,37],[0.1,0.01,0.1,1.0,0.01,1.0,0.05]],
	4 : [[38,39],[1.0,0.05]],
	5 : [[0,4],[1.0,0.05]],
	6 : [[22,23],[1.0,0.05]]
	
}

var textArray4 : Array[String] = [
	"No way. Two more?!",
	"That one JUMPING?! WHAT IS WRONG WITH THIS PLACE!",
	"Dont let it land on you!"
	
]

var timingDict4 : Dictionary = {
	
	
}

var textArray5 : Array[String] = [
	"The way up looks be it.",
	"Lets get out of here",
	"What is wrong with you Jill anyway?",
	"Why are you obsessed with bubble tea?",
	"I think you have a problem"
	
]

var timingDict5 : Dictionary = {
	
	
}

var textArray6 : Array[String] = [
	"Oh look, its a bubble tea god.",
	"Of course a bubble tea god would be here.",
	"Uh hello? God? Can you help us out?",
	
	
]

var timingDict6 : Dictionary = {
	
	
}

#God talking
var textArray7 : Array[String] = [
	"YOU HAVE KILLED MY CHILDREN!",
	"FOR THIS, I DECREE...",
	"YOU SHALL NOW DIE!"
	
]

var timingDict7 : Dictionary = {
	
	
}

#Voice talking
var textArray8 : Array[String] = [
	"I dont know what to do, shoot it and Jill might wake up.",
	"Or not, anything will be better than staying here honestly"
	
]

var timingDict8 : Dictionary = {
	
	
}

func _ready() -> void:
	GameSingleton.areaActive.connect(SetMessage)
	

func SetMessage(arrayToRead : int):
	match arrayToRead:
		1:
			defaultTiming = 0.05
			currentArray = 1
			currentTimingDict = timingDict1
			Start(textArray1, 1)
		2:
			defaultTiming = 0.01
			currentArray = 2
			currentTimingDict = timingDict2
			Start(textArray2, 2)
		3:
			defaultTiming = 0.05
			currentArray = 3
			currentTimingDict = timingDict3
			Start(textArray3, 3)
		4:
			defaultTiming = 0.05
			currentArray = 4
			currentTimingDict = timingDict4
			Start(textArray4, 4)
		5:
			defaultTiming = 0.05
			currentArray = 5
			currentTimingDict = timingDict5
			Start(textArray5, 5)
		6:
			defaultTiming = 0.05
			currentArray = 6
			currentTimingDict = timingDict6
			Start(textArray6, 6)
		7:
			defaultTiming = 0.05
			currentArray = 7
			currentTimingDict = timingDict7
			Start(textArray7, 7)
		8:
			defaultTiming = 0.05
			currentArray = 8
			currentTimingDict = timingDict8
			Start(textArray8, 8)
			

func Start(stringArray : Array[String], arrayNum : int):
	for index in stringArray.size():
		if currentArray != arrayNum:
			return
		textLine.text = stringArray[index]
		await TextLoop(index, stringArray[index], arrayNum)
	if arrayNum == 6:
		title.text = "Bubble Tea God:"
		SetMessage(7)
	elif arrayNum == 7:
		title.text = "Voice:"
		SetMessage(8)

func TextLoop(lineCount : int, text : String, arrayNum : int):
	textTimer.set_wait_time(defaultTiming)
	for index in text.length()+1:
		if currentArray != arrayNum:
			return
		ChangeTiming(lineCount, index)
		textTimer.start()
		await textTimer.timeout
		textTimer.stop()
		textLine.visible_characters = index
	textTimer.set_wait_time(defaultTiming)
	holdTimer.start()
	await holdTimer.timeout
	textLine.visible_characters = 0
	holdTimer.stop()
	


func ChangeTiming(lineCount : int, charCount : int):
	if currentTimingDict.has(lineCount) == true:
		if currentTimingDict[lineCount][0].has(charCount) == true:
			var index = currentTimingDict[lineCount][0].find(charCount,0)
			textTimer.set_wait_time(currentTimingDict[lineCount][1][index])
			
		
		
