extends "res://disc1.gd"

func _ready():
    free_texture   = load("res://art_assets/disc2_free.png")
    linked_texture = load("res://art_assets/disc2_linked.png")
    allowed_discs_under = [1]
    disc_offset = 0
    disc_id = 2
