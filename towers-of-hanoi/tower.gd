extends Area2D

# array of ids of discs on pole; set in editor after instancing
# use ints
@export var holding_discs = []
# indicates if tower is goal (i.e. the rightmost tower)
# game is won when goal tower is filled
@export var is_goal = false

signal game_won

var hovering_disc

# when a disc is brought over a pole
func _on_area_entered(area):
	hovering_disc = area
	hovering_disc.has_tower_under = true
	hovering_disc.tower_under = self

func _on_area_exited(_area):
	hovering_disc.has_tower_under = false

func add_disc(disc):
	holding_discs.push_back(disc.disc_id)
	if is_goal and holding_discs == [1, 2, 3]:
		game_won.emit()

func remove_disc(disc):
	holding_discs.erase(disc.disc_id)

# returns false if holding_discs is empty or contains only discs in arg array
# returns true otherwise
func contains_other_discs(discs):
	if holding_discs.is_empty():
		return false
	for d in holding_discs:
		if d not in discs:
			return true
