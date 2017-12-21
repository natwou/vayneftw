if myHero.charName ~= "Vayne" then return end

local ver = "0.1"
function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        DownloadFileAsync("https://raw.githubusercontent.com/natwou/vayneftw/master/vayneftw.lua", SCRIPT_PATH .. "vayneftw.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
    else
        PrintChat(string.format("<font color='#b756c5'>VayneFTW </font>").."updated ! Version: "..ver)
    end
end
GetWebResultAsync("https://raw.githubusercontent.com/natwou/vayneftw/master/vayneftw.version", AutoUpdate)

require "OpenPredict"

local lastq = 0
local lastw = 0
local laste = 0
local lastr = 0
local lastaa = 0
local aawind = 0
local aaanim = 0
local lastmove = 0
local lastkillsteal = 0
local aarange = myHero.range + myHero.boundingRadius
local Q = { range = 300, delay = 0 }
local E = { range = 710, push = 470, delay = 0.25 }

menu = MenuConfig("GSO", "VayneFTW version 0.1")
        menu:Key("reset", "Reset Menu Settings", string.byte("T"))
        menu:SubMenu("combo", "Combo")
                menu.combo:Key("ckey", "Combo Key", 32)
                menu.combo:Boolean("ewin", "Higher Value = faster kite",60,-15,100,10)
                menu.combo:Boolean("useQ", "Use Tumble", true)
                menu.combo:Boolean("useE", "Use Condemn",true)
                menu.combo:Boolean("useR", "Use Ultimate",true)
		menu:Submenu("Draw", "Draw")
				menu.draw:Boolean("DE", "Draw E range", true)


OnProcessSpellAttack(function(unit, aa)
        if unit.isMe then
                lastaa = GetTickCount()
                aawind = ( aa.windUpTime * 1000 ) - menu.combo.ewin:Value()
                aaanim = ( aa.animationTime * 1000 ) - 125
        end
end)


OnTick(function(myHero)

        
        if menu.reset:Value() then
                menu.combo.ewin:Value(50)
                menu.combo.useQ:Value(true)
                menu.combo.useE:Value(true)
                menu.combo.useR:Value(true)
        end
        
        if menu.combo.ckey:Value() then
        
                BlockF7OrbWalk(true)
                
                local checkT = GetTickCount()
                local canMove = checkT > lastaa + aawind and checkT > lastmove + 125
                local canAttack = checkT > lastaa + aaanim
                
                local t = Vayne_GetTarget(aarange, true)
                
                if canMove then
                        lastmove = GetTickCount()
                        MoveToXYZ(GetMousePos())
                end
                
        
                
        else
        
                BlockF7OrbWalk(false)
                
        end

        
end)
