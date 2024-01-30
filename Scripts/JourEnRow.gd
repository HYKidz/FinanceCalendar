extends Node2D

var jour = ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]
var jour_node_array =[]

@onready var container = get_node("Box/Container/Grid")
@onready var jour_node = preload("res://Node/Jour.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	jour_node_array.resize(7)
	for d in jour:
		var new_jour = jour_node.instantiate()
		new_jour.name = d
		jour_node_array.fill(new_jour)
		container.add_child(new_jour)
	
	for i in 7:
		print(i)
		var jour_en_cour = jour_node_array[i]
		jour_en_cour.set_Jour = jour[i]

