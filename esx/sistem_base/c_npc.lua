ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    -- List of pickup hashes (https://pastebin.com/8EuSv2r1)
 RemoveAllPickupsOfType(0x6E4E65C2)
 RemoveAllPickupsOfType(0x741C684A)
 RemoveAllPickupsOfType(0x68605A36)
 RemoveAllPickupsOfType(0x6C5B941A)
 RemoveAllPickupsOfType(0xD3A39366)
 RemoveAllPickupsOfType(0x550447A9)
 RemoveAllPickupsOfType(0xF99E15D0)
 RemoveAllPickupsOfType(0xA421A532)
 RemoveAllPickupsOfType(0xF33C83B0)
 RemoveAllPickupsOfType(0xDF711959)
 RemoveAllPickupsOfType(0xB2B5325E)
 RemoveAllPickupsOfType(0x85CAA9B1)
 RemoveAllPickupsOfType(0xB2930A14)
 RemoveAllPickupsOfType(0xFE2A352C)
 RemoveAllPickupsOfType(0x693583AD)
 RemoveAllPickupsOfType(0x1D9588D3)
 RemoveAllPickupsOfType(0x3A4C2AD2)
 RemoveAllPickupsOfType(0x4BFB42D1)
 RemoveAllPickupsOfType(0x4D36C349)
 RemoveAllPickupsOfType(0x2F36B434)
 RemoveAllPickupsOfType(0x8F707C18)
 RemoveAllPickupsOfType(0xA9355DCD)
 RemoveAllPickupsOfType(0x96B412A3)
 RemoveAllPickupsOfType(0x9299C95B)
 RemoveAllPickupsOfType(0x5E0683A1)
 RemoveAllPickupsOfType(0x2DD30479)
 RemoveAllPickupsOfType(0x1CD604C7)
 RemoveAllPickupsOfType(0x7C119D58)
 RemoveAllPickupsOfType(0xF9AFB48F)
 RemoveAllPickupsOfType(0x8967B4F3)
 RemoveAllPickupsOfType(0x3B662889)
 RemoveAllPickupsOfType(0x2E764125)
 RemoveAllPickupsOfType(0xFE18F3AF)
 RemoveAllPickupsOfType(0xFD16169E)
 RemoveAllPickupsOfType(0xCB13D282)
 RemoveAllPickupsOfType(0xC69DE3FF)
 RemoveAllPickupsOfType(0x278D8734)
 RemoveAllPickupsOfType(0x5EA16D74)
 RemoveAllPickupsOfType(0x295691A9)
 RemoveAllPickupsOfType(0x81EE601E)
 RemoveAllPickupsOfType(0x88EAACA7)
 RemoveAllPickupsOfType(0x872DC888)
 RemoveAllPickupsOfType(0x094AA1CF)
 RemoveAllPickupsOfType(0x2C014CA6)
 RemoveAllPickupsOfType(0xE33D8630)
 RemoveAllPickupsOfType(0x80AB931C)
 RemoveAllPickupsOfType(0x6E717A95)
 RemoveAllPickupsOfType(0x4B5259BE)
 RemoveAllPickupsOfType(0xCE6FDD6B)
 RemoveAllPickupsOfType(0x5DE0AD3E)
 RemoveAllPickupsOfType(0x1E9A99F8)
 RemoveAllPickupsOfType(0x20893292)
 RemoveAllPickupsOfType(0x14568F28)
 RemoveAllPickupsOfType(0x711D02A4)
 RemoveAllPickupsOfType(0xDE78F17E)
 RemoveAllPickupsOfType(0xD0AACEF7)
 RemoveAllPickupsOfType(0xCC8B3905)
 RemoveAllPickupsOfType(0xA54AE7B7)
 RemoveAllPickupsOfType(0xA717F898)
 RemoveAllPickupsOfType(0x84D676D4)
 RemoveAllPickupsOfType(0x65A7D8E9)
 RemoveAllPickupsOfType(0x2C804FE3)
 RemoveAllPickupsOfType(0x098D79EF)
 RemoveAllPickupsOfType(0x4316CC09)
 RemoveAllPickupsOfType(0xB86AEE5B)
 RemoveAllPickupsOfType(0xCC7CCD1B)
 RemoveAllPickupsOfType(0x2E071B5A)
 RemoveAllPickupsOfType(0xA5B8CAA9)
 RemoveAllPickupsOfType(0x65948212)
 RemoveAllPickupsOfType(0xE7CF07CC)
 RemoveAllPickupsOfType(0x1CD2CF66)
 RemoveAllPickupsOfType(0x6773257D)
 RemoveAllPickupsOfType(0x20796A82)
 RemoveAllPickupsOfType(0x116FC4E6)
 RemoveAllPickupsOfType(0xE4BD2FC6)
 RemoveAllPickupsOfType(0xDE58E0B3)
 RemoveAllPickupsOfType(0x77F3F2DD)
 RemoveAllPickupsOfType(0xC02CF125)
 RemoveAllPickupsOfType(0x881AB0A8)
 RemoveAllPickupsOfType(0x84837FD7)
 RemoveAllPickupsOfType(0xF25A01B9)
 RemoveAllPickupsOfType(0x815D66E8)
 RemoveAllPickupsOfType(0xFA51ABF5)
 RemoveAllPickupsOfType(0xC5B72713)
 RemoveAllPickupsOfType(0x5307A4EC)
 RemoveAllPickupsOfType(0x9CF13918)
 RemoveAllPickupsOfType(0x0968339D)
 RemoveAllPickupsOfType(0xBFEE6C3B)
 RemoveAllPickupsOfType(0xEBF89D5F)
 RemoveAllPickupsOfType(0x22B15640)
 RemoveAllPickupsOfType(0x763F7121)
 RemoveAllPickupsOfType(0xF92F486C)
 RemoveAllPickupsOfType(0x602941D0)
 RemoveAllPickupsOfType(0x31EA45C9)
 RemoveAllPickupsOfType(0xBED46EC5)
 RemoveAllPickupsOfType(0x079284A9)
 RemoveAllPickupsOfType(0xE175C698)
 RemoveAllPickupsOfType(0x624F7213)
 RemoveAllPickupsOfType(0xC01EB678)
 RemoveAllPickupsOfType(0x5C517D97)
 RemoveAllPickupsOfType(0xBD4DE242)
 RemoveAllPickupsOfType(0xE013E01C)
 RemoveAllPickupsOfType(0x789576E2)
 RemoveAllPickupsOfType(0xFD9CAEDE)
 RemoveAllPickupsOfType(0x8ADDEC75)
  end
end)