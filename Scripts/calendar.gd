extends Node2D


var current_month 
var current_year 

var date_today = Time.get_date_dict_from_system()
var calendrier_class = load("res://Class/Calendrier.gd").new()
var date_array_selection
@onready var le_titre_mois = get_node("Fond/Mois")
@onready var le_calendrier = get_node("JourEnRow")
@onready var info_panel = get_node("InfoPanel2")


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

	
	pass # Replace with function body.


func _on_previous_pressed():
	# info_panel.visible = false
	current_month-=1
	if current_month<1:
		current_month=12
		current_year -= 1
	le_calendrier.InstanceDate(current_month, current_year)
	info_panel.Current_Month(current_month,current_year)
	le_titre_mois.text = calendrier_class.mois[current_month-1]+"   "+str(current_year)
	pass # Replace with function body.

func ShiftedClicked(date):
	print(date)
	
func calculate_cash(m):
	print(m)
# func SetInfoDate(m:Dictionary):
# 	info_panel.visible = false
# 	dict_regle.push_back(m)
# 	Verifier_Regle()

# func Verifier_Regle():
# 	var montant_finale
# 	for r in dict_regle :
# 		le_calendrier.Regle(r["date_transaction"],r["couleur"],r["recurent"],r["date_recurente"],r["jour"])
# 		# if r["depense"]:



