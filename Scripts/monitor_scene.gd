class_name MonitorManager
extends Node2D

# Decide the direction to move
var moveToLeft : bool = false
var cameraSpeed : int = 2
var isCameraEnabled : bool = true
var isSwitchEnabled : bool

@export var btnGroup : ButtonGroup
@export var officeScene : Node2D
@onready var currentRoom : AnimatedSprite2D = $Rooms/Stage

# Dictionary of referecenses, than referece all rooms
@onready var roomDictionary = {
	"cam1a": $Rooms/Stage,
	"cam1b": $Rooms/Dining,
	"cam1c": $Rooms/PirateCove,
	"cam2a": $Rooms/WestHallCorner,
	"cam2b": $Rooms/WestHall,
	"cam3" : $Rooms/SupplyRoom,
	"cam4a": $Rooms/EastHallCorner,
	"cam4b": $Rooms/EastHall,
	"cam5" : $Rooms/Backstage,
	"cam6" : $Rooms/Disabled,
	"cam7" : $Rooms/RestRoom
}

var labelDictionary = {
	"cam1a": "Show Stage",
	"cam1b": "Dining Room",
	"cam1c": "Pirate Cove",
	"cam2a": "West Hall",
	"cam2b": "W. Hall Corner",
	"cam3" : "Supply Room",
	"cam4a": "East Hall",
	"cam4b": "E. Hall Corner",
	"cam5" : "Backstage",
	"cam6" : "-Cam Disabled- \n*Audio Only*",
	"cam7" : "Rest Room"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#Signal sub
	SignalManager.bonnieSignal.connect(MoveEnemyTo)
	#Init Button
	var buttons: Array[BaseButton] = btnGroup.get_buttons()
	buttons[0].button_pressed = true
	SetRoomName(labelDictionary["cam1a"])
	for btn in btnGroup.get_buttons():
		btn.connect("pressed", ButtonPressed.bind(btn.get_meta("cameraName")))

func ButtonPressed(camName : String) -> void:
	if(roomDictionary.has(camName)):
		SwitchRoom(roomDictionary[camName])
		SetRoomName(labelDictionary[camName])

func EnableMonitorCam(enable: bool) -> void:
	#isCameraEnabled = enable
	$Camera/Camera2D.make_current()

func EnableSwitchCamBtn(enable: bool) -> void:
	$Camera/GUI/SwitchOffice/Sprite2D.visible = enable
	isSwitchEnabled = enable

func SwitchRoom(newRoom : AnimatedSprite2D) -> void:
	if(newRoom == null):
		return
	newRoom.visible = true
	currentRoom.visible = false
	currentRoom = newRoom
	#Play sound
	$SoundFX/CamBlip.play()
	#Play animation noise
	PlayNoise()

func SetRoomName(roomName : String) -> void:
	$Camera/Buttons/Label.text = roomName

func PlaySoundBG() -> void:
	$SoundFX/MonitorBG.play()

func PlayNoise() -> void:
	$Camera/Noise.visible = true
	$Camera/Noise.play("default")

func StopNoise() -> void:
	$Camera/Noise.visible = false
	$Camera/Noise.stop()

func StopSoundBG() -> void:
	$SoundFX/MonitorBG.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isCameraEnabled:
		MoveCameraAuto()

func MoveEnemyTo(from: Room, to: Room) -> void:
	#print(from.animation.frame)
	ChangeCamFrame(from.camName, "black", 0)
	ChangeCamFrame(to.camName, "black",0)
	await get_tree().create_timer(2.5).timeout
	ChangeCamFrame(from.camName, from.animation.name, from.animation.frame)
	ChangeCamFrame(to.camName, to.animation.name, to.animation.frame)
	SignalManager.bTimerSignal.emit()
	

# Move the camera auto throw x-axis.
func MoveCameraAuto() -> void:
	if $Camera.position.x < 473 or $Camera.position.x > 780:
		cameraSpeed = -cameraSpeed
	$Camera.position.x += cameraSpeed

#Change the animated sprite to certain frame
func ChangeCamFrame(camName: String, animation: String, frame: int) -> void:
	#print("camName: %s anim: %s frame %s" % [camName, animation, str(frame)])
	if not roomDictionary.has(camName):
		print("Cam name doesn't exist")
		return
	roomDictionary[camName].SwitchFrame(animation, frame)

#Callback to RoomController for reset animation sprite frame to default
func ResetCamFrame(camName: String) -> void:
	if not roomDictionary.has(camName):
		return
	roomDictionary[camName].ResetFrame()

func _on_switch_office_mouse_entered():
	if isSwitchEnabled:
		get_parent().SwitchToOffice()

func _on_switch_office_mouse_exited():
	if not isSwitchEnabled:
		EnableSwitchCamBtn(true)


func _on_noise_animation_finished():
	StopNoise()
