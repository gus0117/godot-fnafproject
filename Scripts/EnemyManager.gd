extends Node

class_name EnemyManager

"""
Night 1
Bonnie and Chica attack, and Foxy if the player don't look 'Pirate Cove' Cam or is idle

Bonnie 
	-Path 1: Stage, Dining, West Hall, West Hall Corner, Left Door
	cam1a, cam1b
"""
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
	"frame" : 0
}
var bNewPos = {
	"camName" : "cam1a",
	"frame" : 0
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

func _ready():
	SignalManager.bTimerSignal.connect(StartBonnieTimer)

func MoveBonnie() -> void:
	var moved = true
	match (bCurrentPos.camName):
		"cam1a": 
			#check if chica move after
			bNewPos.camName = "cam1b"
			bNewPos.frame = rng.randi_range(0,1);
		_:
			print("No hay camara relacionada")
			moved = false
	if moved:
		SignalManager.bonnieSignal.emit(bCurrentPos, bNewPos)
	pass

func _on_bonnie_timer_timeout():
	print("Bonnie time")
	MoveBonnie()

func StartBonnieTimer() -> void:
	bCurrentPos = bNewPos.duplicate()
	print(bCurrentPos.camName)
	$BonnieTimer.start(3)
	#$BonnieTimer.stop()
