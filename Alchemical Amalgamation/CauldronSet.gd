extends Node2D

var heat = 0
var coal = 0
var wood = 0
var heat_embers = 0
var heat_level_fire = Heat.DEAD
var heat_level_embers = Heat.DEAD
var has_coal = 1
var counter = 0
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


func _ready(): 
	$CauldronDone.visible = false

func _on_BellowsSprite_animation_finished():
	var glowing_hot = false
	$Bellows/BellowsSprite.stop()
	var bellows_heat_multiplier = ((HEAT_MAX - heat) / HEAT_MAX)
	if bellows_heat_multiplier > BELLOWS_HEAT_MULTIPLIER_MAX:
		bellows_heat_multiplier = BELLOWS_HEAT_MULTIPLIER_MAX
	if wood <= 0:
		return
	heat += BELLOWS_HEAT_ADDITION * bellows_heat_multiplier + (has_coal * BELLOWS_HEAT_ADDITION)

	if heat > HEAT_MAX:
		heat = HEAT_MAX

func print_stats():
	print("heat: ", heat)
	print("heat_level_fire: ", heat_level_fire)
	print("embers: ", heat_embers)
	print("wood: ", wood)
	print("coal: ", coal)

func _process(delta):
	var	burn_consumption_multiplier = 0
	if Input.is_action_just_pressed("add_wood"):
		wood_add_event()
	if Input.is_action_just_pressed("add_coal"):
		coal_add_event()
	if wood > WOOD_MAX:
		wood = WOOD_MAX
	if coal > COAL_MAX:
		coal = COAL_MAX
	if coal > 0:
		has_coal = 1
	else:
		has_coal = 0
	if heat >= wood:
		heat -= delta
	else:
		heat += delta / 2
	heat_embers -= delta
	if Input.is_action_just_pressed("shovel_embers") && heat > 0:
		shovel_embers_event()
	if wood <= 0:
		heat -= delta * 3
		wood = 0
	if coal < 0:
		coal = 0
	if heat <= 0:
		heat = 0
	if heat_embers <= 0:
		heat_embers = 0
	if heat >= CAULDRON_HEAT_GLOW_THRESHOLD:
		$Cauldron/CauldronHotSprite.visible = true
		$Cauldron/CauldronColdSprite.visible = false
	else:
		$Cauldron/CauldronHotSprite.visible = false
		$Cauldron/CauldronColdSprite.visible = true
	if Input.is_action_just_pressed("bellows"):
		bellows_pressed_event()
	if heat <= 0:
		$Fire/FireSprite.set_frame(0)
		heat_level_fire = Heat.DEAD
	elif heat <= HEAT_LOW:
		$Fire/FireSprite.set_frame(1)
		heat_level_fire = Heat.LOW
		burn_consumption_multiplier = 0.25
	elif heat <= HEAT_MED:
		$Fire/FireSprite.set_frame(2)
		heat_level_fire = Heat.MED
		burn_consumption_multiplier = 0.5
	elif heat <= HEAT_HIGH:
		$Fire/FireSprite.set_frame(3)
		heat_level_fire = Heat.HIGH
		burn_consumption_multiplier = 1
	elif heat <= HEAT_BLAZE:
		$Fire/FireSprite.set_frame(4)
		heat_level_fire = Heat.BLAZE
		burn_consumption_multiplier = 1.5
	if heat_embers <= 0:
		heat_level_embers = Heat.DEAD
		$Coals/CoalsSprite.set_frame(0)
	elif heat_embers <= HEAT_LOW:
		heat_level_embers = Heat.LOW
		$Coals/CoalsSprite.set_frame(1)
	elif heat_embers <= 60:
		heat_level_embers = Heat.MED
		$Coals/CoalsSprite.set_frame(2)
	elif heat_embers <= 80:
		heat_level_embers = Heat.HIGH
		$Coals/CoalsSprite.set_frame(3)
	elif heat_embers <= 100:
		heat_level_embers = Heat.BLAZE
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
	wood -= delta * burn_consumption_multiplier
	coal -= delta * burn_consumption_multiplier
	counter += delta
	if counter > 2:
		print("COUNT")
		counter = 0
		if get_node("CauldronBusy/SpoonSprite").flip_h:
			get_node("CauldronBusy/SpoonSprite").flip_h = 0
		else:
			get_node("CauldronBusy/SpoonSprite").flip_h = 1

func wood_add_event(): 
	print("wood added")
	print_stats()
	wood += 30

func coal_add_event(): 
	print("coal added")
	print_stats()
	coal += 20

func shovel_embers_event():
	print("embers shoveled")
	print_stats()
	heat_embers += 0.3 * heat
	heat -= 0.3 * heat
	wood -= 5
	coal -= 5

func bellows_pressed_event():
	print("bellows blown")
	print_stats()
	$Bellows/BellowsSprite.play("default")

# PUBLIC_FUNCTIONS
func add_ingredient_to_cauldron(): 
	$CauldronDone.visible = false
	$CauldronBusy.visible = true
	$CauldronRuined.visible = false
	
func finish_cauldron(): 
	$CauldronDone.visible = true
	$CauldronBusy.visible = false
	$CauldronRuined.visible = false
	
func ruin_cauldron(): 
	$CauldronDone.visible = false
	$CauldronBusy.visible = false
	$CauldronRuined.visible = true
	
func empty_cauldron():
	$CauldronDone.visible = false
	$CauldronBusy.visible = false
	$CauldronRuined.visible = false
	
func get_heat_level_cauldron():
	return heat_level_fire

func get_heat_level_embers():
	return heat_level_embers
