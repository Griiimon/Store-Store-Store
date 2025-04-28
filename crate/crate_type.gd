class_name CrateType

enum Symbol { PLUS, MINUS, CROSS, CIRCLE, RECTANGLE, TRIANGLE, V }

const COLORS= [ Color.YELLOW, Color.DARK_ORANGE, Color.RED, Color.GREEN,\
		Color.BLUE, Color.SADDLE_BROWN, Color.BLACK ]

static var materials: Array[StandardMaterial3D]

var symbol: Symbol
var color: Color



func _init(_symbol: Symbol, _color: Color):
	symbol= _symbol
	color= _color


func does_match(other_type: CrateType)-> bool:
	return symbol == other_type.symbol and color == other_type.color


func get_material()-> StandardMaterial3D:
	return materials[COLORS.find(color)]


static func initialize():
	for color in COLORS:
		var material:= StandardMaterial3D.new()
		material.albedo_color= color
		materials.append(material)


static func create_random()-> CrateType:
	return CrateType.new(Symbol.PLUS, COLORS.pick_random())
	#return CrateType.new(Symbol.values().pick_random(), COLORS.pick_random())
