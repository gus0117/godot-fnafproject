extends Node

class_name EnemyManager

@export var monitorManager : MonitorManager
var rng = RandomNumberGenerator.new()

var bonnieDict = {
	"cam1a": [0,1,6],
	"cam1b": [1,2],
	"cam2a": [1,2,3],
	"cam2b": [2],
	"cam3" : [1],
	"cam5" : [1,2]
}
var bCurrentPos = {
	"camName" : "cam1a",
	"frame" : 0,
	"animation" : "state"
}
var bNewPos = {
	"camName" : "cam1a",
	"frame" : 0,
	"animation" : "state"
}

var chicaDict = {
	"cam1a": "Show Stage",
	"cam1b": "Dining Room",
	"cam4a": "East Hall",
	"cam4b": "E. Hall Corner",
	"cam6" : "-Cam Disabled- \n*Audio Only*",
	"cam7" : "Rest Room"
}
var cCurrentPos = {
	"camName" : "cam1a",
	"frame" : 0
}
var freddyDict = {
	"cam1a": "Show Stage",
	"cam1b": "Dining Room",
	"cam4a": "East Hall",
	"cam4b": "E. Hall Corner",
	"cam6" : "-Cam Disabled- \n*Audio Only*",
	"cam7" : "Rest Room"
}
var fCurrentPos = {
	"camName" : "cam1a",
	"frame" : 0
}

var foxyDict = {
	"cam1c": "Pirate Cove",
	"cam2a": "West Hall"
}

var bonnie : Enemy = Enemy.new()
var chica : Enemy = Enemy.new()
var freddy : Enemy = Enemy.new()
var foxy : Enemy = Enemy.new()

func _ready():
	SignalManager.bTimerSignal.connect(StartBonnieTimer)

func MoveBonnie() -> void:
	var moved = true
	match (bCurrentPos.camName):
		"cam1a": 
			bNewPos.camName = "cam1b"
			bNewPos.frame = rng.randi_range(0,1);
			#check if chica move after
			if cCurrentPos.camName == "cam1a":
				cCurrentPos.frame = 2
			else:
				cCurrentPos.frame = 3
		_:
			print("No hay camara relacionada")
			moved = false
	if moved:
		var from = RoomState.new("", bCurrentPos.camName, bCurrentPos.animation, bCurrentPos.frame, false)
		var to = RoomState.new("", bNewPos.camName, bNewPos.animation, bNewPos.frame, true)
		
		SignalManager.bonnieSignal.emit(from, to)
	pass

func _on_bonnie_timer_timeout():
	print("Bonnie time")
	MoveBonnie()

func StartBonnieTimer() -> void:
	bCurrentPos = bNewPos.duplicate()
	print(bCurrentPos.camName)
	$BonnieTimer.start(3)
	#$BonnieTimer.stop()
