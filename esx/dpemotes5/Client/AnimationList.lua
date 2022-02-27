DP = {}

DP.Expressions = {
   ["Sinirli"] = {"Expression", "mood_angry_1"},
   ["Sarhoş"] = {"Expression", "mood_drunk_1"},
   ["Aptal"] = {"Expression", "pose_injured_1"},
   ["Çarpıl"] = {"Expression", "electrocuted_1"},
   ["Huysuz"] = {"Expression", "effort_1"},
   ["Huysuz2"] = {"Expression", "mood_drivefast_1"},
   ["Huysuz3"] = {"Expression", "pose_angry_1"},
   ["Mutlu"] = {"Expression", "mood_happy_1"},
   ["Yaralı"] = {"Expression", "mood_injured_1"},
   ["Oyuncu"] = {"Expression", "mood_dancing_low_1"},
   ["Mouthbreather"] = {"Expression", "smoking_hold_1"},
   ["NeverBlink"] = {"Expression", "pose_normal_1"},
   ["One Eye"] = {"Expression", "pose_aiming_1"},
   ["ŞokOl"] = {"Expression", "shocked_1"},
   ["ŞokOl2"] = {"Expression", "shocked_2"},
   ["Uyku"] = {"Expression", "mood_sleeping_1"},
   ["Uyku2"] = {"Expression", "dead_1"},
   ["Uyku3"] = {"Expression", "dead_2"},
   ["KendiniBeğenmiş"] = {"Expression", "mood_smug_1"},
   ["Spekülativ"] = {"Expression", "mood_aiming_1"},
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
   ["tokalaş"] = {"mp_ped_interaction", "handshake_guy_a", "Tokalaş", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["tokalaş2"] = {"mp_ped_interaction", "handshake_guy_b", "Tokalaş 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["sarıl"] = {"mp_ped_interaction", "kisses_guy_a", "Sarıl", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["sarıl2"] = {"mp_ped_interaction", "kisses_guy_b", "Sarıl 2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["dostum"] = {"mp_ped_interaction", "hugs_guy_a", "Dostum", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["dostum2"] = {"mp_ped_interaction", "hugs_guy_b", "Dostum 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["ver"] = {"mp_common", "givetake1_a", "Ver", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["ver2"] = {"mp_common", "givetake1_b", "Ver 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["beyzbol"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Beyzbol", "baseballthrow"},
   ["beyzbol At"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Beyzbol At", "baseball"},
   ["durdimdik"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Dur (Dimdik)", "stickup2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["durkorkarak"] = {"missminuteman_1ig_2", "handsup_base", "Dur (Korkarak)", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["yumrukat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Yumruk At", "punched"},
   ["yumrukye"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Yumruk Yem", "punch"},
   ["kafaat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Kafa At", "headbutted"},
   ["kafaye"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Kafa Ye", "headbutt"},
   ["tokat2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Tokat 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["tokat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Tokat", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["tokayyem"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Tokay Yemek", "slap"},
   ["tokatyemek2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Tokay Yemek 2", "slap2"},
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
   ["iç"] = {"mp_player_inteat@pnq", "loop", "İç", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["canavar"] = {"anim@mp_fm_event@intro", "beast_transform", "Canavar", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["takılmak"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Takılmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uzanmak"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Uzanmak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uzanmak2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Uzanmak 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yüzüstü"] = {"missfbi3_sniping", "prone_dave", "Yüzüstü", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kenarageç"] = {"misscarsteal3pullover", "pull_over_right", "Kenara Geç", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["boşdur"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Boş Dur", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Boş Dur 8"},
   ["boşdur9"] = {"friends@fra@ig_1", "base_idle", "Boş Dur 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur10"] = {"mp_move@prostitute@m@french", "idle", "Boş Dur 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["boşdur11"] = {"random@countrysiderobbery", "idle_a", "Boş Dur 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Boş Dur 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Boş Dur 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Boş Dur 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Boş Dur 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Boş Dur 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boşdur7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Boş Dur 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bekle3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Bekle 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["beklesarhoş"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Bekle (Sarhoş)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["beklesarhoş2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Bekle (Sarhoş) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["beklesarhoş3"] = {"missarmenian2", "standing_idle_loop_drunk", "Bekle (Sarhoş) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Gitar"},
   ["havakokla"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Hava Kokla"},
   ["tartış"] = {"misscarsteal4@actor", "actor_berating_loop", "Tartış", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tartış2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Tartış 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barmen"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Barmen", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["öpücükat"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Öpücük At"},
   ["öpücükat2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Öpücük Atmak 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["reverans"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Reverans"},
   ["bırakgelsin"] = {"misscommon@response", "bring_it_on", "Bırak Gelsin", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["banagel"] = {"mini@triathlon", "want_some_of_this", "Bana Gel", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["polis2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Polis 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["polis3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Polis 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kolbağla"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Kol Bağla", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Kol Bağla 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["kolbağla3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Kol Bağla 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla4"] = {"random@street_race", "_car_b_lookout", "Kol Bağla 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elbağla3"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "El Bağla 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elbağla2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "El Bağla 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla5"] = {"random@shop_gunstore", "_idle", "Kol Bağla 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elbağla"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "El Bağla", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kolbağla6"] = {"rcmnigel1a_band_groupies", "base_m2", "Kol Bağla 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kahretsin"] = {"gestures@m@standing@casual", "gesture_damn", "Kahretsin", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["kahretsin2"] = {"anim@am_hold_up@male", "shoplift_mid", "Kahretsin 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["aşağıgöster"] = {"gestures@f@standing@casual", "gesture_hand_down", "Aşağı Göster", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["teslim"] = {"random@arrests@busted", "idle_a", "Teslim Ol", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yüzünügizle2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Yüzünü Gizle 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["yüzünügizle"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Yüzünü Gizle", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["yüzünügizle3"] = {"missminuteman_1ig_2", "tasered_2", "Yüzünü Gizle 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["yüzünügizle4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Yüzünü Gizle 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["düşsarhoş"] = {"random@drunk_driver_1", "drunk_fall_over", "Düş (Sarhoş)"},
   ["intihar"] = {"mp_suicide", "pistol", "İntihar"},
   ["intihar"] = {"mp_suicide", "pill", "İntihar 2"},
   ["düşyumruk"] = {"friends@frf@ig_2", "knockout_plyr", "Düş (Yumruk)"},
   ["infaz"] = {"anim@gangops@hostage@", "victim_fail", "İnfaz"},
   ["düşuyku"] = {"mp_sleep", "sleep_loop", "Düş (Uyku)", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["dövüş"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Dövüş"},
   ["dövüş2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Dövüş2"},
   ["parmak"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Parmak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["parmak2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Parmak 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tokalaş"] = {"mp_ped_interaction", "handshake_guy_a", "Tokalaş", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["tokalaş2"] = {"mp_ped_interaction", "handshake_guy_b", "Tokalaş 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["bekle4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Bekle 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bekle5"] = {"missclothing", "idle_storeclerk", "Bekle 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Bekle 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle7"] = {"rcmnigel1cnmt_1c", "base", "Bekle 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle8"] = {"rcmjosh1", "idle", "Bekle 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle9"] = {"rcmjosh2", "josh_2_intp1_base", "Bekle 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Bekle 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle11"] = {"misshair_shop@hair_dressers", "keeper_base", "Bekle 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["doğa"] = {"move_m@hiking", "idle", "Doğa Yürüyüşü", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sarıl"] = {"mp_ped_interaction", "kisses_guy_a", "Sarıl"},
   ["sarıl2"] = {"mp_ped_interaction", "kisses_guy_b", "Sarıl 2"},
   ["sarıl3"] = {"mp_ped_interaction", "hugs_guy_a", "Sarıl 3"},
   ["denetle"] = {"random@train_tracks", "idle_e", "Denetle"},
   ["jimnastik"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jimnastik", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["koşu2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Koşu 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koşu3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Koşu 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koşu4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Koşu 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["koşu5"] = {"move_m@joy@a", "walk", "Koşu 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dizçök2"] = {"rcmextreme3", "idle", "Diz Çök 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dizçök3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Diz Çökmek 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["vur"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Vur", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["vur2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Vur 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Parmaklarını Kıtlat", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kucakdansı"] = {"mp_safehouse", "lap_dance_girl", "Kucak Dansı"},
   ["yaslan2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Yaslan 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslan3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Yaslan 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslan4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Yaslan 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslan5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Yaslan 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslanflört"] = {"random@street_race", "_car_a_flirt_girl", "Yaslan (Flört)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Yaslan (Bar) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Yaslan (Bar) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Yaslan (Bar) 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yaslanyüksek"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Yaslan (Yüksek)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaslanyüksek2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Yaslan (Bar) 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaslankol"] = {"timetable@mime@01_gc", "idle_a", "Yaslan (Kol)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaslankol2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Yaslan (Kol) 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaslankol3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Yaslan (Kol) 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaslankol4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Yaslan (Kol) 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["yaslankol5"] = {"rcmjosh2", "josh_2_intp1_base", "Yaslan (Kol) 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["ben"] = {"gestures@f@standing@casual", "gesture_me_hard", "Ben", AnimationOptions =
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
   ["yaralıbak"] = {"amb@medic@standing@tendtodead@base", "base", "Yaralı Bak", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditasyon"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditasyon", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditasyon2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditasyon 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditasyon3"] = {"rcmepsilonism3", "base_loop", "Meditasyon 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hayır"] = {"anim@heists@ornate_bank@chat_manager", "fail", "Hayır", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hayır2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "Hayır 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["burunkarıştır"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Burun Karıştır", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["asla"] = {"gestures@m@standing@casual", "gesture_no_way", "Asla", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "Okay", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nefesnefese"] = {"re@construction", "out_of_breath", "Nefes Nefese", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yerdenal"] = {"random@domestic", "pickup_low", "Yerden Al"},
   ["it"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "İt", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["it2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "İt 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["göster"] = {"gestures@f@standing@casual", "gesture_point", "Göster", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kaldır"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Kaldır", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yarışbaşlat"] = {"random@street_race", "grid_girl_race_start", "Yarış Başlat", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sağıgöster"] = {"mp_gun_shop_tut", "indicate_right", "Sağı Göster", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["asker"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Asker", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["asker2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Asker 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["asker3"] = {"anim@mp_player_intuppersalute", "idle_a", "Asker 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kork"] = {"random@domestic", "f_distressed_loop", "Kork", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kork2"] = {"random@homelandsecurity", "knees_loop_girl", "Kork 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nasılkoyduk"] = {"misscommon@response", "screw_you", "Nasıl Koyduk!", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["temizlen"] = {"move_m@_idles@shake_off", "shakeoff_1", "Temizlen", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["vurul"] = {"random@dealgonewrong", "idle_a", "Vurul", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uyu"] = {"timetable@tracy@sleep@", "idle_c", "Uyu", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["eyani"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "E Yani?", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["eyani2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "E Yani? 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["otur"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Otur", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur2"] = {"rcm_barry3", "barry_3_sit_loop", "Otur 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Otur 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Otur 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Otur 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Otur 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Otur 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Otur 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otur9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Otur 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["oturyaslan"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Otur (Yaslan)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["oturüzgün"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Otur (Üzgün)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["oturkorkak"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Otur (Korkak)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["oturkorkak2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Otur (Korkak) 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["oturkorkak3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Otur (Korkak) 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursarhoş"] = {"timetable@amanda@drunk@base", "base", "Otur (Sarhoş)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursandalye2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sandalye Otur 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursandalye3"] = {"timetable@reunited@ig_10", "base_amanda", "Sandalye Otur 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursandalye4"] = {"timetable@ron@ig_3_couch", "base", "Sandalye Otur 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursandalye5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sandalye Otur 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursandalye6"] = {"timetable@maid@couch@", "base", "Sandalye Otur 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["otursandalyeyan"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sandalye Otur (Yan)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mekikçek"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Mekik Çek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alkışsinirli"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Alkış (Sinirli)", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["alkışyavaş3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Alkış (Yavaş) 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alkış"] = {"amb@world_human_cheering@male_a", "base", "Alkış", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alkışyavaş"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Alkışla (Yavaş)", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["alkışyavaş2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Alkışla (Yavaş) 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kokla"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Kokla", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["silahtut"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Silah Tut", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sendele"] = {"misscarsteal4@actor", "stumble", "Sendele", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sinirkrizi"] = {"stungun@standing", "damage", "Sinir Krizi", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen"] = {"amb@world_human_sunbathe@male@back@base", "base", "Güneşlen", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["güneşlen2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Güneşlen 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["titanik"] = {"missfam5_yoga", "a2_pose", "Titanik", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["titanik2"] = {"mp_sleep", "bind_pose_180", "Titanik 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["düşün5"] = {"mp_cp_welcome_tutthink", "b_think", "Düşün 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["düşün"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Düşün", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["düşün3"] = {"timetable@tracy@ig_8@base", "base", "Düşün 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["düşün2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Düşün 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["başparmak3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Başparmak Havaya! 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["başparmak2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Başparmak Havaya! 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["başparmak"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Başparmak Havaya!", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaz"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Yaz", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaz2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Yaz 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaz3"] = {"mp_prison_break", "hack_loop", "Yaz 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["yaz4"] = {"mp_fbi_heist", "loop", "Yaz 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısıt"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Isıt", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "El Salla 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["elsalla2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "El Salla 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla3"] = {"friends@fra@ig_1", "over_here_idle_a", "El Salla 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla"] = {"friends@frj@ig_1", "wave_a", "El Salla", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla5"] = {"friends@frj@ig_1", "wave_b", "El Salla 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla6"] = {"friends@frj@ig_1", "wave_c", "El Salla 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla7"] = {"friends@frj@ig_1", "wave_d", "El Salla 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla8"] = {"friends@frj@ig_1", "wave_e", "El Salla 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["elsalla9"] = {"gestures@m@standing@casual", "gesture_hello", "Wave 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ıslık"] = {"taxi_hail", "hail_taxi", "Islık", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["ıslık2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Islık 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["otostop"] = {"random@hitch_lift", "idle_f", "Otostop", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["heykel2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Heykel 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["heykel3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Heykel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangselam"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Selam", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangselam2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Selam 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bayıl"] = {"missarmenian2", "drunk_loop", "Bayıl", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bayıl2"] = {"missarmenian2", "corpse_search_exit_ped", "Bayıl 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bayıl3"] = {"anim@gangops@morgue@table@", "body_search", "Bayıl 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bayıl4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Bayıl 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["bayıl5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Bayıl 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uğraş"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Uğraş", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sürün"] = {"move_injured_ground", "front_loop", "Sürün", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["takla2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Takla 2"},
   ["takla"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Takla"},
   ["kay"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Kay"},
   ["kay2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Kay 2"},
   ["kay3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Kay 3"},
   ["beyzbolvuruşu"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Beyzbol Vuruşu"},
   ["ortaparmak"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Orta Parmak", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["ortaparmak2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Orta Parmak 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["gösteribitti"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Gösteri Bitti", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gösteribitti2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Gösteri Bitti 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kilitle"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Kilitle", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
   ["ye"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ye", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["bekçi"] = {"move_m@intimidation@cop@unarmed", "idle", "Bekçi", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle"] = {"random@shop_tattoo", "_idle_a", "Bekle", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle2"] = {"missbigscore2aig_3", "wait_for_van_c", "Bekle 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle12"] = {"rcmjosh1", "idle", "Bekle 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bekle13"] = {"rcmnigel1a", "base", "Bekle 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kucakdansı2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Kucak Dansı 1", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kucakdansı3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Kucak Dansı 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kucakdansı3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Kucak Dansı 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tokat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Tokat", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["kafaat"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Kafa At"},
   ["balıkdansı"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Balık Dansı", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barış"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Barış", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["barış2"] = {"anim@mp_player_intupperpeace", "idle_a", "Barış 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kalpmasajı"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Kalp Masajı", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kalpmasajı2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "Kalp Masajı 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["sırtlan"] = {"missfbi1", "ledge_loop", "Sırtlan", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["uçak"] = {"missfbi1", "ledge_loop", "Uçak", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dikizle"] = {"random@paparazzi@peek", "left_peek_a", "Dikizle", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["öksür"] = {"timetable@gardener@smoking_joint", "idle_cough", "Öksür", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ısın"] = {"mini@triathlon", "idle_e", "Isın", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın2"] = {"mini@triathlon", "idle_f", "Isın 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın3"] = {"mini@triathlon", "idle_d", "Isın 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["ısın4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Isın 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kutla"] = {"rcmfanatic1celebrate", "celebrate", "Kutla", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["yumrukla"] = {"rcmextreme2", "loop_punching", "Yumrukla", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kahraman"] = {"rcmbarry", "base", "Kahraman", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kahraman2"] = {"rcmbarry", "base", "Kahraman 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["büyü"] = {"rcmbarry", "mind_control_b_loop", "Büyü", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["büyü2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Büyü 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["palyaço"] = {"rcm_barry2", "clown_idle_0", "Palyaço", AnimationOptions =
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
   ["kıyafetdene"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Kıyafet Dene", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kıyafetdene2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Kıyafet Dene 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kıyafetdene3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Kıyafet Dene 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gergin2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Gergin 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gergin"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Gergin", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gergin3"] = {"rcmme_tracey1", "nervous_loop", "Gergin 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["çözümara"] = {"mp_arresting", "a_uncuff", "Çözüm Ara", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["silahdaya"] = {"random@atmrobberygen", "b_atm_mugging", "Kafasına Silah Daya", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radyo"] = {"random@arrests", "generic_radio_chatter", "Radyo", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["çek"] = {"random@mugging4", "struggle_loop_b_thief", "Çek", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kuş"] = {"random@peyote@bird", "wakeup", "Kuş"},
   ["tavuk"] = {"random@peyote@chicken", "wakeup", "Tavuk", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["Havla"] = {"random@peyote@dog", "wakeup", "Havla"},
   ["tavşan"] = {"random@peyote@rabbit", "wakeup", "Tavşan"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lafanlat"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "Laf Anlat", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["üstünüdüzelt"] = {"missmic4", "michael_tux_fidget", "Üstünü Düzelt", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["ellerinikaldır"] = {"missminuteman_1ig_2", "handsup_base", "Ellerini Kaldır", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["işe"] = {"misscarsteal2peeing", "peeing_loop", "İşe", AnimationOptions =
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
   ["barbekü"] = {"MaleScenario", "PROP_HUMAN_BBQ", "Barbekü"},
   ["Karıştır"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Karıştır"},
   ["uyuyakal"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Uyuyakal"},
   ["tezahürat"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Tezahürat"},
   ["barfiks"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Barfiks"},
   ["notalerkek"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Not Al (Erkek)"},
   ["polisduruşu"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Polis Duruşu"},
   ["uçakparket"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Uçak Parket"},
   ["kayıtal"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Kayıt Al"},
   ["kasıl"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Kasıl"},
   ["koruma"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Koruma"},
   ["çiviçak"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Çivi Çak"},
   ["dinle"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Dinle"},
   ["sabırsız"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Sabırsız"},
   ["temizlikçi"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Temizlikçi"},
   ["koşu"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Koşu"},
   ["dizçök"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Diz Çök"},
   ["yapraktemizleme"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Yaprak Temizleme"},
   ["yaslan"] = {"Scenario", "WORLD_HUMAN_LEANING", "Yaslan"},
   ["yaslanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Yaslan (Bar)"},
   ["etrafabakın"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Etrafa Bakın"},
   ["sil"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Sil"},
   ["yaralıyabak"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Yaralıya Bak"},
   ["müzisyen"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Müzisyen (Erkek)"},
   ["notal2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Not Al 2"},
   ["parkmetre"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Park-metre"},
   ["partidetakıl"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Partide Telefonla Takıl"},
   ["mesajlaş"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Mesajlaş"},
   ["fahişe2"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Fahişe Bekleyişi (Usta)"},
   ["fahişe1"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Fahişe Bekleyişi (Acemi)"},
   ["subirikintisi"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Su Birikintisi"},
   ["telefonkayıt"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Telefonla Kayıt Al"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sandalyeotur"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sandalyeye Otur"},
   ["sigaraiç"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Sigara İç"},
   ["ot"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Ot İç (Erkek)"},
   ["heykel"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Heykel Ol"},
   ["güneşlen3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Güneşlen 3"},
   ["güneşlenön"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Güneşlen (Sırtüstü)"},
   ["kaynak"] = {"Scenario", "WORLD_HUMAN_WELDING", "Kaynak Yap"},
   ["vitrin"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Vitrin İncele"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["boğazkes"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Boğaz Kesmek"},
   ["boğazkes2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Boğaz Kes 2"},
   ["büyücülük"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Büyücülük", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["büyücülük2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Büyücülük 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boksyap"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boks Yap", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boks2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boks Yap 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["kötükoku"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Kötü Koku!", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["düşün4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Düşün 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["kravat"] = {"clothingtie", "try_tie_positive_a", "Kravatını Düzelt", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
   ["şemsiye"] = {"amb@world_human_drinking@coffee@male@base", "base", "Şemsiye Aç", AnimationOptions =
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

   ["notal"] = {"missheistdockssetup1clipboard@base", "base", "Not Al", AnimationOptions =
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
   ["sigara2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Sigara 2", AnimationOptions =
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
   ["bavul2"] = {"missheistdocksprep1hold_cellphone", "static", "Bavul 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["tabela"] = {"mp_character_creation@customise@male_a", "loop", "Tabela", AnimationOptions =
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
   ["içecek"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "İçecek", AnimationOptions =
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
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
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
   ["şampanya2"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Şampanya 2", AnimationOptions =
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
   ["sigaraçıkar1"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigara Çıkar 1", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["sigaraçıkar2"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Sigara Çıkar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 2600
   }},
   ["gitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitar Çal", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Gitar Çal 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitar3"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitar Çal (Elektro Gitar)", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["gitar4"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Gitar Çal (Bas Gitar)", AnimationOptions =
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
   ["evrak"] = {"missfam4", "base", "Evrak", AnimationOptions =
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
   ["dilen"] = {"amb@world_human_bum_freeway@male@base", "base", "Dilen", AnimationOptions =
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
   ["tüttür"] = {"amb@world_human_smoking@male@male_a@enter", "enter", "Tüttür", AnimationOptions =
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
   ["çanta"] = {"missheistdocksprep1hold_cellphone", "static", "Çanta", AnimationOptions =
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
   ["telefonlakonuş"] = {"cellphone@", "cellphone_call_listen_base", "Telefonla Konuş", AnimationOptions =
   {
       Prop = "prop_npc_phone_02",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["telefon"] = {"cellphone@", "cellphone_text_read_base", "Telefon", AnimationOptions =
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