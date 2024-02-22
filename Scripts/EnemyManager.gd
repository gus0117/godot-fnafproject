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

var auxRoom : Room

func _ready():
	SignalManager.bTimerSignal.connect(StartBonnieTimer)
	auxRoom = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	bonnie.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	chica.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	freddy.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)

func MoveEnemy(e : Enemy) -> void:
	var moved = true
	auxRoom = DuplicateRoom(e.pos)
	match (e.pos.camName):
		"cam1a": 
			e.pos.name = "cam1b"
			#e.pos.animation.frame = rng.randi_range(1,2);
			e.pos.animation.frame = 1
			#chica dont move yet
			if chica.pos.camName == "cam1a":
				auxRoom.animation.frame =  3
			else: # Chica has moved
				auxRoom.animation.frame = 4
		_:
			print("No hay camara relacionada")
			moved = false
	if moved:
		SignalManager.bonnieSignal.emit(auxRoom, e.pos)
	pass

func _on_bonnie_timer_timeout():
	print("Bonnie time")
	MoveEnemy(bonnie)

func DuplicateRoom(room : Room) -> Room:
	return Room.new(room.name, room.camName, AnimationState.new(room.animation.name, room.animation.amountFrames, room.animation.isPlayable), room.isEmpty)

func StartBonnieTimer() -> void:
	bCurrentPos = bNewPos.duplicate()
	print(bCurrentPos.camName)
	$BonnieTimer.start(3)
	#$BonnieTimer.stop()
