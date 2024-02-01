extends Node2D

class_name SceneManager

@onready var officeScene : Node2D = $Office
@onready var monitorScene : Node2D = $MonitorScene

var isEnabledToSwitchScn : bool = true
var isMonitorScnNext : bool = true

func _ready():
	monitorScene.EnableMonitorCam(false)
	officeScene.EnableOfficeCam(true)
	pass

func SwitchToOffice() -> void :
	officeScene.EnableOfficeCam(true)
	officeScene.AnimateMonitor()
	isMonitorScnNext = true

func SwitchToMonitor() -> void :
	monitorScene.EnableMonitorCam(true)
	isMonitorScnNext = false

func EnableToSwitchScn() -> void:
	isEnabledToSwitchScn = true

func _on_switch_area_mouse_entered():
	if not isEnabledToSwitchScn:
		return
	if isMonitorScnNext:
		officeScene.AnimateMonitor()
	else:
		SwitchToOffice()
	isEnabledToSwitchScn = false
	$GUI/SwitchArea/SwitchSprite.visible = false


func _on_switch_area_mouse_exited():
	isEnabledToSwitchScn = true
	$GUI/SwitchArea/SwitchSprite.visible = true
