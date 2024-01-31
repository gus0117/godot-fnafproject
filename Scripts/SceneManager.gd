extends Node2D

class_name SceneManager

@onready var officeScene : Node2D = $Office
@onready var monitorScene : Node2D = $MonitorScene


func _ready():
	monitorScene.EnableMonitorCam(false)
	officeScene.EnableOfficeCam(true)
	pass

func SwitchToOffice() -> void :
	officeScene.EnableOfficeCam(true)
	officeScene.EnableSwitchCamBtn(false)
	officeScene.AnimateMonitor()

func SwitchToMonitor() -> void :
	monitorScene.EnableMonitorCam(true)
	monitorScene.EnableSwitchCamBtn(false)
