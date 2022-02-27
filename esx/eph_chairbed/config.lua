Config = {}

Config.objects = {
	object = nil, ObjectVertX = nil, ObjectVertY = nil, ObjectVertZ = nil, OjbectDir = nil, isBed = nil, -- // Please dont change this line!;)
	-- SitAnimation = 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER',
	LayBackAnimation = 'WORLD_HUMAN_SUNBATHE_BACK',
	LayStomachAnimation = 'WORLD_HUMAN_SUNBATHE',
	locations = {
		[1] = {object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		[2] = {object="v_med_bed1", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true}
		-- [3] = {object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=-0.17, verticalOffsetZ=-0.2, direction=90.0, bed=false}
	}
}