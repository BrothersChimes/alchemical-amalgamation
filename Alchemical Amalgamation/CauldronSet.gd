extends Node2D

var heat = 0
var coal = 0
var wood = 0
var heat_coals = 0
var heat_level_fire = Heat.DEAD
var heat_level_coals = Heat.DEAD
var has_coal = 1
const CAULDRON_HEAT_GLOW_THRESHOLD = 20
const BELLOWS_HEAT_ADDITION = 20
const HEAT_MAX = 100
const BELLOWS_HEAT_MULTIPLIER_MAX = 0.4
const HEAT_LOW = 40
const HEAT_MED = 60
const HEAT_HIGH = 80
const HEAT_BLAZE = 100
const WOOD_MAX = 100
const COAL_MAX = 100

enum Heat {
	DEAD,
	LOW,
	MED,
	HIGH,
	BLAZE
}

func _on_BellowsSprite_animation_finished():
	var glowing_hot = false
	$Bellows/BellowsSprite.stop()
	var bellows_heat_multiplier = ((HEAT_MAX - heat) / HEAT_MAX)
	if bellows_heat_multiplier > BELLOWS_HEAT_MULTIPLIER_MAX:
		bellows_heat_multiplier = BELLOWS_HEAT_MULTIPLIER_MAX
	heat += BELLOWS_HEAT_ADDITION * bellows_heat_multiplier + (has_coal * BELLOWS_HEAT_ADDITION)

	if heat > HEAT_MAX:
		heat = HEAT_MAX

func print_stats():
	print("heat_level_fire: ", heat_level_fire)
	print("embers: ", heat_coals)
	print("wood: ", wood)
	print("heat_level_coals: ", coal)
	

func _process(delta):
	var	burn_consumption_multiplier = 0
	if Input.is_action_just_pressed("add_wood"):
		print("wood added")
		print_stats()
		wood += 30
	if Input.is_action_just_pressed("add_coal"):
		print("coal added")
		print_stats()
		coal += 20
	if wood > WOOD_MAX:
		wood = WOOD_MAX
	if coal > COAL_MAX:
		coal = COAL_MAX
	if coal > 0:
		has_coal = 1
	else:
		has_coal = 0
	heat -= delta
	heat_coals -= delta
	if Input.is_action_just_pressed("shovel_embers") && heat > 0:
		print("embers shoveled")
		print_stats()
		heat_coals += 0.3 * heat
		heat -= 0.3 * heat
		wood -= 5
		coal -= 5
	if wood < 0:
		wood = 0
	if coal < 0:
		coal = 0
	if heat <= 0:
		heat = 0
	if heat_coals <= 0:
		heat_coals = 0
	if heat >= CAULDRON_HEAT_GLOW_THRESHOLD:
		$Cauldron/CauldronHotSprite.visible = true
		$Cauldron/CauldronColdSprite.visible = false
	else:
		$Cauldron/CauldronHotSprite.visible = false
		$Cauldron/CauldronColdSprite.visible = true
	if Input.is_action_just_pressed("bellows"):
		print("bellows blown")
		print_stats()
		$Bellows/BellowsSprite.play("default")
	if heat <= 0:
		$Fire/FireSprite.set_frame(0)
		heat_level_fire = Heat.DEAD
		burn_consumption_multiplier = 0.025
	elif heat <= HEAT_LOW:
		$Fire/FireSprite.set_frame(1)
		heat_level_fire = Heat.LOW
		burn_consumption_multiplier = 0.05
	elif heat <= HEAT_MED:
		$Fire/FireSprite.set_frame(2)
		heat_level_fire = Heat.MED
		burn_consumption_multiplier = 0.15
	elif heat <= HEAT_HIGH:
		$Fire/FireSprite.set_frame(3)
		heat_level_fire = Heat.HIGH
		burn_consumption_multiplier = 0.3
	elif heat <= HEAT_BLAZE:
		$Fire/FireSprite.set_frame(4)
		heat_level_fire = Heat.BLAZE
		burn_consumption_multiplier = 0.6
	if heat_coals <= 0:
		heat_level_coals = Heat.DEAD
		$Coals/CoalsSprite.set_frame(0)
	elif heat_coals <= HEAT_LOW:
		heat_level_coals = Heat.LOW
		$Coals/CoalsSprite.set_frame(1)
	elif heat_coals <= 60:
		heat_level_coals = Heat.MED
		$Coals/CoalsSprite.set_frame(2)
	elif heat_coals <= 80:
		heat_level_coals = Heat.HIGH
		$Coals/CoalsSprite.set_frame(3)
	elif heat_coals <= 100:
		heat_level_coals = Heat.BLAZE
		$Coals/CoalsSprite.set_frame(4)
	if wood <= 0:
		$Wood/WoodSprite.set_frame(0)
	elif wood <= HEAT_LOW:
		$Wood/WoodSprite.set_frame(1)
	elif wood <= 60:
		$Wood/WoodSprite.set_frame(2)
	elif wood <= 80:
		$Wood/WoodSprite.set_frame(3)
	elif wood <= 100:
		$Wood/WoodSprite.set_frame(4)
	wood -= 1 * burn_consumption_multiplier
	coal -= 1 * burn_consumption_multiplier


# PUBLIC_FUNCTIONS
func get_heat_cauldron():
	return heat_level_coals

func get_heat_embers():
	return heat_level_fire
