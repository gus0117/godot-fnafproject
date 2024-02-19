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

func MoveBonnie() -> void:
	#1st Move: Quit from show stage
	#monitorManager.ChangeCamFrame("cam1a",2)
	#monitorManager.ChangeCamFrame("cam1b",1)
	
	#2nd Move: From dining to another location (except show stage)
	pass

func _on_bonnie_timer_timeout():
	$BonnieTimer.stop()
	if bCurrentPos.camName == "cam1a":
		#It is first move
		SignalManager.bonnieSignal.emit("cam1a", 2)
		SignalManager.bonnieSignal.emit("cam1b", 1, "cam1a")
	
	#Reactivar el timer
	$BonnieTimer.start(3)
