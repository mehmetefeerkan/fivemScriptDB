----------------------
-- Author : Deediezi
-- Version 3.0
--//EDITED BY ceranim0x#4783
-- Contributors : No contributors at the moment.
--
-- Github link : https://github.com/Deediezi/FiveM_LockSystem
-- You can contribute to the project. All the information is on Github.

--  Vehicle object manager - Client side

function newVehicle()
    local self = {}

    self.id = nil
    self.plate = nil
    self.lockStatus = nil

    rTable = {}

    rTable.__construct = function(id, plate, lockStatus)
        if(id and type(id) == "number")then
            self.id = id
        end
        if(plate and type(plate) == "string")then
            self.plate = plate
        end
        if(lockStatus and type(lockStatus) == "number")then
            self.lockStatus = lockStatus
        end
    end

    -- Methods

    rTable.update = function(id, lockStatus)
        self.id = id
        self.lockStatus = lockStatus
    end

    -- 0, 1 = unlocked
    -- 2 = locked
    -- 4 = locked and player can't get out
    rTable.lock = function()
        lockStatus = self.lockStatus
        if(lockStatus <= 2)then
            self.lockStatus = 4
            SetVehicleDoorsLocked(self.id, self.lockStatus)
            SetVehicleDoorsLockedForAllPlayers(self.id, 1)
            TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Araç Kilitlendi' } )
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "lock", 4.0)
        elseif(lockStatus > 2)then
            self.lockStatus = 1
            SetVehicleDoorsLocked(self.id, self.lockStatus)
            SetVehicleDoorsLockedForAllPlayers(self.id, false)
            TriggerEvent('mythic_notify:client:SendAlert', { type = 'success', text = 'Araç Açıldı' } )
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, "unlock", 1.0)
        end
    end

    -- Setters

    rTable.setId = function(id)
        if(type(id) == "number" and id >= 0)then
            self.id = id
        end
    end

    rTable.setPlate = function(plate)
        if(type(plate) == "string")then
            self.plate = plate
        end
    end

    rTable.setLockStatus = function(lockStatus)
        if(type(lockStatus) == "number" and lockStatus >= 0)then
            self.lockStatus = lockStatus
            SetVehicleDoorsLocked(self.id, lockStatus)
        end
    end

    -- Getters

    rTable.getId = function()
        return self.id
    end

    rTable.getPlate = function()
        return self.plate
    end

    rTable.getLockStatus = function()
        return self.lockStatus
    end

    return rTable
end
