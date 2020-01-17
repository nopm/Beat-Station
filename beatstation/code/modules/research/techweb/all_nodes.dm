/datum/techweb_node/base // BEPIS
	design_ids = list("basic_matter_bin", "basic_cell", "basic_scanning", "basic_capacitor", "basic_micro_laser", "micro_mani", "desttagger", "handlabel", "packagewrap",
	"destructive_analyzer", "circuit_imprinter", "experimentor", "rdconsole", "bepis", "design_disk", "tech_disk", "rdserver", "rdservercontrol", "mechfab", "paystand",
	"space_heater", "beaker", "large_beaker", "bucket", "xlarge_beaker", "sec_rshot", "sec_beanbag_slug", "sec_bshot", "sec_slug", "sec_Islug", "sec_dart", "sec_38",
	"rglass","plasteel","plastitanium","plasmaglass","plasmareinforcedglass","titaniumglass","plastitaniumglass","plumbing_rcd")
/datum/techweb_node/nanite_harmonic
	design_ids = list("fakedeath_nanites","aggressive_nanites","defib_nanites","regenerative_plus_nanites","brainheal_plus_nanites","purging_plus_nanites")

/datum/techweb_node/nanite_combat
	design_ids = list("explosive_nanites","pyro_nanites","meltdown_nanites","viral_nanites","adrenaline_nanites")

/datum/techweb_node/comptech
	design_ids = list("cargo", "cargorequest", "stockexchange", "libraryconsole", "mining", "crewconsole", "rdcamera", "comconsole", "idcardconsole", "seccamera")

/datum/techweb_node/biotech
	design_ids = list("chem_heater", "chem_master", "chem_dispenser", "pandemic", "defibrillator", "defibmount", "operating", "soda_dispenser", "beer_dispenser", "healthanalyzer", "medspray","genescanner", "medical_kiosk")

/datum/techweb_node/ancient_weaponry
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 15000)

/datum/techweb_node/magnetic_weapons
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)

////////////////////////B.E.P.I.S. Locked Techs////////////////////////
/datum/techweb_node/light_apps
	id = "light_apps"
	display_name = "Illumination Applications"
	description = "Applications of lighting and vision technology not originally thought to be commercially viable."
	prereq_ids = list("base")
	design_ids = list("bright_helmet", "rld_mini")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 2500
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/spec_eng
	id = "spec_eng"
	display_name = "Specialized Engineering"
	description = "Conventional wisdom has deemed these engineering products 'technically' safe, but far too dangerous to traditionally condone."
	prereq_ids = list("base")
	design_ids = list("lava_rods", "eng_gloves")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 2500
	hidden = TRUE
	experimental = TRUE

/datum/techweb_node/aus_security
	id = "aus_security"
	display_name = "Australicus Security Protocols"
	description = "It is said that security in the Australicus sector is tight, so we took some pointers from their equipment. Thankfully, our sector lacks any signs of these, 'dropbears'."
	prereq_ids = list("base")
	design_ids = list("pin_explorer", "stun_boomerang")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)
	export_price = 2500
	hidden = TRUE
	experimental = TRUE
