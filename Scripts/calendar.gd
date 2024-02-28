extends Node2D


var current_month 
var current_year 
var current_rule = []

var date_today = Time.get_date_dict_from_system()
var calendrier_class = load("res://Class/Calendrier.gd").new()
var date_array_selection
var total :int
@onready var le_titre_mois = get_node("Fond/Mois")
@onready var le_calendrier = get_node("JourEnRow")
@onready var info_panel = get_node("InfoPanel2")
@onready var cash_label = get_node("CashInfo/Label")


# Called when the node enters the scene tree for the first time.
func _ready():
	le_titre_mois.text = calendrier_class.mois[date_today["month"]-1]+"   "+str(date_today["year"])
	le_calendrier.InstanceDate(date_today["month"], date_today["year"])
	info_panel.Init(date_today["month"], date_today["year"])
	current_month = date_today["month"]
	current_year = date_today["year"]


func _on_next_pressed():
	# info_panel.visible = false
	current_month+=1
	if current_month>12:
		current_month=1
		current_year += 1
	le_calendrier.InstanceDate(current_month, current_year)
	info_panel.Current_Month(current_month,current_year)
	le_titre_mois.text = calendrier_class.mois[current_month-1]+"   "+str(current_year)
	for rule in current_rule :
		calculate_cash(rule)


func _on_previous_pressed():
	# info_panel.visible = false
	current_month-=1
	if current_month<1:
		current_month=12
		current_year -= 1
	le_calendrier.InstanceDate(current_month, current_year)
	info_panel.Current_Month(current_month,current_year)
	le_titre_mois.text = calendrier_class.mois[current_month-1]+"   "+str(current_year)
	for rule in current_rule :
		calculate_cash(rule)

	
func calculate_cash(m):
	var current = m["starting_mois"]==current_month&&m["starting_anne"]==current_year
	
	var node_array = le_calendrier.list_de_node
	var prix =0
	if m["recurent"]:
		# print("oke")
		if m["date_recurente"]:
			if m["salarial"]:
				prix = m["montant"]*m["heure"]
			else:
				prix = m["montant"]
		else:
			var array = node_array
			for d in array.size():
				var node = array[d]
				if node.is_in_group("date"):
					var dictinit ={
						"year":m["starting_anne"],
						"month":m["starting_mois"],
						"day":m["starting_jour"]
					}
					var dictactu ={
						"year":node.Anne,
						"month":node.Mois,
						"day":node.Date
					}
					var tempinit = Time.get_unix_time_from_datetime_dict(dictinit)
					var tempactu = Time.get_unix_time_from_datetime_dict(dictactu)
					var tempdif = (tempactu-tempinit)/86400
					#ne regle pas le probleme mais l'empeiche, pas suposse de se rendre ici si on met une date recurente
					if m["jour"].size()>0&&d%7 == m["jour"][0]&&tempdif%m["jour_recurente"]==0&&tempdif>=0:
						
						if m["salarial"]:
							prix = m["montant"]*m["heure"]
						else:
							prix = m["montant"]
						total += prix
	elif  current :
		
		if m["salarial"]:
			prix = m["montant"]*m["heure"]
		else:
			prix = m["montant"]
	if !current_rule.has(m):
		var dict = m.duplicate(true)
		current_rule.push_back(dict)
	if m["depense"] :
		prix *= -1

	total += prix
	cash_label.text = str(total) 

	

