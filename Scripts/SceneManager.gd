extends Node2D

class_name SceneManager

@onready var officeScene : Node2D = $Office
@onready var monitorScene : Node2D = $MonitorScene


func _ready():
	monitorScene.EnableMonitorCam(false)
	officeScene.EnableOfficeCam(true)
	pass

func SwitchToOffice() -> void :
	#monitorScene.visible = false
	#monitorScene.EnableMonitorCam(false)
	officeScene.EnableOfficeCam(true)
	#officeScene.visible = true
	#$Office/Camera/Camera2D.make_current()
	officeScene.AnimateMonitor()

func SwitchToMonitor() -> void :
	#$MonitorScene/Camera/Camera2D.make_current()
	#officeScene.visible = false
	#officeScene.EnableOfficeCam(false)
	monitorScene.EnableMonitorCam(true)
	#monitorScene.visible = true
	
	#get_viewport().get_camera_2d().current = false
	#monitorScene.Camera.Camera2D.current = true
