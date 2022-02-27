DP = {}

DP.Expressions = {
   ["Sinirli"] = {"Expression", "mood_angry_1"},
   ["Sarhoş"] = {"Expression", "mood_drunk_1"},
   ["Aptal"] = {"Expression", "pose_injured_1"},
   ["Elektrikli"] = {"Expression", "electrocuted_1"},
   ["Huysuz"] = {"Expression", "effort_1"},
   ["Huysuz2"] = {"Expression", "mood_drivefast_1"},
   ["Huysuz3"] = {"Expression", "pose_angry_1"},
   ["Mutlu"] = {"Expression", "mood_happy_1"},
   ["Yaralı"] = {"Expression", "mood_injured_1"},
   ["Eğlenceli"] = {"Expression", "mood_dancing_low_1"},
   ["Nefes"] = {"Expression", "smoking_hold_1"},
   ["Asla Kör"] = {"Expression", "pose_normal_1"},
   ["Tek Göz"] = {"Expression", "pose_aiming_1"},
   ["Şok"] = {"Expression", "shocked_1"},
   ["Şok 2"] = {"Expression", "shocked_2"},
   ["Uykucu"] = {"Expression", "mood_sleeping_1"},
   ["Uykucu2"] = {"Expression", "dead_1"},
   ["Uykucu3"] = {"Expression", "dead_2"},
   ["Kendini Beğenmiş"] = {"Expression", "mood_smug_1"},
   ["Görkemli"] = {"Expression", "mood_aiming_1"},
   ["Stresli"] = {"Expression", "mood_stressed_1"},
   ["Somurtma"] = {"Expression", "mood_sulk_1"},
   ["Tuhaf"] = {"Expression", "effort_2"},
   ["Tuhaf2"] = {"Expression", "effort_3"},
}

DP.Walks = {
    ["Alien"] = {"move_m@alien"},
    ["Armored"] = {"anim_group_move_ballistic"},
    ["Arrogant"] = {"move_f@arrogant@a"},
    ["Brave"] = {"move_m@brave"},
    ["Casual"] = {"move_m@casual@a"},
    ["Casual2"] = {"move_m@casual@b"},
    ["Casual3"] = {"move_m@casual@c"},
    ["Casual4"] = {"move_m@casual@d"},
    ["Casual5"] = {"move_m@casual@e"},
    ["Casual6"] = {"move_m@casual@f"},
    ["Chichi"] = {"move_f@chichi"},
    ["Confident"] = {"move_m@confident"},
    ["Cop"] = {"move_m@business@a"},
    ["Cop2"] = {"move_m@business@b"},
    ["Cop3"] = {"move_m@business@c"},
    ["Default Female"] = {"move_f@multiplayer"},
    ["Default Male"] = {"move_m@multiplayer"},
    ["Drunk"] = {"move_m@drunk@a"},
    ["Drunk"] = {"move_m@drunk@slightlydrunk"},
    ["Drunk2"] = {"move_m@buzzed"},
    ["Drunk3"] = {"move_m@drunk@verydrunk"},
    ["Femme"] = {"move_f@femme@"},
    ["Fire"] = {"move_characters@franklin@fire"},
    ["Fire2"] = {"move_characters@michael@fire"},
    ["Fire3"] = {"move_m@fire"},
    ["Flee"] = {"move_f@flee@a"},
    ["Franklin"] = {"move_p_m_one"},
    ["Gangster"] = {"move_m@gangster@generic"},
    ["Gangster2"] = {"move_m@gangster@ng"},
    ["Gangster3"] = {"move_m@gangster@var_e"},
    ["Gangster4"] = {"move_m@gangster@var_f"},
    ["Gangster5"] = {"move_m@gangster@var_i"},
    ["Grooving"] = {"anim@move_m@grooving@"},
    ["Guard"] = {"move_m@prison_gaurd"},
    ["Handcuffs"] = {"move_m@prisoner_cuffed"},
    ["Heels"] = {"move_f@heels@c"},
    ["Heels2"] = {"move_f@heels@d"},
    ["Hiking"] = {"move_m@hiking"},
    ["Hipster"] = {"move_m@hipster@a"},
    ["Hobo"] = {"move_m@hobo@a"},
    ["Hurry"] = {"move_f@hurry@a"},
    ["Janitor"] = {"move_p_m_zero_janitor"},
    ["Janitor2"] = {"move_p_m_zero_slow"},
    ["Jog"] = {"move_m@jog@"},
    ["Lemar"] = {"anim_group_move_lemar_alley"},
    ["Lester"] = {"move_heist_lester"},
    ["Lester2"] = {"move_lester_caneup"},
    ["Maneater"] = {"move_f@maneater"},
    ["Michael"] = {"move_ped_bucket"},
    ["Money"] = {"move_m@money"},
    ["Muscle"] = {"move_m@muscle@a"},
    ["Posh"] = {"move_m@posh@"},
    ["Posh2"] = {"move_f@posh@"},
    ["Quick"] = {"move_m@quick"},
    ["Runner"] = {"female_fast_runner"},
    ["Sad"] = {"move_m@sad@a"},
    ["Sassy"] = {"move_m@sassy"},
    ["Sassy2"] = {"move_f@sassy"},
    ["Scared"] = {"move_f@scared"},
    ["Sexy"] = {"move_f@sexy@a"},
    ["Shady"] = {"move_m@shadyped@a"},
    ["Slow"] = {"move_characters@jimmy@slow@"},
    ["Swagger"] = {"move_m@swagger"},
    ["Tough"] = {"move_m@tough_guy@"},
    ["Tough2"] = {"move_f@tough_guy@"},
    ["Trash"] = {"clipset@move@trash_fast_turn"},
    ["Trash2"] = {"missfbi4prepp1_garbageman"},
    ["Trevor"] = {"move_p_m_two"},
    ["Wide"] = {"move_m@bag"},
    -- I cant get these to work for some reason, if anyone knows a fix lmk
    --["Caution"] = {"move_m@caution"},
    --["Chubby"] = {"anim@move_m@chubby@a"},
    --["Crazy"] = {"move_m@crazy"},
    --["Joy"] = {"move_m@joy@a"},
    --["Power"] = {"move_m@power"},
    --["Sad2"] = {"anim@move_m@depression@a"},
    --["Sad3"] = {"move_m@depression@b"},
    --["Sad4"] = {"move_m@depression@d"},
    --["Wading"] = {"move_m@wading"},
  }

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Tokalaşma", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Tokalaşma 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Sarılmak", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Sarılmak 2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro Tokalaşma", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro Tokalaşma 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["give"] = {"mp_common", "givetake1_a", "Vermek", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Vermek 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Beyzbol Hareketi", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Beyzbol Tokalaşma", "baseball"},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Soy", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Soyul", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Yumruk Atmak", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Yumruk Yemek", "punch"},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Kafa Atmak", "headbutted"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Kafa Yemek", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Ters Tokat At", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Tokat Atmak", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Tokat Yemek", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Ters Tokat Ye", "slap2"},
}

