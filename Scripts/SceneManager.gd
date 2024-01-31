extends Node2D

class_name SceneManager

@onready var officeScene : Node2D = $Office
@onready var monitorScene : Node2D = $MonitorScene

var isEnabledToSwitchScn : bool = true

func _ready():
	monitorScene.EnableMonitorCam(false)
	officeScene.EnableOfficeCam(true)
	pass

func SwitchToOffice() -> void :
	#Enabled scene cam
	officeScene.EnableOfficeCam(true)
	
	#Enable to switch next scene
	#officeScene.EnableSwitchCamBtn(false)
	officeScene.AnimateMonitor()

func SwitchToMonitor() -> void :
	#Enabled scene cam
	monitorScene.EnableMonitorCam(true)
	
	#Enable to switch next scene
	#monitorScene.EnableSwitchCamBtn(false)

func EnableToSwitchScn() -> void:
	isEnabledToSwitchScn = true

func _on_switch_area_mouse_entered():
	if not isEnabledToSwitchScn:
		return
	officeScene.AnimateMonitor()
	isEnabledToSwitchScn = false


func _on_switch_area_mouse_exited():
	print("Ready to switch")
