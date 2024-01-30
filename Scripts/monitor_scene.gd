extends Node2D

# Decide the direction to move
var moveToLeft : bool = false
var cameraSpeed : int = 2
var isCameraEnabled : bool = true

@export var btnGroup : ButtonGroup
@export var officeScene : Node2D
@onready var currentRoom : AnimatedSprite2D = $Rooms/Stage

# Dictionary of referecenses, than referece all rooms
@onready var roomDictionary = {
	"cam1a": $Rooms/Stage,
	"cam1b": $Rooms/Dining,
	"cam1c": $Rooms/PirateCove,
	"cam2a": $Rooms/RestRoom,
	"cam2b": $Rooms/Backstage,
	"cam3" : $Rooms/WestHallCorner,
	"cam4a": $Rooms/EastHallCorner,
	"cam4b": $Rooms/SupplyRoom,
	"cam5" : $Rooms/WestHall,
	"cam6" : $Rooms/Disabled,
	"cam7" : $Rooms/EastHall
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons: Array[BaseButton] = btnGroup.get_buttons()
	buttons[0].button_pressed = true
	for btn in btnGroup.get_buttons():
		btn.connect("pressed", ButtonPressed.bind(btn.get_meta("cameraName")))

func ButtonPressed(camName : String) -> void:
	if(roomDictionary.has(camName)):
		SwitchRoom(roomDictionary[camName])

func EnableMonitorCam(enable: bool) -> void:
	#isCameraEnabled = enable
	$Camera/Camera2D.make_current()

func SwitchRoom(newRoom : AnimatedSprite2D) -> void:
	if(newRoom == null):
		return
	newRoom.visible = true
	currentRoom.visible = false
	currentRoom = newRoom
	#Play sound
	#Play animation noise
	#Update label room_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if isCameraEnabled:
		MoveCameraAuto()

# Move the camera auto.
func MoveCameraAuto() -> void:
	if $Camera.position.x < 473 or $Camera.position.x > 780:
		cameraSpeed = -cameraSpeed
	$Camera.position.x += cameraSpeed


func _on_switch_office_mouse_entered():
	get_parent().SwitchToOffice()
	pass
	#Global.SwitchToOffice()
	#get_parent().SwitchToOffice()
