extends TileMap

enum layers{
	level0 = 0,
	level1 = 1,
	level2 = 2,
}

const green_block_atlas_pos = Vector2i(3, 2)
const blue_block_atlas_pos = Vector2i(1, 2)
const boundary_atlas_pos = Vector2i(0, 0)
const main_source = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	place_platform(layers.level0)
	place_boundaries(layers.level0)

func place_boundaries(level):
	var offsets = [
		Vector2i(0, -1),
		Vector2i(0, 1),
		Vector2i(1, 0),
		Vector2i(-1, 0),
	]
	var used = get_used_cells(level)
	for spot in used:
		for offset in offsets:
			var current_spot = spot + offset
			if get_cell_source_id(level, current_spot) == -1: #this spot is empty
				set_cell(level, current_spot, main_source, boundary_atlas_pos, 1) # 1st alt has collisions

func place_platform(level):
	for y in range(3):
		for x in range(3):
			set_cell(level, Vector2i(2 + x, 2 + y), main_source, green_block_atlas_pos)

	set_cell(level + 1, Vector2i(2, 2), main_source, blue_block_atlas_pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass
