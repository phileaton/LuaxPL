-- xPL library, copyright 2011, Thijs Schreijer
--
-- In the template below remove '[[' for any method you need to override


-- set the proper classname here, this should match the filename without the '.lua' extension
local classname = "new_device_template"




require ("xpl")
assert(not xpl.classes.[classname], "There is already a class defined as 'xpl.classes." .. classname .. "'.")

local xpldevice = xpl.classes.xpldevice:subclass({

    --[[---------------------------------------------------------------------------------------
    -- Initializes the xpldevice.
    -- Will be called upon instantiation of an object.
    initialize = function(self)
        -- call ancestor
        self.super.initialize(self)

        -- add your stuff here
        self.address = xpl.createaddress("tieske", "luadev", "RANDOM")


    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Starts the xpldevice.
    -- The listener will automatically call this method just before starting the network activity.
    start = function(self)
        -- call ancestor
        self.super.start(self)

        -- add your stuff here

    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Stops the xpldevice.
    stop = function(self)

        -- add your stuff here


        -- call ancestor
        self.super.stop(self)
    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Handles incoming events.
    eventhandler = function(self, sender, event, ...)

        -- call ancestor will handle basic start/stop and receive new message events
        -- ancestor has subscribed to copas and xpl.listener events
        self.super.eventhandler(self, sender, event, ...)

        -- add your stuff here

    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Handler for incoming messages.
    -- It will handle only the heartbeat messages (echos) to verify the devices own connection.
    -- @param msg the xplmessage object that has to be handled
    -- @return the message received or <code>nil</code> if it was fully handled
    handlemessage = function(self, msg)

        -- add your stuff here, for the raw unhandled message, still has echos, hbeat,
        -- non-filtered stuff etc.


        -- call ancestor, will handle heartbeat, filtermatching, clearing echos
        msg = self.super.handlemessage(self, msg)

        if msg then

           -- add your stuff here, message is yet unhandled, but passed the filter

        end

        return msg
    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Heartbeat message creator.
    -- Will be called to create the heartbeat message to be send. Override this function
    -- to modify the hbeat content.
    -- @param exit if true then an exit hbeat message, for example 'hbeat.end' needs to be created.
    -- @return xplmessage object with the heartbeat message to be sent.
    createhbeatmsg = function(self, exit)

        -- call ancestor
        local msg = self.super.createhbeatmsg(self, exit)


        -- add your stuff here


        return msg
    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Handler called whenever the device status changes. Override this method
    -- to implement code upon status changes.
    -- @param newstatus the new status of the device
    -- @param oldstatus the previous status
    statuschanged = function(self, newstatus, oldstatus)
        -- call ancestor
        local msg = self.super.statuschanged(self, newstatus, oldstatus)


        -- add your stuff here


    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Gets a table with the device settings to persist. Override this function to add
    -- additional settings.
    -- @return table with settings
    getsettings = function(self)
        -- get ancestor settings table
        local s = self.super.getsettings()

        -- add your own settings to the table here

        return s
    end, --]]

    --[[---------------------------------------------------------------------------------------
    -- Sets the provided settings in the device. Override this method to add additional settings
    -- @param s table with settings as generated by <code>getsettings()</code>.
    -- @return <code>true</code> if the settings provided require a restart of the device (when
    -- the instance name changed for example). Make sure to call <code>restart()</code> in that case.
    -- Do not restart from here, because it would disable future inheritance of this class and
    -- it would be inconsistent with the other classes
    -- @usage if mydev:setsettings(mysettings) then mydev:restart() end
    setsettings = function(self, s)
        local r     -- requires restart?
        -- go let ancestor restore its settings first
        r = self.super.setsettings(s)


        -- add your own settings restoring here
        -- do not forget to set 'r' to 'true' if a restart is required!


        -- return the requirement to restart the device
        return r
    end, --]]

})      -- subclass



-- store the class for future use, instantiation and subclassing
xpl.classes.[classname] = xpldevice      -- store the class
return xpldevice                         -- return the class (not an instance)

