extends Control

var calendrier_class = load("res://Class/Calendrier.gd").new()

var Couleur : Color:
	set(value):
		fond.color = value
		
@export var couleur_select : Color
@onready var jour = get_node("Fond/Jour")
@onready var fond = get_node("Fond")
@onready var calendar = get_node("../../../../../../InfoPanel2")

var current_jour : int
var set_Jour : int :
	set(value):
		current_jour = value
		var le_jour = str(calendrier_class.jour[value])
		jour.text = le_jour
	get:
		return current_jour
		
func init():
	jour= get_node("Fond/Jour")

func _on_fond_gui_input(_event):

	if Input.is_action_pressed("Left_Mouse_Click")&& self.is_in_group("info_jour"):
		fond.color = couleur_select
		calendar.on_clicked_jour(self)
