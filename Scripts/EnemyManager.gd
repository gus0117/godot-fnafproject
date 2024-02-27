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

var chanceMove : float = 15 # 15% at night 1

var auxRoom : Room

func _ready():
	SignalManager.bTimerSignal.connect(StartEnemiesTimer)
	auxRoom = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	bonnie.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	chica.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)
	freddy.pos = Room.new("Stage Show", "cam1a", AnimationState.new("state", 7, false), false)

# Calculate de chance of attack depending of night and hour
func CalculateAttackChance() -> float:
	var chance = 15 + (1 - Global.currentNight) * 5 #Calculate by night
	return chance + Global.currentHour * 5 #Calculate by hour

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
					SignalManager.bTimerSignal.emit()
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
			auxRoom.camName="cam2b"
			e.pos.camName = "cam2b"
			e.pos.animation.frame = 2
			SignalManager.bAttackSignal.emit(false)
			#remove from door
		_:
			print("No hay camara relacionada")
			moved = false
	if moved:
		if e.pos.camName == "attack":
			SignalManager.bAttackSignal.emit(true)
			#SignalManager.StartEnemiesTimer()
		SignalManager.bonnieSignal.emit(auxRoom, e.pos)
	pass

func MoveChica(e : Enemy):
	var moved : bool = true
	var roomChance : int = 0 if chica.pos.camName == "cam1a" else rng.randi_range(0, 5)
	var aux : Room = DuplicateRoom(e.pos)
	match roomChance:
		0:
			if e.pos.camName == "cam1b":
				moved = false
			else:
				if bonnie.pos.camName != "cam1b" and freddy.pos.camName != "cam1b":
					e.pos.camName = "cam1b"
					e.pos.animation.frame = rng.randi_range(3, 4)
					aux.animation.frame = 1 if bonnie.pos.camName == "cam1a" else 3
				else:
					moved = false
		1: #Disabled cam - Kitchen
			if e.pos.camName == "cam6":
				moved = false
			else:
				e.pos.camName = "cam6"
				e.pos.animation.frame = 0
				aux.animation.name = "black"
				aux.animation.frame = 0
			#emit sound
		2: 
			if e.pos.camName == "cam7":
				moved = false
			else:
				e.pos.camName = "cam7"
				e.pos.animation.frame = rng.randi_range(1,2)
				aux.animation.frame = 0
		3:
			if e.pos.camName == "cam4a":
				moved = false
			else:
				e.pos.camName = "cam4a"
				e.pos.animation.frame = rng.randi_range(1,2)
				aux.animation.frame = 0
		4:
			if e.pos.camName == "cam4b":
				moved = false
			else:
				e.pos.name = "cam4b"
				e.pos.animation.frame = 1
				aux.animation.frame = 0
		_: moved = false
	if moved:
		SignalManager.bonnieSignal.emit(aux, e.pos)
	else:
		SignalManager.bTimerSignal.emit()
	pass

func DuplicateRoom(room : Room) -> Room:
	return Room.new(room.name, room.camName, AnimationState.new(room.animation.name, room.animation.amountFrames, room.animation.isPlayable), room.isEmpty)


func StartEnemiesTimer() -> void:
	$EnemiesTimer.start(3)
	#$BonnieTimer.stop()


func _on_enemies_timer_timeout():
	var chance : int
	if Global.currentNight <= 2 and bonnie.pos.camName == "cam1a" and Global.currentHour <= 2:
		chance = 0 # bonnie exit at 100%
	else:
		chance = randi_range(0, 1)
	print(str(chance))
	match chance:
		0 : MoveBonnie(bonnie)
		1 : MoveChica(chica)
		3 : print("Move freddy")
		_: print("No enemy chance")
