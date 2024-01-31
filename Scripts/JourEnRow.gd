extends Node2D


var jour_node_array =[]
var date_node_array =[]

# @onready var container = get_node("Box/Grid")


# @onready var container = get_node("Box/Container/Grid")
# @onready var container = get_node("Box/Grid/Container")
@onready var container = get_node("Box/Grid")
@onready var date_node = preload("res://Node/date.tscn")
@onready var date_vide_node = preload("res://Node/dateVide.tscn")
@onready var jour_node = preload("res://Node/Jour.tscn")
var calendrier_class = load("res://Class/Calendrier.gd").new()

# Called when the node enters the scene tree for the first time.

func _ready():
	# jour_node_array.resize(7)
	for d in calendrier_class.jour:
		var new_jour = jour_node.instantiate()
		new_jour.name = d
		jour_node_array.push_back(new_jour)
		container.add_child(new_jour)
	
	for i in 7:
		var jour_en_cour = jour_node_array[i]
		jour_en_cour.set_Jour = calendrier_class.jour[i]
	
	# InstanceDate()
		


func InstanceDate(m,y):
	for n in date_node_array:
		n.queue_free()
	date_node_array.clear()
	#change for current month
	var currentday = calendrier_class.get_beginning_weekday(m,y)
	var totalday = calendrier_class.get_days_in_month(m,y)+currentday
	for i in totalday:
		if i<currentday:
			var new_date = date_vide_node.instantiate()
			date_node_array.push_back(new_date)
			container.add_child(new_date)
		else :
			var new_date = date_node.instantiate()
			new_date.name = str(i-currentday)
			new_date.Jour = i%7
			date_node_array.push_back(new_date)
			container.add_child(new_date)
	for i in calendrier_class.get_days_in_month(m,y) :
		date_node_array[i+currentday].Date = i+1
	

