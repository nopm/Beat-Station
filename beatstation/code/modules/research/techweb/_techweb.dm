// BEPIS
/datum/techweb/bepis	//Should contain only 1 BEPIS tech selected at random.
	id = "EXPERIMENTAL"
	organization = "Nanotrasen R&D"

/datum/techweb/bepis/New()
	. = ..()
	var/bepis_id = pick(SSresearch.techweb_nodes_experimental)	//To add a new tech to the BEPIS, add the ID to this pick list.
	var/datum/techweb_node/BN = (SSresearch.techweb_node_by_id(bepis_id))
	hidden_nodes -= BN.id				//Has to be removed from hidden nodes
	research_node(BN, TRUE, FALSE, FALSE)
	update_node_status(BN)
	SSresearch.techweb_nodes_experimental -= bepis_id

/datum/techweb/copy_research_to(datum/techweb/receiver, unlock_hidden = TRUE)				//Adds any missing research to theirs.
	if(unlock_hidden)
		for(var/i in receiver.hidden_nodes)
			CHECK_TICK
			if(!hidden_nodes[i])
				receiver.hidden_nodes -= i		//We can see it so let them see it too.
	for(var/i in researched_nodes)
		CHECK_TICK
		receiver.research_node_id(i, TRUE, FALSE, FALSE)
	for(var/i in researched_designs)
		CHECK_TICK
		receiver.add_design_by_id(i)
	receiver.recalculate_nodes()
