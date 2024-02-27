extends Control

var calendrier_class = load("res://Class/Calendrier.gd").new()
# var jour 
@export var couleur_select : Color
@onready var jour = get_node("Fond/Jour")
@onready var fond = get_node("Fond")
@onready var calendar = get_node("../../../../../../InfoPanel2")

var current_jour : int
var set_Jour : int :
	set(value):
		current_jour = value
		# print(calendrier_class.jour[value])
		var le_jour = str(calendrier_class.jour[value])
		# print (jour)
		jour.text = le_jour
	get:
		return current_jour
		
		# Called when the node enters the scene tree for the first time.
func init():
	jour= get_node("Fond/Jour")

func _on_fond_gui_input(_event):

		# if Input.is_action_pressed("Shift_Left_Mouse_Click"):
		# 	calendar.ShiftedClicked(self)
		# 	return
	if Input.is_action_pressed("Left_Mouse_Click")&& self.is_in_group("info_jour"):
		fond.color = couleur_select
		calendar.on_clicked_jour(self)
