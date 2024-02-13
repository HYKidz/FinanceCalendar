extends Control

var calendrier_class = load("res://Class/Calendrier.gd").new()
var jour 
# @onready var jour = get_node("Fond/Jour")

var current_jour : int
var set_Jour : int :
	set(value):
		current_jour = value
		# print(calendrier_class.jour[value])
		var le_jour = str(calendrier_class.jour[value])
		# print (jour)
		jour.text = le_jour
		
		# Called when the node enters the scene tree for the first time.
func init():
	jour= get_node("Fond/Jour")
