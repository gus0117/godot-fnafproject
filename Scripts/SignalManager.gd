extends Node

# Its functional for all enimes
signal bonnieSignal(from: Room, to: Room)

#its for all enemies
signal bTimerSignal

#Change light
signal bAttackSignal(enable: bool)

#Signals for finishing level
signal nightEndSignal
