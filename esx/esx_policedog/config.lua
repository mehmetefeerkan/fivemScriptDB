-- TriggerEvent('esx_policedog:openMenu') to open menu

Config = {
    Job = 'police',
    Command = 'adnan', -- set to false if you dont want to have a command
    Model = 351016938,
    TpDistance = 50.0,
    Sit = {
        dict = 'creatures@rottweiler@amb@world_dog_sitting@base',
        anim = 'base'
    },
    Drugs = {'weed','meth_pooch','mercan_pooch','weed_pooch','choped_sarap','opium_pooch','opium','coke','petrol','petrol_pooch', 'coke_pooch', 'meth'}, -- add all drugs here for the dog to detect
}

Strings = {
    ['not_police'] = ' ~r~ Sen Polis ~s~ değilsin!',
    ['menu_title'] = 'K9',
    ['take_out_remove'] = 'Köpeği Çağır / Gönder',
    ['deleted_dog'] = 'Polis Köpeği Gönderildi',
    ['spawned_dog'] = 'Polis Köpeği Geldi',
    ['sit_stand'] = 'Köpek Otur/Kalk',
    ['no_dog'] = "Köpeğin Yok",
    ['dog_dead'] = 'Köpeğin Öldü',
    ['search_drugs'] = 'Uyuşturucu Arat',
    ['no_drugs'] = 'Uyuşturucu Bulunamadı', 
    ['drugs_found'] = 'Uyuşturucu veya Başka Bişey Bulundu',
    ['dog_too_far'] = 'Köpek Senden Çok Uzakta',
    ['attack_closest'] = 'Yakındakine Saldır'
}