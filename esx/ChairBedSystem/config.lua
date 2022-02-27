Config = {}

Config.Healing = 3 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.
Config.Cooldown = 2 -- // If this is 0, then its disabled.. Default: 2.. That means, if a player goes and stand up, then he need to wait 2 seconds, before he can lay/sit again! [VERY RECOMMENDED]
Config.MaxDistance = 1.5

Config.objects = {
	Object = nil, ObjectVertX = nil, ObjectVertY = nil, ObjectVertZ = nil, ObjectDir = nil, isBed = nil, -- // Please don't change this line!;)
	ButtonToSitOnChair = 47, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
}	
Citizen.CreateThread(function()
	Config.objects.Locations = {}
	Config.objects.Locations[`v_med_bed2`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true}
	Config.objects.Locations[`v_med_bed1`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true}
	Config.objects.Locations[`v_serv_ct_chair02`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false}
	Config.objects.Locations[`prop_off_chair_04`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false}
	Config.objects.Locations[`prop_off_chair_03`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false}
	Config.objects.Locations[`prop_off_chair_05`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false}
	Config.objects.Locations[`v_club_officechair`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false}
	Config.objects.Locations[`v_ilev_leath_chr`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false}
	Config.objects.Locations[`v_corp_offchair`] = {verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false}
	Config.objects.Locations[`v_med_emptybed`] = {verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=false}
	Config.objects.Locations[`Prop_Off_Chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_01a`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_01b`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_01c`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_04`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_05`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_06`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_08`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_09`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_10`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_bench_11`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_fib_3b_bench`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_ld_bench01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_wait_bench_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`hei_prop_heist_off_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`hei_prop_hei_skid_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_01a`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_01b`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_04a`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_04b`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_05`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_06`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_08`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_09`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chair_10`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_chateau_chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_clown_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_cs_office_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_direct_chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_direct_chair_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_gc_chair02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_off_chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_off_chair_03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_off_chair_04`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_off_chair_04b`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_off_chair_04_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_off_chair_05`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_old_deck_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_old_wood_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_rock_chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_skid_chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_skid_chair_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_skid_chair_03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_sol_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_wheelchair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_wheelchair_01_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_armchair_01_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_clb_officechair_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_dinechair_01_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_ilev_p_easychair_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_soloffchair_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_yacht_chair_01_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_club_officechair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_corp_bk_chair3`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_corp_cd_chair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_corp_offchair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_chair02_ped`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_p_easychair`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ret_gc_chair03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.0, direction=180.0, bed=false}
	Config.objects.Locations[`prop_ld_farm_chair01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_04_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_05_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_06_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_leath_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_01_chr_a`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=0.0, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_01_chr_b`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_02_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_03b_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_table_03_chr`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_torture_ch_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_fh_dineeamesa`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_fh_kitchenstool`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_tort_stool`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_fh_kitchenstool`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_fh_kitchenstool`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`hei_prop_yah_seat_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`hei_prop_yah_seat_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`hei_prop_yah_seat_03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_waiting_seat_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_yacht_seat_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_yacht_seat_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_yacht_seat_03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_hobo_seat_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_rub_couch01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`miss_rub_couch_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_ld_farm_couch01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_ld_farm_couch02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_rub_couch03`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_rub_couch04`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_lev_sofa_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_res_sofa_l_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_v_med_p_sofa_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`p_yacht_sofa_01_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_m_sofa`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_res_tre_sofa_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_tre_sofa_mess_a_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_tre_sofa_mess_b_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_tre_sofa_mess_c_s`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_roller_car_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`prop_roller_car_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`v_ilev_ph_bench`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`ex_prop_offchair_exec_04`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`ex_prop_offchair_exec_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`vw_prop_vw_offchair_02`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	Config.objects.Locations[`vw_prop_casino_chair_01a`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=90.0, bed=false}
	Config.objects.Locations[`vw_prop_casino_track_chair_01`] = {verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	end)
	
Config.BedList = {
	{
		text = '~g~E~w~ ile sırt üstü yatabilirsiniz!',
		--heading = 250.91,
		heading = 71.31,
		objCoords  = {x = 320.48, y = -576.23, z = 43.36},---pillbox normal yatak
	},
	{
		text = '~g~E~w~ ile sırt üstü yatabilirsiniz!',								-- private room 1
		--heading = 251.31,	
		heading = 71.31,
		objCoords  = {x = 319.47, y = -579.34, z = 43.36},--pillbox normal yatak
	}
	-- {
	-- 	text = '~g~E~w~ ile sırt üstü yatabilirsiniz!',
	-- 	heading = 340.0,												-- main a soldaki, ilk surgent
	-- 	objCoords  = {x = 315.44, y = -566.10, z = 43.28},				--pillbox normal yatak
	-- },
	-- {
	-- 	text = '~g~E~w~ ile sırt üstü yatabilirsiniz!',	
	-- 	heading = 340.0,
	-- 	objCoords  = {x = 348.62, y = -579.20, z = 43.02},   ---x ray
	-- },
	-- {
	-- 	text = '~g~E~w~ ile sırt üstü yatabilirsiniz!',	
	-- 	heading = 340.0,
	-- 	objCoords  = {x = 337.05, y = -575.22, z = 43.0},   ---x ray
	-- }	
}	
	
	
Config.Text = {
	SitOnChair = '~g~G~w~ ile oturabilirsiniz!',
	SitOnBed = '~g~E~w~ ile yatagın uzerine oturabilirsiniz!',
	LieOnBed = 'yatabilirsiniz!',
	SwitchBetween = '~w~ Yatak pozisyonlarını degistirmek için  ~g~ok tuslarını~w~ kullan',
	Standup = 'F ile kalkabilirsiniz!'
}