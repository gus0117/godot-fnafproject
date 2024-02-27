extends Node2D

class_name SceneManager

@onready var officeScene : Node2D = $Office
@onready var monitorScene : Node2D = $MonitorScene

var isEnabledToSwitchScn : bool = true
var isMonitorScnNext : bool = true

func _ready():
	monitorScene.EnableMonitorCam(false)
	officeScene.EnableOfficeCam(true)
	$GUI/Clock/ClockLabel.text = Global.GetHourString()
	SignalManager.nightEndSignal.connect(_on_night_end)

func SwitchToOffice() -> void :
	monitorScene.StopSoundBG()
	monitorScene.StopNoise()
	officeScene.EnableOfficeCam(true)
	officeScene.AnimateMonitor()
	isMonitorScnNext = true

func SwitchToMonitor() -> void :
	monitorScene.EnableMonitorCam(true)
	isMonitorScnNext = false
	monitorScene.PlaySoundBG()
	monitorScene.PlayNoise()

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


func _on_night_timer_timeout():
	Global.IncreseHour()
	$GUI/Clock/ClockLabel.text = Global.GetHourString()

func _on_night_end() -> void:
	print("night end, make animation")