DP.Dances = {
   ["danskadın4"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dans (Kadın) 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danskadın2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dans (Kadın) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danskadın3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dans (Kadın) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danskadın"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dans (Kadın)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danskadın5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dans (Kadın) 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danskadın6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dans (Kadın) 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dansyavaş2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dans (Yavaş) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dansyavaş3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dans (Yavaş) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dansyavaş4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dans (Yavaş) 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danserkek"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dans (Erkek)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danserkek2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dans (Erkek) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danserkek3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dans (Erkek) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danserkek4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dans (Erkek) 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dansüst"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dans (Üst)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dansüst2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dans (Üst) 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dansutangaç"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dans (Utangaç)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dansutangaç2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dans (Utangaç) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dansyavaş"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dans (Yavaş)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Zevzek Dans 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dans6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dans 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dans7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dans 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dans8"] = {"missfbi3_sniping", "dance_m_default", "Dans 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dans (Zevzek)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dans (Zevzek) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dans (Zevzek) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dans (Zevzek) 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dans (Zevzek) 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dans (Zevzek) 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dans9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dans 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danszevzek8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dans (Zevzek) 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danszevzek7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dans (Zevzek) 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dans5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dans 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dansçubuk"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dans (Çubuk)", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dansçubuk2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dans (Çubuk) 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dansçubuk3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dans (Çubuk) 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dansat"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dans (At)", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dansat2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dans (At) 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dansat3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dans (At) 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
   ["iç"] = {"mp_player_inteat@pnq", "loop", "İçmek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["kemer3"] = {"amb@code_human_police_investigate@base", "base", "Kemer 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["düşün"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Düşün", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boks"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boks Antrenmanı", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boks2"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boks Antrenmanı 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["işe"] = {"misscarsteal2peeing", "peeing_loop", "İşemek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["teslim"] = {"missminuteman_1ig_2", "handsup_base", "Teslim Ol", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lafanlat"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "Laf Anlatmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["domal"] = {"missexile3", "ex03_train_roof_idle", "Domal", AnimationOptions =
   {   
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["tavşan2"] = {"random@peyote@rabbit", "wakeup", "Tavşan 2", AnimationOptions =
   {   EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["kudur"] = {"anim@mp_fm_event@intro", "beast_transform", "Kudurmak", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["yanyat"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Yan Yatmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Güneşlenmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Güneşlenmek 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen3"] = {"missfbi3_sniping", "prone_dave", "Güneşlenmek 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["emir"] = {"misscarsteal3pullover", "pull_over_right", "Emir Vermek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["boşta"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Boşta Durmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta2"] = {"amb@world_human_hang_out_street@male_b@idle_a", "base_idle", "Boşta Durmak 2"},
   ["boşta3"] = {"friends@fra@ig_1", "base_idle", "Boşta Durmak 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta4"] = {"mp_move@prostitute@m@french", "base_idle", "Boşta Durmak 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boşta5"] = {"random@countrysiderobbery", "idle_a", "Boşta Durmak 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta6"] = {"anim@heists@heist_corona@team_idles@female_a", "idle_a", "Boşta Durmak 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta7"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Boşta Durmak 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta8"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Boşta Durmak 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta9"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Boşta Durmak 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta10"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Boşta Durmak 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşta11"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Boşta Durmak 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kaypak"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Kaypak Duruşu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sarhoşdur"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Sarhoş Durmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sarhoşdur2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Sarhoş Durmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sarhoşdur3"] = {"missarmenian2", "standing_idle_loop_drunk", "Sarhoş Durmak 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["rock"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "Rock and Roll", "Rock and Roll"},
   ["kutlama"] = {"anim@mp_player_intcelebrationfemale@air_synth", "Kutlama Sevinci", "Kutlama Sevinci"},
   ["tartış"] = {"misscarsteal4@actor", "actor_berating_loop", "Tartışmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tartış2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Tartışmak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elkoy"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "El Koymak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["öpücük"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "Öpücük Gönderme", "Blow Kiss"},
   ["öpücük2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Öpücük Gönderme 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["balerin"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Balerin Selamı"},
   ["bukadar"] = {"misscommon@response", "bring_it_on", "Bu Kadar", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["banagel"] = {"mini@triathlon", "want_some_of_this", "Bana Gel", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["kollar5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Kol Bağlamak 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kemer2"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Kemer 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kolbağla"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Kol Bağlamak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Kol Bağlamak 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["kolbağla3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Kol Bağlamak 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla4"] = {"random@street_race", "_car_b_lookout", "Kol Bağlamak 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Kol Bağlamak 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla6"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Kol Bağlamak 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla7"] = {"random@shop_gunstore", "_idle", "Kol Bağlamak 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla8"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Kol Bağlamak 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kafayasla"] = {"rcmnigel1a_band_groupies", "base_m2", "Kafa Yaslamak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hassiktir"] = {"gestures@m@standing@casual", "gesture_damn", "Hassiktirmek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["hassiktir2"] = {"anim@am_hold_up@male", "shoplift_mid", "Hassiktirmek 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["yerdesin"] = {"gestures@f@standing@casual", "gesture_hand_down", "Yerdesin", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["teslimol"] = {"random@arrests@busted", "idle_a", "Teslim Olmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["hayaksi"] = {"anim@mp_player_intcelebrationfemale@face_palm", "Niye", "Hay Aksi", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["hayaksi2"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Hay Aksi 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["hayaksi3"] = {"missminuteman_1ig_2", "tasered_2", "Hay Aksi 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["hayaksi4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Hay Aksi 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["düş"] = {"random@drunk_driver_1", "drunk_fall_over", "Düşmek"},
   ["düş2"] = {"mp_suicide", "pistol", "Düşmek 2"},
   ["düş3"] = {"mp_suicide", "pill", "Düşmek 3"},
   ["düş 4"] = {"friends@frf@ig_2", "knockout_plyr", "Düşmek 4"},
   ["düş5"] = {"anim@gangops@hostage@", "victim_fail", "Düşmek 5"},
   ["ayaktauyu"] = {"mp_sleep", "sleep_loop", "Ayakta Uyumak", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["kavgah"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Kavgaya Hazırlanma"},
   ["kavgah2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Kavgaya Hazırlanma 2"},
   ["parmak"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Orta Parmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["parmak2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Orta Parmak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bro"] = {"mp_ped_interaction", "handshake_guy_a", "Bro Selamlaşması", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["bro2"] = {"mp_ped_interaction", "handshake_guy_b", "Bro Selamlaşması 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["bekle"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Bekleme Duruşu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bekle2"] = {"missclothing", "idle_storeclerk", "Bekleme Duruşu 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle3"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Bekleme Duruşu 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle4"] = {"rcmnigel1cnmt_1c", "base", "Bekleme Duruşu 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle5"] = {"rcmjosh1", "idle", "Bekleme Duruşu 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle6"] = {"rcmjosh2", "josh_2_intp1_base", "Bekleme Duruşu 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle7"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Bekleme Duruşu 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle8"] = {"misshair_shop@hair_dressers", "keeper_base", "Bekleme Duruşu 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["çantatut"] = {"move_m@hiking", "idle", "Çanta Tutmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sarıl"] = {"mp_ped_interaction", "kisses_guy_a", "Sarılmak"},
   ["sarıl2"] = {"mp_ped_interaction", "kisses_guy_b", "Sarılmak 2"},
   ["sarıl3"] = {"mp_ped_interaction", "hugs_guy_a", "Sarılmak 3"},
   ["incele"] = {"random@train_tracks", "idle_e", "İncelemek"},
   ["kudur"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "Kudurmak", "Kudurmak", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["koşu"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Koşu Hazrılığı", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koşu2"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Koşu Hazırlığı 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koşu3"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Koşu Hazırlığı 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["keko"] = {"move_m@joy@a", "walk", "Keko Yürüyüşü", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ısın"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Isınma Hareketi", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["incele2"] = {"rcmextreme3", "idle", "İncelemek 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["incele3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "İncelemek 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tıklat"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Kapı Çalmak", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["tıklat2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Kapı Çalmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kavgah3"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Kavgaya Hazırlanma 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kucakdansı"] = {"mp_safehouse", "lap_dance_girl", "Kucak Dansı"},
   ["yaslan"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Yaslanmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslan2"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Yaslanmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslan3"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Yaslanmak 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslan4"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Yaslanmak 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["domal2"] = {"random@street_race", "_car_a_flirt_girl", "Domalmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ybar"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Yaslan Bar", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ybar2"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Yaslan Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ybar3"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Yaslan Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ybar4"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Yaslan Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ybar5"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Yaslan Bar 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ykol"] = {"timetable@mime@01_gc", "idle_a", "Yaslan Kol", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ykol2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Yaslan Kol 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ykol3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Yaslan Kol 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ykol4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Yaslan Kol 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["ykol5"] = {"rcmjosh2", "josh_2_intp1_base", "Yaslan Kol 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["ben"] = {"gestures@f@standing@casual", "gesture_me_hard", "Kendisini Göstermek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mekanik"] = {"mini@repair", "fixing_a_ped", "Mekanik", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mekanik2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mekanik 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mekanik3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mekanik 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mekanik4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mekanik 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["doktor"] = {"amb@medic@standing@tendtodead@base", "base", "Doktor", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditasyon"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditasyon Yapmak", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditasyon2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditasyon Yapmak 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditasyon3"] = {"rcmepsilonism3", "base_loop", "Meditasyon Yapmak 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal İşareti", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hayır"] = {"anim@heists@ornate_bank@chat_manager", "fail", "Hayır İşareti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hayır2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "Hayır İşareti 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bkarıştır"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Burun Karıştırmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hayır3"] = {"gestures@m@standing@casual", "gesture_no_way", "Hayır İşareti 3", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK İşareti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yorul"] = {"re@construction", "out_of_breath", "Yorulmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["al"] = {"random@domestic", "pickup_low", "Yere Uzanmak"},
   ["it"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "İtmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["it2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "İtmek 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["göster"] = {"gestures@f@standing@casual", "gesture_point", "Yer Göstermek", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["şınav"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Şınav Çekmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alkış"] = {"random@street_race", "grid_girl_race_start", "Alkışlamak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["göster2"] = {"mp_gun_shop_tut", "indicate_right", "Yer Göstermek 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aselam"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Asker Selamı", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aselam2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Asker Selamı 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["aselam3"] = {"anim@mp_player_intuppersalute", "idle_a", "Asker Selamı 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kork"] = {"random@domestic", "f_distressed_loop", "Korkmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kork2"] = {"random@homelandsecurity", "knees_loop_girl", "Korkmak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boru"] = {"misscommon@response", "screw_you", "Alayınıza Boru", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ütemizle"] = {"move_m@_idles@shake_off", "shakeoff_1", "Üstünü Temizlemek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["yaralı"] = {"random@dealgonewrong", "idle_a", "Yaralı Yatmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uyu"] = {"timetable@tracy@sleep@", "idle_c", "Uyumak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["napım"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Ne Yapayım", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["napım2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Ne Yapayım 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["otur"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Yere Oturmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur2"] = {"rcm_barry3", "barry_3_sit_loop", "Yere Oturmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Yere Oturmak 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Yere Oturmak 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Yere Oturmak 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Yere Oturmak 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Yere Oturmak 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Yere Oturmak 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Yere Oturmak 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur10"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Yere Oturmak 10", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur11"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Yere Oturmak 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur12"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Yere Oturmak 12", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur13"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Yere Oturmak 13", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["youtr14"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Yere Oturmak 14", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur15"] = {"timetable@amanda@drunk@base", "base", "Yere Oturmak 16", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["so"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sandalye Otur", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["so2"] = {"timetable@reunited@ig_10", "base_amanda", "Sandalye Otur 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["so3"] = {"timetable@ron@ig_3_couch", "base", "Sandalye Otur 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["so4"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sandalye Otur 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["so4"] = {"timetable@maid@couch@", "base", "Sandalye Otur 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["so5"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sandalye Otur 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mekik"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Mekik Çekmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alkış2"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Alkışlamak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alkış3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Alkışlamak 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alkış4"] = {"amb@world_human_cheering@male_a", "base", "Alkışlamak 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alkış5"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Alkışlamak 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alkış6"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Alkışlamak 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kokla"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Koklamak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stut"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Silah Tutmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sendele"] = {"misscarsteal4@actor", "stumble", "Sendelenmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kriz"] = {"stungun@standing", "damage", "Sinirlenmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen4"] = {"amb@world_human_sunbathe@male@back@base", "base", "Güneşlenmek 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen5"] = {"amb@world_human_sunbathe@female@back@base", "base", "Güneşlenmek 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uçak"] = {"missfam5_yoga", "a2_pose", "Kolları Yana Açmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["don"] = {"mp_sleep", "bind_pose_180", "Dona Kalmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["düşün2"] = {"mp_cp_welcome_tutthink", "b_think", "Düşünmek 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["düşün3"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Düşünmek 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["düşün4"] = {"timetable@tracy@ig_8@base", "base", "Düşünmek 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["düşün5"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Düşünmek 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ok2"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Ok İşareti 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["ok3"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Ok İşareti 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ok4"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Ok İşratei 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kyaz"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Klavyeye  Yazmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kyaz2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Klavyeye Yazmak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kyaz3"] = {"mp_prison_break", "hack_loop", "Klavyeye Yazmak 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kyaz4"] = {"mp_fbi_heist", "loop", "Klavyeye Yazmak 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Isınmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Elsalla", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["elsalla2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Elsalla2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla3"] = {"friends@fra@ig_1", "over_here_idle_a", "Elsalla3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla4"] = {"friends@frj@ig_1", "wave_a", "Elsalla4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla5"] = {"friends@frj@ig_1", "wave_b", "Elsalla5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla6"] = {"friends@frj@ig_1", "wave_c", "Elsalla6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla7"] = {"friends@frj@ig_1", "wave_d", "Elsalla7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla8"] = {"friends@frj@ig_1", "wave_e", "Elsalla8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla9"] = {"gestures@m@standing@casual", "gesture_hello", "Elsalla9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ıslık"] = {"taxi_hail", "hail_taxi", "Islık Çalmak", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["ıslık2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Islık Çalmak 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["koydukmu"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Koyduk Mu?", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["otostop"] = {"random@hitch_lift", "idle_f", "Otostop İşareti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["eğlen"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "Eğlenmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sessiz"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "Sessiz Olun", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["heykel"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Heykel Duruşu", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["heykel2"] = {"club_intro2-0", "csb_englishdave_dual-0", "Heykel Duruşu 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["westside"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "WestSide İşareti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["eastside"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "EastSide İşareti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["eastside2"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@bodhi@rds@base", "idle_a", "Eastside İşareti 2 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["eastside3"] = {"amb@code_human_in_car_mp_actions@gang_sign_a@low@ps@base", "idle_a", "Eastside İşareti 3 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["eastside4"] = {"amb@code_human_in_car_mp_actions@gang_sign_b@std@ds@base", "idle_a", "Eastside İşareti 4 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["v"] = {"amb@code_human_in_car_mp_actions@v_sign@bodhi@rps@base", "idle_a", "V İşareti ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["parmaksok"] = {"anim@mp_player_intupperdock", "idle_a", "Parmak Sok ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["saatkaç"] = {"amb@code_human_wander_idles_fat@male@idle_a", "idle_a_wristwatch", "Saate Bakmak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elmatopla"] = {"amb@prop_human_movie_bulb@idle_a", "idle_a", "Elma Toplamak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true, 
   }},
   ["yaslan5"] = {"amb@prop_human_seat_sunlounger@female@base", "base", "Yaslanmak 5 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true, 
   }}, 
   ["uyu2"] = {"amb@world_human_bum_slumped@male@laying_on_left_side@base", "base", "Uyumak 2 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kasıl"] = {"amb@world_human_muscle_flex@arms_at_side@idle_a", "idle_a", "Kasılmak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kyaz5"] = {"anim@heists@fleeca_bank@scope_out@cashier_loop", "cashier_loop", "Klavyeye Yazmak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
   }}, 
   ["otur16"] = {"anim@heists@narcotics@funding@gang_chat", "gang_chatting_combined", "Yere Oturmak 16 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["teslimol2"] = {"anim@heists@ornate_bank@hostages@cashier_b@", "flinch_loop_underfire", "Teslim Olmak 2 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur17"] = {"anim@heists@prison_heistig_5_p1_rashkovsky_idle", "idle_180", "Yere Oturmak 17 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["parmak3"] = {"anim@mp_player_intcelebrationfemale@finger", "finger", "Parmak Çekmek ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["otur18"] = {"anim@mp_rollarcoaster", "hands_up_idle_a_player_one", "Yere Oturmak 18 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }}, 
   ["stut2"] = {"combat@aim_variations@1h@gang", "aim_variation_b", "Silah Tutmak 2 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ystut"] = {"combat@damage@injured_pistol@to_writhe", "variation_b", "Yaralı Silah Tutmak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaralı2"] = {"combat@damage@writhe", "writhe_loop", "Yaralı Yatmak 2 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }}, 
   ["kasaaç"] = {"mini@safe_cracking", "dial_turn_anti_slow", "Kasa Açmak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["yaslan6"] = {"mini@strip_club@backroom@", "leadin_loop_idle_c_stripper_c", "Yaslanmak 6 ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["memegöster"] = {"mini@strip_club@backroom@", "stripper_b_backroom_idle_b", "Meme Göstermek ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }}, 
   ["bit"] = {"mini@strip_club@backroom@", "stripper_c_leadin_backroom_idle_a", "Bacak Arası ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["memesalla"] = {"mini@strip_club@idles@stripper", "stripper_idle_05", "Meme Sallamak ~p~ YENİ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},    
   ["öl"] = {"missarmenian2", "drunk_loop", "Ölü Yatışı", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["öl2"] = {"missarmenian2", "corpse_search_exit_ped", "Ölü Yatışı 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["öl3"] = {"anim@gangops@morgue@table@", "body_search", "Ölü Yatışı 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["öl4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Ölü Yatışı 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["öl5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Ölü Yatışı 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["incele4"] = {"creatures@rottweiler@tricks@", "petting_franklin", "İncelemek 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sürün"] = {"move_injured_ground", "front_loop", "Sürünmek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["takla"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Takla Atmak"},
   ["takla2"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Takla Atmak 2"},
   ["kay"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Kaymak"},
   ["kay2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Kaymak 2"},
   ["kay3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Kaymak 3"},
   ["bvuruş"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Beyzbol Vuruşu"},
   ["parmak4"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Parmak Çekmek 4", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["parmak5"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Parmak Çekmek 5", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["selamla"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Selamlamak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["selamla2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Selamlamak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["akitle"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Araba Kitleme", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["bvuruş2"] = {"rcmnigel1d", "swing_a_mark", "Beyzbol Vuruşu 2"},
   ["ye"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Yemek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["stut3"] = {"move_m@intimidation@cop@unarmed", "idle", "Silah Tutmak 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle9"] = {"random@shop_tattoo", "_idle_a", "Bekleme Duruşu 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle10"] = {"missbigscore2aig_3", "wait_for_van_c", "Bekleme Duruşu 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle11"] = {"rcmjosh1", "idle", "Bekleme Duruşu 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle12"] = {"rcmnigel1a", "base", "Bekleme Duruşu 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kucakdansı2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Kucak Dansı 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kucakdansı3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Kucak Dansı 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kucakdansı4"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Kucak Dansı 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk Yapmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tokat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Tokat Atmak 60", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["kafaat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Kafa Atmak"},
   ["yılan"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Yılan Yapmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barış"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Barış Yapmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barış2"] = {"anim@mp_player_intupperpeace", "idle_a", "Barış Yapmak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["doktor2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Doktor 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["doktor3"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Doktor 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uçak2"] = {"missfbi1", "ledge_loop", "Uçak Hareketi 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uçak3"] = {"missfbi1", "ledge_loop", "Uçak Hareketi 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gözetle"] = {"random@paparazzi@peek", "left_peek_a", "Gözetlemek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["öksür"] = {"timetable@gardener@smoking_joint", "idle_cough", "Öksürmek", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ısın2"] = {"mini@triathlon", "idle_e", "Isınmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın3"] = {"mini@triathlon", "idle_f", "Isınmak 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın4"] = {"mini@triathlon", "idle_d", "Isınmak 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın5"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Isınmak 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sevin"] = {"rcmfanatic1celebrate", "celebrate", "Kutlama Sevinci", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boks3"] = {"rcmextreme2", "loop_punching", "Boks Antrenmanı 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kahraman"] = {"rcmbarry", "base", "Kahraman Duruşu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kahraman2"] = {"rcmbarry", "base", "Kahraman 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["büyü"] = {"rcmbarry", "mind_control_b_loop", "Büyü Yapmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["büyü2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Büyü Yapmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palyaço"] = {"rcm_barry2", "clown_idle_0", "Palyaço ", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palyaço2"] = {"rcm_barry2", "clown_idle_1", "Palyaço 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palyaço3"] = {"rcm_barry2", "clown_idle_2", "Palyaço 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palyaço4"] = {"rcm_barry2", "clown_idle_3", "Palyaço 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["palyaço5"] = {"rcm_barry2", "clown_idle_6", "Palyaço 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["podyum"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Podyum Duruşu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["podyum2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Podyum Duruşu 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["podyum3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Podyum Duruşu 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gduruş"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Gergin Duruşu", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gduruş2"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Gergin Duruşu 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gduruş3"] = {"rcmme_tracey1", "nervous_loop", "Gergin Duruşu 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elkaşı"] = {"mp_arresting", "a_uncuff", "El Kaşımak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dua"] = {"timetable@amanda@ig_4", "ig_4_base", "Dua Etmek", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stut4"] = {"random@atmrobberygen", "b_atm_mugging", "Silah Tutmak 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["telsiz"] = {"random@arrests", "generic_radio_chatter", "Telsize Bakmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["çek"] = {"random@mugging4", "struggle_loop_b_thief", "Çekmek", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["kuş"] = {"random@peyote@bird", "wakeup", "Kuş Haraketi"},
   ["tavuk"] = {"random@peyote@chicken", "wakeup", "Tavuk Hareketi", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["köpek"] = {"random@peyote@dog", "wakeup", "Köpek taklidi"},
   ["tavşan3"] = {"random@peyote@rabbit", "wakeup", "Tavşan 3"},
   ["domal3"] = {"missexile3", "ex03_train_roof_idle", "Domalmak 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lafanlat2"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "Laf Anlatmak 2", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["üstdüzelt"] = {"missmic4", "michael_tux_fidget", "Üstünü Düzeltmek", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["ehavaya"] = {"missminuteman_1ig_2", "handsup_base", "Eller Havaya", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["çiş"] = {"misscarsteal2peeing", "peeing_loop", "Çiş Etmek", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["barbekü"] = {"MaleScenario", "PROP_HUMAN_BBQ", "Barbekü Yapmak"},
   ["mekanik5"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Mekanik 5"},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Bum Sleep"},
   ["eğlen2"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Eğlenmek 2"},
   ["barfiks"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Barfiks Çekmek"},
   ["not2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Not Almak 2"},
   ["kemer"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Kemer"},
   ["çubuk"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Çubuk Sallamak"},
   ["kayıt"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Telefonla Kayıt Etmek"},
   ["kasıl2"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Kasılmak "},
   ["bekle15"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Bekleme Duruşu 15"},
   ["çekiç"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Çekiç Çakmak"},
   ["bekle14"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Bekleme Duruşu 14"},
   ["bekle13"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Bekleme Duruşu 13"},
   ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Janitor"},
   ["koşu4"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Koşu Hazırlığı 4"},
   ["incele5"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "İncelemek 5"},
   ["çimbiç"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Çim Biçmek"},
   ["yaslan7"] = {"Scenario", "WORLD_HUMAN_LEANING", "Yaslanmak 7"},
   ["ybar6"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Yaslan Bar 6"},
   ["bakın"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Etrafa Bakınmak"},
   ["temizle3"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Temizle 3"},
   ["doktor4"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Doktor 4"},
   ["gitar3"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Gitar 3"},
   ["not"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Not Almak"},
   ["kilitaç"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Kilit Açmak"},
   ["parti"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Parti"},
   ["mesaj"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Mesajlaşmak"},
   ["podyum4"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Podyum Duruşu 4"},
   ["podyum5"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Podyum Duruşu 5"},
   ["elyıka"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Ellerini Yıkamak"},
   ["kayıt2"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Telefonla Kayıt Etmek 2"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["so6"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sandalye Otur 6"},
   ["sigara"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Sigara İçmek"},
   ["ot"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Ot İçmek"},
   ["heykel3"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Heykel Duruşu 3"},
   ["güneşlen6"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Güneşlenmek 6"},
   ["güneşlen7"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Güneşlenmek 7"},
   ["kaynak"] = {"Scenario", "WORLD_HUMAN_WELDING", "Kaynak Makinası"},
   ["bakın2"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Etrafa Bakınmak 2"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["kavgah4"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Kavgaya Hazırlanma 4"},
   ["kavgah5"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Kavgaya Hazırlanma 5"},
   ["200ıq"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "200 IQ", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["200ıq2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "200 IQ 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boks3"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boks Antrenmanı 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boks4"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boks Antrenmanı 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["koku"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Kötü Koku Almak", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["düşün6"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Düşünmek 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["çekidüzen"] = {"clothingtie", "try_tie_positive_a", "Çeki Düzen vermek", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
   ["şemsiye"] = {"amb@world_human_drinking@coffee@male@base", "base", "Şemsiye", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["not3"] = {"missheistdockssetup1clipboard@base", "base", "Not Almak 3", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kutu"] = {"anim@heists@box_carry@", "idle", "Kutu", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gül"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Gül", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sigara2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Sigara", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sigara3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Sigara 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sigara4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Sigara 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["bavul"] = {"missheistdocksprep1hold_cellphone", "static", "Bavul", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["işçantası"] = {"missheistdocksprep1hold_cellphone", "static", "İş Çantası", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sabıka"] = {"mp_character_creation@customise@male_a", "loop", "Sabıka Tabelası", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kahve"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Kahve", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["viski"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Viski", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bira"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Bira", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bardak"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Bardak", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["sandviç"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandviç", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
   }},
   ["kola"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Kola", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["çikolata"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Çikolata", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
   }},
   ["şarap"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Şarap", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["kadeh"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Kadeh", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["şampanya"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Şampanya", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["puro"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Puro", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["puro2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Puro 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["gitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitar", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Gitar 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitar3"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Elektro Gitar", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitar4"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Elektro Gitar 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["kitap"] = {"cellphone@", "cellphone_text_read_base", "Kitap", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["buket"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Çiçek Buketi", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["ayıcık"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Ayıcık", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["sırtçantası"] = {"move_p_m_zero_rucksack", "idle", "Sırt Çantası", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["pano"] = {"missfam4", "base", "Pano", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["harita"] = {"amb@world_human_tourist_map@male@base", "base", "Harita", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["evsiz"] = {"amb@world_human_bum_freeway@male@base", "base", "Evsiz Tabelası", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["parasaç"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Para Saç", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["kamera"] = {"amb@world_human_paparazzi@male@base", "base", "Kamera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
   ["şampanyapatlat"] = {"anim@mp_player_intupperspray_champagne", "idle_a", "Şampanya Patlat", AnimationOptions =
   {
       Prop = 'ba_prop_battle_champ_open',
       PropBone = 28422,
       PropPlacement = {0.0,0.0,0.0,0.0,0.0,0.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_ba_club",
       PtfxName = "scr_ba_club_champagne_spray",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       PtfxInfo = Config.Languages[Config.MenuLanguage]['spraychamp'],
       PtfxWait = 500,
   }},
   ["ot"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Ot", AnimationOptions =
   {
       Prop = 'p_cs_joint_02',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["sigara"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigara", AnimationOptions =
   {
       Prop = 'prop_amb_ciggy_01',
       PropBone = 47419,
       PropPlacement = {0.015, -0.009, 0.003, 55.0, 0.0, 110.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["açanta"] = {"missheistdocksprep1hold_cellphone", "static", "Avukat Çantası", AnimationOptions =
   {
       Prop = "prop_ld_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet"] = {"amb@world_human_tourist_map@male@base", "base", "Tablet", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {0.0, -0.03, 0.0, 20.0, -90.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tablet2"] = {"amb@code_human_in_bus_passenger_idles@female@tablet@idle_a", "idle_a", "Tablet 2", AnimationOptions =
   {
       Prop = "prop_cs_tablet",
       PropBone = 28422,
       PropPlacement = {-0.05, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["telkonuş"] = {"cellphone@", "cellphone_call_listen_base", "Telefonla Konuş", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["telefon"] = {"cellphone@", "cellphone_text_read_base", "Telefonla Oyna", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["temizle"] = {"timetable@floyd@clean_kitchen@base", "base", "Temizle", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["temizle2"] = {"amb@world_human_maid_clean@", "base", "Temizle 2", AnimationOptions =
   {
       Prop = "prop_sponge_01",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, -0.01, 90.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
}