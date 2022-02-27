Config = {}

Config.RestrictedChannels = 10 -- channels that are encrypted (EMS, Fire and police can be included there) if we give eg 10, channels from 1 - 10 will be encrypted
Config.enableCmd = false --  /radio command should be active or not (if not you have to carry the item "radio") true / false

Config.messages = {

  ['not_on_radio'] = 'Şu anda herhangi bir telsiz kanalında yoksunuz',
  ['on_radio'] = 'Mevcut telsiz kanalınız: <b>',
  ['joined_to_radio'] = 'Telsiz kanalına katıldın: <b>',
  ['restricted_channel_error'] = 'Şifreli kanallara katılamazsınız!',
  ['you_on_radio'] = 'Zaten telsizdesiniz: <b>',
  ['you_leave'] = 'Telsizden ayrıldın: <b>'

}
