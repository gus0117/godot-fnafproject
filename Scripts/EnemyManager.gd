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
	SignalManager.bTimerSignal.connect(StartEnemiesTimer)
	auxRoom = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	bonnie.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	chica.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	freddy.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)

func MoveBonnie(e : Enemy) -> void:
	var moved = true
	auxRoom = DuplicateRoom(e.pos)
	match (e.pos.camName):
		"cam1a": 
			e.pos.camName = "cam1b"
			e.pos.animation.frame = rng.randi_range(1,2);
			#chica dont move yet
			if chica.pos.camName == "cam1a":
				auxRoom.animation.frame = 2
			else: # Chica has moved
				auxRoom.animation.frame = 3
		"cam1b":
			var r = rng.randf()
			if r > 0.5 :
				e.pos.camName = "cam5"
				e.pos.animation.frame = 1
			else:
				e.pos.camName = "cam2a"
				e.pos.animation.frame = 2
			auxRoom.animation.frame = 0
		"cam2a":
			var r = rng.randf()
			if r < 0.3333:
				#check if cam1b is empty
				if chica.pos.camName == "cam1b" or freddy.pos.camName == "cam1b":
					moved = false
				else:
					e.pos.camName = "cam1b"
					e.pos.animation.frame = rng.randi_range(1,2)
			elif r > 0.3333 and r < 0.6666:
				e.pos.camName = "cam3"
				e.pos.animation.frame = 1
			elif r > 0.6666:
				e.pos.camName = "cam2b"
				e.pos.animation.frame = 1
			auxRoom.animation.frame = 0
		"cam2b":
			var r = rng.randf()
			if r > 0.5:
				e.pos.camName = "cam2a"
				e.pos.animation.frame = 2
			else:
				e.pos.camName = "attack"
			auxRoom.animation.frame = 0
		"cam3":
			e.pos.camName = "cam2a"
			e.pos.animation.frame = 2
			auxRoom.animation.frame = 0
		"cam5":
			if chica.pos.camName != "cam1b" and freddy.pos.camName != "cam1b":
				e.pos.camName = "cam1b"
				e.pos.animation.frame = rng.randi_range(1,2);
			auxRoom.animation.frame = 0
		"attack":
			e.pos.camName = "cam2b"
			e.pos.animation.frame = 2
			#remove from door
		_:
			print("No hay camara relacionada")
			moved = false
	if moved:
		if e.pos.camName == "attack":
			SignalManager.bAttackSignal.emit(true)
			SignalManager.bonnieSignal.emit(auxRoom, e.pos)
			#SignalManager.StartEnemiesTimer()
		else:
			SignalManager.bonnieSignal.emit(auxRoom, e.pos)
	pass

func DuplicateRoom(room : Room) -> Room:
	return Room.new(room.name, room.camName, AnimationState.new(room.animation.name, room.animation.amountFrames, room.animation.isPlayable), room.isEmpty)


func StartEnemiesTimer() -> void:
	$EnemiesTimer.start(3)
	#$BonnieTimer.stop()


func _on_enemies_timer_timeout():
	MoveBonnie(bonnie)
