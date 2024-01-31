extends Node2D

var jour = ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"]
var jour_node_array =[]
var date_node_array =[]

# @onready var container = get_node("Box/Grid")


# @onready var container = get_node("Box/Container/Grid")
# @onready var container = get_node("Box/Grid/Container")
@onready var container = get_node("Box/Grid")
@onready var date_node = preload("res://Node/date.tscn")
@onready var date_vide_node = preload("res://Node/dateVide.tscn")
@onready var jour_node = preload("res://Node/Jour.tscn")

# Called when the node enters the scene tree for the first time.

func _ready():
	# jour_node_array.resize(7)
	for d in jour:
		var new_jour = jour_node.instantiate()
		new_jour.name = d
		jour_node_array.push_back(new_jour)
		container.add_child(new_jour)
	
	for i in 7:
		var jour_en_cour = jour_node_array[i]
		jour_en_cour.set_Jour = jour[i]
	
	InstanceDate()
		


func InstanceDate():
	
	#change for current month
	var currentday = get_beginning_weekday(1,2024)
	var totalday = 31+currentday
	for i in totalday:
		if i<currentday:
			print("moisPasser")
			var new_date = date_vide_node.instantiate()
			container.add_child(new_date)
		else :
			print("moisActuel")
			var new_date = date_node.instantiate()
			new_date.name = str(i-currentday)
			date_node_array.push_back(new_date)
			container.add_child(new_date)
	for i in 31 :
		date_node_array[i].Num = i+1
	
func get_beginning_weekday(m, y, d=1):

	var t = [0,3,2,5,0,3,1,4,6,2,4]
	if m <3 : y-= 1
	return(y + y/4 - y/100 + y/400 + t[m-1] + d) % 7
