state("MirrorsEdge") {
    int tt_checkpoint : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D4;
    int tt_checkpoint_time : 0x01BFBCA4, 0x50, 0x1E0, 0x318, 0x3D8;
    int tt_id : 0x01B993B0, 0x328, 0x60, 0x228, 0xFC;
}

startup {
    settings.Add("splitFinish", true, "Split at end of a Time Trial");
    settings.SetToolTip("splitFinish", "It will only split when you finish a time trial");

    settings.Add("splitBehindorAhead", false, "Split when text shows up");
    settings.SetToolTip("splitBehindorAhead", "Split everytime where it would display if you're ahead or behind current ghost");

    settings.Add("splitEverytime", false, "Split everytime");
    settings.SetToolTip("splitEverytime", "If you touch a checkpoint, it will split. When using this, you'll get better sum of best but you need 214 splits!");

    vars.tt_finalCheckpoint = new List<int>
	{
		{5},  // Playground One
		{10}, // Playground Two
		{12}, // Playground Three
		{7},  // Edge
		{6},  // Arland
		{8},  // Flight
		{6},  // Chase
		{15}, // Stormdrains One
		{9},  // Stormdrains Two
		{8},  // Stormdrains Three
		{9},  // Heat
		{5},  // Burfield
		{13}, // Cranes One
		{9},  // Cranes Two
		{6},  // New Eden
		{18}, // Factory
		{2},  // Office
		{7},  // Convoy One
		{9},  // Convoy Two
		{17}, // Atrium One
		{13}, // Atrium Two
		{10}, // Shard One
		{10}  // Shard Two
	};
}

start {
    // Start on Playground One
    if (current.tt_checkpoint == 0 && current.tt_id == 0) {
        return true;
    }
}

split {
    if (settings["splitFinish"]) {
        if (current.tt_checkpoint > old.tt_checkpoint) {
            if (current.tt_checkpoint == vars.tt_finalCheckpoint[current.tt_id]) {
                return true;
            } 
        }
    }

    if (settings["splitBehindorAhead"]) {
        if (current.tt_checkpoint_time > old.tt_checkpoint_time) {
            return true;
        }
    }

    if (settings["splitEverytime"]) {
        if (current.tt_checkpoint > old.tt_checkpoint) {
            return true;
        }
    }
}
