/*
Прогрузка Utime
*/
module( "Utime", package.seeall )

--Now convars!
local ply = {}

local utime_enable = CreateClientConVar( "utime_enable", "0.0", false, false )
local utime_outsidecolor_r = CreateClientConVar( "utime_outsidecolor_r", "256.0", true, false )
local utime_outsidecolor_g = CreateClientConVar( "utime_outsidecolor_g", "256.0", true, false )
local utime_outsidecolor_b = CreateClientConVar( "utime_outsidecolor_b", "256.0", true, false )
local utime_outsidetext_r = CreateClientConVar( "utime_outsidetext_r", "0.0", true, false )
local utime_outsidetext_g = CreateClientConVar( "utime_outsidetext_g", "0.0", true, false )
local utime_outsidetext_b = CreateClientConVar( "utime_outsidetext_b", "0.0", true, false )
local utime_insidecolor_r = CreateClientConVar( "utime_insidecolor_r", "256.0", true, false )
local utime_insidecolor_g = CreateClientConVar( "utime_insidecolor_g", "256.0", true, false )
local utime_insidecolor_b = CreateClientConVar( "utime_insidecolor_b", "256.0", true, false )
local utime_insidetext_r = CreateClientConVar( "utime_insidetext_r", "0", true, false )
local utime_insidetext_g = CreateClientConVar( "utime_insidetext_g", "0", true, false )
local utime_insidetext_b = CreateClientConVar( "utime_insidetext_b", "0", true, false )

local utime_pos_x = CreateClientConVar( "utime_pos_x", "0.0", true, false )
local utime_pos_y = CreateClientConVar( "utime_pos_y", "0.0", true, false )

local PANEL = {}
PANEL.Small = 40
PANEL.TargetSize = PANEL.Small
PANEL.Large = 100
PANEL.Wide = 160

hook.Add( "InitPostEntity", "UtimeInitialize", initialize )

function think()
	if not LocalPlayer():IsValid() or gpanel == nil then return end

	if not utime_enable:GetBool() or not IsValid( LocalPlayer() ) or
			(IsValid( LocalPlayer():GetActiveWeapon() ) and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_camera") then
		gpanel:SetVisible( false )
	else
		gpanel:SetVisible( true )
	end

	--gpanel:SetPos( ScrW() - gpanel:GetWide() - 20, 20 )
	gpanel:SetPos( (ScrW() - gpanel:GetWide()) * utime_pos_x:GetFloat() / 100, (ScrH() - gpanel.Large) * utime_pos_y:GetFloat() / 100 )

	local textColor = Color( utime_outsidetext_r:GetInt(), utime_outsidetext_g:GetInt(), utime_outsidetext_b:GetInt(), 255 )
	gpanel.lblTotalTime:SetTextColor( textColor )
	gpanel.lblSessionTime:SetTextColor( textColor )
	gpanel.total:SetTextColor( textColor )
	gpanel.session:SetTextColor( textColor )

	local insideTextColor = Color( utime_insidetext_r:GetInt(), utime_insidetext_g:GetInt(), utime_insidetext_b:GetInt(), 255 )
	gpanel.playerInfo.lblTotalTime:SetTextColor( insideTextColor )
	gpanel.playerInfo.lblSessionTime:SetTextColor( insideTextColor )
	gpanel.playerInfo.lblNick:SetTextColor( insideTextColor )
	gpanel.playerInfo.total:SetTextColor( insideTextColor )
	gpanel.playerInfo.session:SetTextColor( insideTextColor )
	gpanel.playerInfo.nick:SetTextColor( insideTextColor )
end
timer.Create( "UTimeThink", 0.6, 0, think )

local texGradient = surface.GetTextureID( "gui/gradient" )

/*
Прогрузка Material's
*/

local icon_health = Material("materials/cloudrp/heart.png", "smooth")
local icon_armor  = Material("materials/cloudrp/c_shield.png", "smooth")
local icon_hunger = Material("materials/cloudrp/c_burger.png", "smooth")
local material_licence = Material("materials/cloudrp/c_gun.png", "smooth")

function drawShadowText(text, font, x, y, color, x_a, y_a, color_shadow)
    color_shadow = color_shadow or Color(0, 0, 0)
    draw.SimpleText(text, font, x + 1, y + 1, color_shadow, x_a, y_a)
    local w,h = draw.SimpleText(text, font, x, y, color, x_a, y_a)
    return w,h
end

local blur = Material("pp/blurscreen")
function framework(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

surface.CreateFont("FlameHUD.Logo", {
    size = ScreenScale(30),
    weight = 350 ,
    antialias = true,
    extended = true,
    font = "Roboto"
})

surface.CreateFont("travka.hud", {
    font = "Roboto",
    size = ScreenScale(24),
    weight = 1000,
    extended = true
})

surface.CreateFont("travka.prop", {
    font = "Roboto",
    size = 12,
    weight = 1000,
    extended = true
})

surface.CreateFont("travka.cmenu", {
    font = "Roboto",
    size = 20,
    weight = 1000,
    extended = true
})

surface.CreateFont("travka.btn", {
    font = "Roboto",
    size = 20,
    weight = 1000,
    extended = true
})

surface.CreateFont('PlayerInfo', {
    font = 'Tahoma',
    size = 24,
    weight = 700,
    antialias = true
})

surface.CreateFont('PlayerInfosm', {
    font = 'Tahoma',
    size = 15,
    weight = 700,
    antialias = true
})

surface.CreateFont("travka.small", {
    font = "Roboto",
    size = ScreenScale(14),
    weight = 1000,
    extended = true
})

surface.CreateFont("FlameHUD.Logo2", {
    size = ScreenScale(15),
    weight = 350 ,
    antialias = true,
    extended = true,
    font = "Roboto"
})

surface.CreateFont("FlameHUD.DefText", {
    font = "Roboto",
    size = ScreenScale(8),
    weight = 600,
    antialias = true,
    extended = true,
})

surface.CreateFont("FlameHUD.CircleText", {
    font = "Roboto",
    size = ScreenScale(24),
    weight = 10,
    antialias = true,
    extended = true,
})

surface.CreateFont("FlameHUD.StatusText", {
    font = "Roboto",
    size = ScreenScale(7),
    weight = 600,
    antialias = true,
    extended = true,
})

surface.CreateFont("FlameHUD.StatusText2", {
    font = "Roboto",
    size = ScreenScale(12),
    weight = 600,
    antialias = true,
    extended = true,
})

surface.CreateFont("FlameHUD.StatusText3", {
    font = "Roboto",
    size = ScreenScale(8),
    weight = 1000,
    antialias = true,
    extended = true,
})

surface.CreateFont("FlameHUD.StatusText4", {
    font = "Roboto",
    size = ScreenScale(12),
    weight = 1000,
    antialias = true,
    extended = true,
})

local function DrawCenteredText(text, font, x, y, colour, xalign)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    x = x - w * 0.5
    y = y + (h * (xalign - 1))
    surface.SetTextPos(x, y)
    surface.SetTextColor(colour)
    surface.DrawText(text)

    return w, h
end -- rodo

local font_cache = {}

local function DrawBoxA(x, y, w, h , var, maxa, col, text)
    surface.SetDrawColor(0,0,0,150)
    surface.DrawRect(x + (h - 2) + 5,y,w - (h - 2) - 5,h)
    --
    surface.SetDrawColor(col.r,col.g,col.b,col.a or 255)
    surface.DrawRect(x + (h - 2) + 5,y + 1, (w - h - 4) * var / maxa,h - 2)
    --
    drawShadowText(text, 'travka.btn',x + w * .5 + h * .5 ,y + h * .5,Color(255,255,255),1,1)
end

local function DrawCenteredTextOutlined(text, font, x, y, colour, xalign, outlinewidth, outlinecolour)
    if text == nil then return end
    local steps = (outlinewidth * .75)

    if (steps < 1) then
        steps = 1
    end

    for _x = -outlinewidth, outlinewidth, steps do
        for _y = -outlinewidth, outlinewidth, steps do
            DrawCenteredText(text, font, x + (_x), y + (_y), outlinecolour, xalign)
        end
    end

    return DrawCenteredText(text, font, x, y, colour, xalign)
end

local date = os.date("%d/%m/%Y - %H:%M",os.time())
local parsed_text = {}
local font_size = {}
local height = 26
local left_x = 3
local right_x = ScrW() - 3

local function drawrightext(text, color)
    local w = surface.GetTextSize(text)
    right_x = right_x - (w + 4)
    surface.SetTextPos(right_x, 2)
    surface.SetTextColor(color.r, color.g, color.b, color.a)
    surface.DrawText(text)
    right_x = right_x - 5
    surface.SetDrawColor(Color(255,155,55))
    surface.DrawLine(right_x, 0, right_x, height - 1)
end

local ColValues = {}
local function varcol(name, val)
    if ColValues[name] == nil then
        ColValues[name] = {}
        ColValues[name].Old = val
        ColValues[name].Flash = SysTime()

        return Color(255,255,255,255)
    end

    if ColValues[name].Old ~= val then
        ColValues[name].Flash = SysTime() + 0.2
        ColValues[name].Old = val

        return Color(0,255,128)
    end

    if ColValues[name].Flash > SysTime() then return Color(0,255,128) end

    return Color(255,255,255,255)
end

surface.SetFont("FlameHUD.Logo")
font_size["FlameHUD.Logo"] = {}
font_size["FlameHUD.Logo"].w,font_size["FlameHUD.Logo"].h = surface.GetTextSize(date)
surface.SetFont("FlameHUD.Logo2")
font_size["FlameHUD.Logo2"] = {}
font_size["FlameHUD.Logo2"].w,font_size["FlameHUD.Logo2"].h = surface.GetTextSize(date)
surface.SetFont("FlameHUD.StatusText")
font_size["FlameHUD.StatusText"] = {}
font_size["FlameHUD.StatusText"].w,font_size["FlameHUD.StatusText"].h = surface.GetTextSize("Общее время")
surface.SetFont("FlameHUD.StatusText2")
font_size["FlameHUD.StatusText2"] = {}
font_size["FlameHUD.StatusText2"].w,font_size["FlameHUD.StatusText2"].h = surface.GetTextSize("Общее время")
surface.SetFont("FlameHUD.StatusText3")
font_size["FlameHUD.StatusText3"] = {}
font_size["FlameHUD.StatusText3"].w,font_size["FlameHUD.StatusText3"].h = surface.GetTextSize("Общее время")
surface.SetFont("FlameHUD.StatusText4")
font_size["FlameHUD.StatusText4"] = {}
font_size["FlameHUD.StatusText4"].w,font_size["FlameHUD.StatusText4"].h = surface.GetTextSize("Общее время")
surface.SetFont("FlameHUD.DefText")
font_size["FlameHUD.DefText"] = {}
font_size["FlameHUD.DefText"].w,font_size["FlameHUD.DefText"].h = surface.GetTextSize("TESTTEST")

local player_GetAll = player.GetAll
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local draw_RoundedBox = draw.RoundedBox
local CurTime = CurTime
local math_sin = math.sin
local pairs = pairs
local ipairs = ipairs
local IsValid = IsValid
local draw_Box = draw.Box
local ScrW = ScrW
local ScrH = ScrH
local string_Wrap = string.Wrap
local draw_SimpleText = draw.SimpleText
local math_Clamp = math.Clamp
local color_red = Color(245,0,0)
local Lerp = Lerp
local math_Round = math.Round
local math_floor = math.floor
local math_ceil = math.ceil
local tonumber = tonumber
local math_max = math.max
local math_min = math.min
local math_abs = math.abs
local string_format = string.format
local LocalPlayer = LocalPlayer
local HSVToColor = HSVToColor
local surface_SetDrawColor = surface.SetDrawColor
local surface_DrawRect = surface.DrawRect
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRect = surface.DrawTexturedRect
local cam_IgnoreZ = cam.IgnoreZ
local render_ClearStencil = render.ClearStencil
local render_SetStencilEnable = render.SetStencilEnable
local render_SetStencilWriteMask = render.SetStencilWriteMask
local render_SetStencilTestMask = render.SetStencilTestMask
local render_SetStencilReferenceValue = render.SetStencilReferenceValue
local render_SetStencilFailOperation = render.SetStencilFailOperation
local render_SetStencilZFailOperation = render.SetStencilZFailOperation
local render_SetStencilPassOperation = render.SetStencilPassOperation
local render_SetStencilCompareFunction = render.SetStencilCompareFunction
local render_SetBlend = render.SetBlend
local cam_Start3D2D = cam.Start3D2D
local cam_End3D2D = cam.End3D2D

local shadow_x = 1 -- I left 1 to make it noticeble
local shadow_y = 1
local col_face = Color(255, 255, 255, 255)
local col_shadow = Color(0, 0, 0, 255)
local col_half_shadow = Color(0, 0, 0, 200)
local col_money = Color(64, 192, 32)

local color_orange = Color(255,155,55)
local color_blue = Color(66,149,244)
local color_green = Color(66,244,143)
local color_purple = Color(232,66,244)
local color_outline = Color(255,255,255)

surface.CreateFont("TargetID", {
    size = 25,
    weight = 1000,
    antialias = true,
    shadow = false,
    font = "Tahoma"
})

surface.CreateFont("HudFont", {
    size = 22,
    weight = 350,
    antialias = true,
    extended = true,
    font = "Roboto"
})


local function mat(texture)
    return Material(texture)
end

local color_cache = Color(0, 0, 0, 255)
local function perccol(num)
    num = math_Clamp(num / 100, 0, 1)
    color_cache.r = 255 - (num * 200)
    color_cache.g = (num * 200)
    color_cache.b = 50

    return color_cache
end

local HE = {}
HE["CHudHealth"] = true
HE["CHudBattery"] = true
HE["CHudSuitPower"] = true
HE["CHudAmmo"] = true
HE["CHudSecondaryAmmo"] = true
HE["CHudCrosshair"] = true
HE["CHudWeaponSelection"] = false
HE["CHudDamageIndicator"] = true
HE["DarkRP_HUD"] = true
HE["DarkRP_EntityDisplay"] = false

local hidden = { "DarkRP_Agenda","DarkRP_LockdownHUD", "DarkRP_ArrestedHUD","DarkRP_Hungermod" }
function hidehud(name)
    for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"})do
        if name == v then return false end
    end
end
hook.Add("HUDShouldDraw", "HideOurHud", hidehud)

local function HideDarkRPHUD(name)
    if HE[name] then
        return false
    else 
        return true
    end
end


local function fl_FormatTime(time)
    local tmp = time
    local s = tmp % 60
    tmp = math_floor( tmp / 60 )
    local m = tmp % 60
    tmp = math_floor( tmp / 60 )
    local h = tmp % 24
    tmp = math_floor( tmp / 24 )
    local d = tmp % 7
    local w = math_floor( tmp / 7 )

    local toret = ""
    if w ~= 0 then
        toret = toret .. math_Round(w) .."н "
    end

    if d ~= 0 and d < 7 then
        toret = toret .. math_Round(d) .."д "
    end

    if h ~= 0 and h < 24 then
        toret = toret .. math_Round(h) .."ч "
    end

    if m ~= 0 and m < 60 then
        toret = toret .. math_Round(m) .."мин "
    end

    if s ~= 0 and s < 60 then
        toret = toret .. math_Round(s) .."сек "
    end


    return toret
end

hook.Add("HUDShouldDraw", "hideDarkRPHUD", HideDarkRPHUD)

local modify = {
    ['$pp_colour_addr'] = 0,
    ['$pp_colour_addg'] = 0,
    ['$pp_colour_addb'] = 0,
    ['$pp_colour_brightness'] = 0,
    ['$pp_colour_contrast'] = 1,
    ['$pp_colour_colour'] = 0,
    ['$pp_colour_mulr'] = 0.05,
    ['$pp_colour_mulg'] = 0.05,
    ['$pp_colour_mulb'] = 0.05
}
local def = {
    ['$pp_colour_addr'] = 0,
    ['$pp_colour_addg'] = 0,
    ['$pp_colour_addb'] = 0.04,
    ['$pp_colour_brightness'] = -0.08,
    ['$pp_colour_contrast'] = 1,
    ['$pp_colour_colour'] = 0.7,
    ['$pp_colour_mulr'] = 0,
    ['$pp_colour_mulg'] = 0,
    ['$pp_colour_mulb'] = 0,
}

local emitter = ParticleEmitter(EyePos())
local function ColorModify()
    if (LocalPlayer():Health() <= 15) then
        DrawColorModify(modify)
    else
        DrawColorModify(def)
    end
end

local blur = Material("pp/blurscreen")

local function DrawBlurBar(x, y, w, h, var, col, text)
    local X, Y = 0, 0
    local piz

    if var > 100 then
        piz = 100
    else
        piz = var
    end

    surface_SetDrawColor(255, 255, 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (3))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        render.SetScissorRect(x, y, x + w, y + h, true)
        surface_DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
        render.SetScissorRect(0, 0, 0, 0, false)
    end
           
    surface_SetDrawColor(0,0,0,100)
    surface_DrawRect(x,y,w,h)

    surface_SetDrawColor(col.r,col.g,col.b,col.a or 255)
    surface_DrawRect(x + 1,y + 1, piz / 100 * w - 2,h - 2)
    surface.SetFont("FlameHUD.StatusText")
    local a_s = surface.GetTextSize(math_Round(var))

    draw_SimpleTextOutlined(math_Round(var),"FlameHUD.StatusText",math.Clamp( x + piz / 100 * w - 5, x + a_s + 2, x + w ),y,Color(255,255,255),2,0,1,Color(0,0,0))
end

local function DrawBlurBarA(x, y, w, h , var, maxa, col, text)
    --if cvar.GetValue('enable_blur') then
        local X, Y = 0,0
        surface_SetDrawColor(255,255,255)
        surface_SetMaterial(blur)

        for i = 1, 3 do
            blur:SetFloat("$blur", (i / 3) * (2))
            blur:Recompute()

            render.UpdateScreenEffectTexture()

            render.SetScissorRect(x + (h - 2) + 5, y, x+w, y+h, true)
            surface_DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
            render.SetScissorRect(0, 0, 0, 0, false)
        end
    --end
    
    surface_SetDrawColor(0,0,0,100)
    surface_DrawRect(x + (h - 2) + 5,y,w - (h - 2) - 5,h)
    --
    surface_SetDrawColor(col.r,col.g,col.b,col.a or 255)
    surface_DrawRect(x + (h - 2) + 5,y +1, (w - h - 4) * var / maxa,h - 2)
    --
    drawShadowText(text,"FlameHUD.StatusText",x + w*.5 + h*.5 ,y + h*.5,Color(255,255,255),1,1)
end

local hp_pLerp = 0
local armor_pLerp = 0
local hunger_pLerp = 0
local karma_pLerp = 0
local ammo_pLerp = 0

local ammod = "Пусто"
local ammo1 = 0
local maxammo1 = 100
local ammototal = 100

local curtime = 0
local nextspawn = 0
net.Receive("FlameHUD.DeathTimer",function()
    nextspawn = net.ReadDouble()
    curtime = CurTime()
end)

local function DrawDot(x,y,w,h)
    surface_SetDrawColor(0,0,0,255)
    surface_DrawRect(x,y,w,h)

    surface_SetDrawColor(255, 255, 255, 255)
    surface_DrawRect(x + 1,y + 1,w - 2,h - 2)
end

local BubbleMaterial = Material("particle/warp1_warp", "alphatest")
local CircleBars = {}
local Bubbles = {}
local cir = {}

local cir2 = setmetatable({}, {
    __index = function(self, key)
        local t = {}
        self[key] = t

        return t
    end
})

local function drawCircle(x, y, radius, seg, angle, offset)
    for i = 1, seg + 1 do
        cir[i] = cir2[i]
    end

    for i = #cir, seg + 2, -1 do
        cir[i] = nil
    end

    for i = 0, seg do
        local a = math.rad((i / seg) * angle + offset)
        local sa = math_sin(a)
        local ca = math.cos(a)
        local t = cir[i + 1]
        t.x = x + sa * radius
        t.y = y + ca * radius
        t.u = sa * 0.5 + 0.5
        t.v = ca * 0.5 + 0.5
    end

    surface.DrawPoly(cir)
end

local function drawCirclex(x, y, radius, seg, angle, offset)
    for i = 1, seg + 1 do
        cir[i] = cir2[i]
    end

    for i = #cir, seg + 2, -1 do
        cir[i] = nil
    end

    local px, py
    local fx, fy

    for i = 0, seg do
        local a = math.rad((i / seg) * angle + offset)
        local sa = math_sin(a)
        local ca = math.cos(a)
        local x = x + sa * radius
        local y = y + ca * radius

        if fx == nil then
            px, py, fx, fy = x, y, x, y
            continue
        end

        surface.DrawLine(px, py, x, y)
        px, py = x, y
    end

    surface.DrawLine(px, py, fx, fy)
end

local function addBubble()
    for k,v in pairs(CircleBars) do
        if v.last_val <= 0 then continue end
        if v.bubbles > 20 then continue end

        v.bubbles = v.bubbles + 1
        table.insert(Bubbles, {
            x = math.random(v.x - v.r*.5, v.x + v.r*.5),
            y = v.y + v.r*.5,
            size = math.random(4, 12),
            speed = math.random(20, 40),
            alpha = 0,
            timer = 0,
            bar = k
        })
    end
end

local next_bubble = 0
local function HudThink()
    if CurTime() > next_bubble then
        addBubble()
        next_bubble = CurTime() + 0.25
    end

    for i, v in pairs(Bubbles) do
        local y = v.y

        if y < CircleBars[v.bar].y - CircleBars[v.bar].r*.5 - 15 then
            table.remove(Bubbles, i)
            CircleBars[v.bar].bubbles = CircleBars[v.bar].bubbles - 1
            continue
        else
            v.y = v.y - FrameTime() * v.speed
            v.timer = v.timer + FrameTime() * v.speed / 30

            if v.alpha < 60 then
                v.alpha = v.alpha + FrameTime() * 70
            end
        end
    end
end
hook.Add("Think", "FlameHUD.Think", HudThink)

local Poly = 60
local function DrawCircleBar(name, x, y, size, var, col, col_2, outline, icon)
    if not CircleBars[name] then CircleBars[name] = {x = x, y = y, r = size, last_val = 0, bubbles = 0} end

    icon = icon or icon_health

    local Delay = var > 100 and 100 or var < 0 and 0 or var
    local amount = -180 + 180 * math.cos(Delay * 2 / 100) - 50
    local amount_rotfix = -amount * 0.5 - 90

    col = col or Color(255,155,55)
    col_2 = col_2 or Color(230,130,30)
    outline = outline or Color(20, 20, 20, 200)

    size = size or 50
    var = math_Round(var)

    if CircleBars[name].x ~= x then
        CircleBars[name].x = x
    end

    if CircleBars[name].y ~= y then
        CircleBars[name].y = y
    end

    if CircleBars[name].last_val ~= var then
        CircleBars[name].last_val = var
    end

    draw.NoTexture()
    surface.SetDrawColor(outline)
    drawCircle(x, y, size + 2, Poly, -360, 0)
    surface.SetDrawColor(Color(255, 255, 255, 6))
    drawCircle(x, y, size, Poly, -360, 0)
    -- HP Back
    surface.SetDrawColor(col_2)
    drawCircle(x, y, size, Poly, amount, amount_rotfix + 90 + math.cos(RealTime() * 4) * 10)
    surface.SetDrawColor(col_2)
    drawCircle(x, y, size, Poly, amount, amount_rotfix + 90 + math.cos(RealTime() * 2) * 5)
    -- HP Bottom
    surface.SetDrawColor(col)
    drawCircle(x, y, size, Poly, amount, amount_rotfix + 90 + math.cos(RealTime() * 0.6) * 5)

    surface.SetDrawColor(0, 0, 0, 200)
    surface.SetMaterial(icon)
    surface.DrawTexturedRect(x - size * .47 - 2, y - size * .47 - 2, size + 4, size + 4)


    surface.SetDrawColor(col.r - 50, col.g - 50, col.b - 50, 200)
    surface.DrawTexturedRect(x - size * .47, y - size * .47, size, size)

    surface.SetMaterial(BubbleMaterial)
    for _, v in pairs(Bubbles) do
        local b_x = v.x
        local b_y = v.y
        local b_size = v.size
        local _timer = v.timer
        surface.SetDrawColor(10, 10, 10, v.alpha)
        surface.DrawTexturedRect(b_x + math.cos(_timer) * 2, b_y, b_size, b_size)
    end
    --local _, __ = drawShadowText(name, "FlameHUD.StatusText", x, y - font_size["FlameHUD.StatusText"].h*.5, Color(255,255,255), 1, 1)
    drawShadowText(var, 'travka.btn', x - 2, y + size * .75, Color(col.r - 50, col.g - 50, col.b - 50, 200), 1, 1)
end

local last_hitman_pos_timer = 0
local function FlameHUD()
    date = os.date("%d/%m/%Y - %H:%M",os.time())
    if LocalPlayer():Health() <= 0 then
      local h = ScrH()*.1
        surface_SetDrawColor(0,0,0)
        surface_DrawRect(0, 0, ScrW(), h)
        surface_DrawRect(0, ScrH()-h, ScrW(), h)

        if nextspawn >= CurTime() then
            draw.SimpleText("До респавна осталось "..math_Round(nextspawn - CurTime() ).." сек.", 'FlameHUD.StatusText2', ScrW() * 0.5, ScrH() - h*.5, Color(255,255,255), 1, 1)
        else
            draw.SimpleText('Чтобы возродится, нажмите любую клавишу', 'FlameHUD.StatusText2', ScrW() * 0.5, ScrH() - h*.5, Color(255,255,255), 1, 1)
        end
        draw.SimpleText('Вы умерли!', 'FlameHUD.StatusText4', ScrW() * 0.5, h*.5, Color(255,255,255), 1, 1)
        return
    end
    if hook.Run("HUDShouldDraw", "hideDarkRPHUD") == false then return end

    local ent = LocalPlayer():GetEyeTrace().Entity
    if IsValid(ent) then
        if ent:GetClass() == 'prop_ragdoll' then
            ent.TraceInfo = "<font=" .. FlameDev.GetFont(10) .. "><color=255,126,126>Бездыханное тело</color></font>"
        end
        if (ent.TraceInfo ~= nil) and (LocalPlayer():GetPos():DistToSqr(ent:GetPos()) < 40000) then
            if not parsed_text[ent:GetClass()] then parsed_text[ent:GetClass()] = {parsed = markup.Parse(ent.TraceInfo), nonparsed = ent.TraceInfo} end
            if parsed_text[ent:GetClass()].nonparsed ~= ent.TraceInfo then parsed_text[ent:GetClass()] = {parsed = markup.Parse( ent.TraceInfo), nonparsed = ent.TraceInfo} end

            local e_pos = (ent:GetPos() + Vector(0,0,ent:OBBMaxs().z))

            local t_w, t_h = parsed_text[ent:GetClass()].parsed:Size()
            t_h = t_h + 2

            if ent.TraceInfo_OffSet ~= nil then e_pos = e_pos + ent.TraceInfo_OffSet end

            e_pos = e_pos:ToScreen()

            DrawBlurRect(e_pos.x - t_w*.5 - 4, e_pos.y - t_h, t_w + 8, t_h, Color(0,0,0,200))
            parsed_text[ent:GetClass()].parsed:Draw( e_pos.x - t_w*.5, e_pos.y - t_h, 0, 0 )
            draw_SimpleTextOutlined("Напиши /hire что бы нанять " .. ent:Name() .. " за " .. rp.FormatMoney(ent:GetHirePrice()), FlameDev.GetFont(8), ScrW()*.5, ScrH()*.5 + 50, Color(255,128,128), 1, 1, 1, Color(0,0,0))
        end
    end


    if IsValid( ent ) then
            
        local owner = ent:GetNWEntity('pp_owner')
        
        local owner_name = "World"
        
        if IsValid( owner ) then
            
            owner_name = owner:GetName()
            
        end
        surface.SetFont('Default')
        local w,h = surface.GetTextSize(owner_name)
        w = w + 10
        local l = ScrW() - w - 20
        local t = ScrH() * 0.5
        draw.RoundedBoxEx( 4, l - 5, t - 12, 5, 24, Color(255, 155, 55, 200), true, false, true, false )
        draw.RoundedBoxEx( 4, l, t - 12, w, 24, Color( 0, 0, 0, 200 ), false, true, false, true )
        draw_SimpleText( owner_name, 'travka.prop', l + 5, t - h*.5, Color( 255, 255, 255 ) )
            
    end

--     local shownewsstart = 0 
--     TerritoryName_TR = ""
--     TerritoryNameColor_TR = ""
--     TerritoryZaxvat_TR = ""

--     x = ScrW()
--     y = ScrH()

--     TerritoryName_TR = ""
--     TerritoryNameColor_TR = ""
--     TerritoryZaxvat_TR = ""

-- for k,v in pairs(territory_table) do
--     local x_true = false
--     local y_true = false
--     local z_true = false

--     local pos1 =  string.Explode(" ",v.POS1)
--     local pos2 =  string.Explode(" ",v.POS2)
--     local playerpos = string.Explode(" ",tostring(LocalPlayer():GetPos()))

--         if tonumber(pos1[1]) < tonumber(pos2[1]) then
--             if math.Clamp(tonumber(playerpos[1]),tonumber(pos1[1]),tonumber(pos2[1])) == tonumber(playerpos[1]) then
--                 x_true = true
--             end
--         else
--             if math.Clamp(tonumber(playerpos[1]),tonumber(pos2[1]),tonumber(pos1[1])) == tonumber(playerpos[1]) then
--                 x_true = true
--             end
--         end

--         if tonumber(pos1[2]) < tonumber(pos2[2]) then
--             if math.Clamp(tonumber(playerpos[2]),tonumber(pos1[2]),tonumber(pos2[2])) == tonumber(playerpos[2]) then
--                 y_true = true
--             end
--         else
--             if math.Clamp(tonumber(playerpos[2]),tonumber(pos2[2]),tonumber(pos1[2])) == tonumber(playerpos[2]) then
--                 y_true = true
--             end
--         end

--         if tonumber(pos1[3]) < tonumber(pos2[3]) then
--             if math.Clamp(tonumber(playerpos[3]),tonumber(pos1[3]),tonumber(pos2[3])) == tonumber(playerpos[3]) then
--                 z_true = true
--             end
--         else
--             if math.Clamp(tonumber(playerpos[3]),tonumber(pos2[3]),tonumber(pos1[3])) == tonumber(playerpos[3]) then
--                 z_true = true
--             end
--         end
        
--         if x_true and y_true and z_true then
--             TerritoryName_TR = v.NAME
--             if v.IDPARTY ~= "nil" then
--                 TerritoryNameColor_TR = v.NAMEPARTY.."/"..v.COLOR
--             else
--                 TerritoryNameColor_TR = ""
--             end
--             if GetGlobalBool(v.NAME.."_BOOL") then
--                 TerritoryZaxvat_TR = "Идет захват территории! Осталось: "..GetGlobalInt(v.NAME.."_TIME").." секунд"
--             elseif GetGlobalInt(v.NAME.."_TEXT") == 1 then
--                 TerritoryZaxvat_TR = "Захват был прерван!"
--             elseif GetGlobalInt(v.NAME.."_TEXT") == 2 then
--                 TerritoryZaxvat_TR = "Территория была успешно захвачена!"
--             elseif GetGlobalInt(v.NAME.."_TEXT") == 0 then
--                 TerritoryZaxvat_TR = ""
--             end
--         end
-- end

-- local territoryname = TerritoryName_TR
-- local terrtiryzaxvat = TerritoryZaxvat_TR
-- local scrW = ScrW()
-- local scrH = ScrH()
-- if territoryname ~= "" then
--     frametext(territoryname,'travka.btn',5,0,Color(255,255,255),5,15)

--     nilparty = false
--     for k,v in pairs(territory_table) do
--         if v.NAME == territoryname then
--             if v.IDPARTY ~= "nil" then
--                 nilparty = true
--             end
--             break
--         end
--     end

--     if terrtiryzaxvat == "" then
--         if nilparty then
--             local stringexp = string.Explode("/",TerritoryNameColor_TR)
--             local color = {}
--             if #stringexp > 1 then
--                 color = string.Explode("-",stringexp[2])
--             else
--                 color = {"255","0","0"}
--             end
--                 frametext('Объект: '..stringexp[1],"travka.btn",5,35,Color(255,255,255),0,1)
--             else
--                 frametext('Не контролируется','travka.btn',5,25,Color(255,255,255),5,15)
--             end
--         end

--         if terrtiryzaxvat ~= "" then
--             frametext(terrtiryzaxvat,"travka.btn",5,30,Color(255,255,255),0,1)
--         end
--     end

    local bar_r = ScrH()*.043
    local bar_x, bar_y = bar_r + 10, ScrH() - bar_r - 20, ScrH()*.05

    local cin = (math_sin(CurTime() * 6) + 1) * .5
    local alpha = math_abs( math_sin( CurTime( ) * 1.5 ) * 255 )

    hp_pLerp = Lerp(0.02, hp_pLerp, LocalPlayer():Health())
    if hp_pLerp < 30 then
        DrawCircleBar("Жизни", bar_x, bar_y, bar_r, hp_pLerp, Color(255,100,100, 55), Color(255,100,100, 55), Color(alpha, 20, 20, 200))
    else
        DrawCircleBar("Жизни", bar_x, bar_y, bar_r, hp_pLerp, Color(255,100,100, 55), Color(255,100,100, 55))
    end
    bar_x = bar_x + bar_r*2 + 20

    armor_pLerp = Lerp(0.02, armor_pLerp, LocalPlayer():Armor())
    if armor_pLerp > 1 then
        DrawCircleBar("Броня", bar_x, bar_y, bar_r, armor_pLerp, Color(100,100,255, 55), Color(100,100,255, 55), nil, icon_armor)
        bar_x = bar_x + bar_r*2 + 20
    end

    local plyhunger = (LocalPlayer():HFMGetVar("HFM_Hunger") or 5)
    hunger_pLerp = Lerp(0.02, hunger_pLerp, plyhunger)
    if hunger_pLerp <= 0 then
        DrawCircleBar("Голод", bar_x, bar_y, bar_r, hunger_pLerp, Color(255,188,66, 55), Color(255,188,66, 55), Color(alpha, 20, 20, 200), icon_hunger)
    else
        DrawCircleBar("Голод", bar_x, bar_y, bar_r, hunger_pLerp, Color(255,188,66, 55), Color(255,188,66, 55), nil, icon_hunger)
    end

    local PlayerWeapon = LocalPlayer():GetActiveWeapon()
    local countAmmoClip
    local countAmmoTotal

    if IsValid(PlayerWeapon) then
        countAmmoClip = tonumber(PlayerWeapon:Clip1())
        countAmmoTotal = LocalPlayer():GetAmmoCount(PlayerWeapon:GetPrimaryAmmoType())
    else
        countAmmoClip = 0
        countAmmoTotal = 0
    end
    
    if IsValid(PlayerWeapon) then
        if (PlayerWeapon ~= nil and (countAmmoClip ~= -1)) then
            ammo1 = countAmmoClip or 0
            if countAmmoClip <= 0 and countAmmoTotal <= 0 then
                ammod = "Пусто!"
            else
                ammod = countAmmoClip .. "/" .. countAmmoTotal
            end
            maxammo1 = PlayerWeapon:GetMaxClip1()
        end
        if (countAmmoTotal > 0) and countAmmoClip < 0 then
            ammo1 = countAmmoTotal or 0
            if countAmmoTotal <= 0 then
                ammod = "Пусто!"
            else
                ammod = countAmmoTotal
            end
            maxammo1 = PlayerWeapon:GetMaxClip1()
        end
        ammototal = countAmmoTotal 
    else
        ammo1 = 0
        ammod = "Пусто!"
        maxammo1 = 100
        ammototal = 0
    end
    if IsValid(LocalPlayer():GetActiveWeapon()) then
        if countAmmoTotal == -1 or countAmmoTotal <= 0 and countAmmoClip <= 0 then

        else
            ammo_pLerp = Lerp(0.02, ammo_pLerp, ammo1)
            DrawBoxA(ScrW() - ScrW()*0.095,ScrH()*.95,ScrW()*0.09,ScrH()*.04, ammo_pLerp, maxammo1, Color(100,255,100, 150), ammod )
        end
    end


    local show = false
    local statsinfo = {}

    -- if LocalPlayer():IsMonster() and LocalPlayer():GetNWBool("OnSun",false) then
    --     statsinfo[#statsinfo + 1] = {"Вы получаете 3x урона!", Color(255,0,0)}

    --     if CurTime() < LocalPlayer():GetNWInt("OnSun_start") then
    --         local time = math.Round(LocalPlayer():GetNWInt("OnSun_start") - CurTime())
    --         statsinfo[#statsinfo + 1] = {"Вы начнете гореть через: ".. time .. " сек", Color(255, 255, 255)}
    --     else
    --         statsinfo[#statsinfo + 1] = {"Вы горите! Спрячтесь впомещении!", Color(255,cin*255,cin*255)}
    --     end

    --     show = true
    -- end

    if LocalPlayer():GetNWBool("mask") then
        statsinfo[#statsinfo + 1] = {"Маска для ограблений: ".. math.Round(LocalPlayer():GetNWInt("masktime", 0) - CurTime()) .. " сек." ,Color(210, 190, 65)}
        show = true
    end

    if LocalPlayer():GetNWBool("maskon") then
        statsinfo[#statsinfo + 1] = {"Маскировка" ,Color(90, 90, 90)}
        show = true
    end

    if GetGlobalInt('LockDownNeprikos') and (GetGlobalInt('LockDownNeprikos') > CurTime()) then
        statsinfo[#statsinfo + 1] = {'Защита мэра: ' .. math.ceil(GetGlobalInt('LockDownNeprikos') - CurTime()), Color(255, 255, 255)}
        show = true
    end

    local j_x,j_y = 25, bar_y - bar_r - 5 - font_size["FlameHUD.StatusText2"].h
    if show then
        local x = 25
        local b = 0
        for k,v in pairs(statsinfo) do
            local ti,___ = drawShadowText(v[1], "FlameHUD.StatusText3",x + b, j_y + 5, v[2],0,0)
            local ti2,____ = 0,0
            local des = 5
            if k ~= #statsinfo then
                ti2,____ = drawShadowText("|", "FlameHUD.StatusText3",x + b + ti + 5, j_y + 5, Color(255,155,55),0,0)
                des = 10
            end
            b = b + ti + ti2 + 10
        end
        j_y = j_y - font_size["FlameHUD.StatusText2"].h
    end

    -- local teamName = LocalPlayer():GetJobName()
    local Rpjob = team.GetName(LocalPlayer():Team())
    local pur = LocalPlayer():getDarkRPVar("money") or 0
    local teamCol = team.GetColor(LocalPlayer():Team())
    local _, __ = drawShadowText(Rpjob, "FlameHUD.StatusText3",j_x,j_y,teamCol,0,0)
    local _1, __1 = drawShadowText("Общее Время", "FlameHUD.StatusText3",j_x + 1660,j_y - 900,Color(255,255,255),0,0)
    local _2, __2 = drawShadowText(timeToStr(LocalPlayer():GetUTimeTotalTime() ), "FlameHUD.StatusText3",j_x + 1655,j_y - 875,Color(255,255,255),0,0)
    local _3, __3 = drawShadowText("Сессия", "FlameHUD.StatusText3",j_x + 1690,j_y - 850,Color(255,255,255),0,0)
    local _4, __4 = drawShadowText(timeToStr(LocalPlayer():GetUTimeSessionTime() ), "FlameHUD.StatusText3",j_x + 1667,j_y - 827,Color(255,255,255),0,0)
    drawShadowText("  "..DarkRP.formatMoney(math_Round(math_ceil(LocalPlayer():getDarkRPVar("money") or 0))) .. ' + ' .. DarkRP.formatMoney(math_ceil(LocalPlayer():getDarkRPVar("salary") or 0)), "FlameHUD.StatusText3",j_x + _,j_y,varcol('m', math_ceil(LocalPlayer():getDarkRPVar("money") or 0)),0,0) 
    j_y = j_y - font_size["FlameHUD.StatusText3"].h  - 5
    if GetGlobalBool("LockDown1") then
        drawShadowText("!Комендантский час, вернитесь домой!", "FlameHUD.StatusText2",ScrW()*.5, 5, Color(cin * 255, 0, 255 - (cin * 255)),1,0)
        --drawShadowText("Причина: "..nw.GetGlobal("lockdown_reason"), "FlameHUD.StatusText2",ScrW()*.5, 35, Color(cin * 255, 0, 255 - (cin * 255)),1,0)
    end 
end

hook.Add("HUDPaint", "MyRect", function()
    surface.SetDrawColor(100,100,100,66)
    surface.DrawRect(1650, 76, 200, 1)
end)

hook.Add("HUDPaint","FlameDev.DrawHUD",FlameHUD)

hook.Remove("PostDrawOpaqueRenderables", "MonsterWH", function()
    if LocalPlayer():Team() == TEAM_MONSTER then
        for k, v in ipairs(player_GetAll()) do
            if not v:Alive() then continue end
            if not v:GetPos():ToScreen().visible then continue end
            local dist = v:GetPos():DistToSqr(LocalPlayer():GetShootPos())
            if dist > 2250000 then continue end

            local ang = v:GetAngles()
            local pos = v:GetPos()
            ang = Angle(ang.p + 90, ang.y, 0)
            cam_IgnoreZ( true )
                render_ClearStencil()
                render_SetStencilEnable(true)
                render_SetStencilWriteMask(255)
                render_SetStencilTestMask(255)
                render_SetStencilReferenceValue(15)
                render_SetStencilFailOperation(STENCILOPERATION_KEEP)
                render_SetStencilZFailOperation(STENCILOPERATION_KEEP)
                render_SetStencilPassOperation(STENCILOPERATION_REPLACE)
                render_SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
                render_SetBlend(0) --don't visually draw, just stencil
                v:SetModelScale(1.025, 0) --slightly fuzzy, looks better this way
                v:DrawModel()
                v:SetColor(Color(0,0,0,0))
                v:SetRenderMode( RENDERMODE_TRANSALPHA )
                v:SetModelScale(1, 0)
                render_SetBlend(1)
                render_SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
                cam_Start3D2D(pos, ang, 1)
                    surface_SetDrawColor(255,0,0,255)
                    surface_DrawRect(-ScrW(), -ScrH(), ScrW() * 2, ScrH() * 2)
                cam_End3D2D()
            cam_IgnoreZ( false )

            v:DrawModel()
            render_SetStencilEnable(false)
        end
    end
end)

local drawST = draw.SimpleText
local teamGC = team.GetColor
local camS = cam.Start3D2D
local camE = cam.End3D2D

local vec13 = Vector(0, 0, 13)
local vec10 = Vector(0, 0, 10)

local function DrawPlayerInfo(pl, pos)
    local LP = LocalPlayer()
    local div = 0

    pos = pos + vec10
    local Bone = pl:LookupBone('ValveBiped.Bip01_Head1')
    if Bone then
        local BonePos, _ = pl:GetBonePosition(Bone)
        if BonePos then 
            pos = BonePos + vec13
        end
    end

    pos = pos:ToScreen()
    pos.y = pos.y - 10
    if pl:GetNWBool("mask") then
        DrawCenteredTextOutlined('Лицо скрыто маской', 'PlayerInfo', pos.x, pos.y, color_white, div, 1, color_black)
    else
        local posw, posh = DrawCenteredTextOutlined(pl:GetJobName(), 'PlayerInfo', pos.x, pos.y, pl:GetJobColor(), div + 1, 1, color_black)
        DrawCenteredTextOutlined(pl:Name(), 'PlayerInfo', pos.x, pos.y, color_white, div, 1, color_black)
        if pl:IsWanted() then
            DrawCenteredTextOutlined('В розыске!', 'PlayerInfo', pos.x, pos.y-55, color_red, div, 1, color_black)
        end
        if pl:GetNWBool('typing') then
            local rcol = HSVToColor( CurTime() % 6 * 60, 1, 1 )
            DrawCenteredTextOutlined("Пишет...", "PlayerInfosm", pos.x, pos.y+40, Color(rcol.r, rcol.g, rcol.b, 255), div, 1, color_black)
        end
        if pl:GetOrg() then
            DrawCenteredTextOutlined(pl:GetOrg(), 'PlayerInfo', pos.x, pos.y, pl:GetOrgColor(), div - 1, 1, color_black)
        end
        if LocalPlayer():IsHitman() and pl:HasHit() and (pl ~= LocalPlayer()) then
            DrawCenteredTextOutlined('Заказ ' .. DarkRP.formatMoney(pl:GetHitPrice()), 'PlayerInfo', pos.x, pos.y, color_red, div - 2.2, 1, color_black)
        end
		if pl:HasLicense() then
			surface.SetMaterial(material_licence)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(pos.x + posw / 2 + 5, pos.y + 6, 16, 16)
		end
    end
end

local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
end
usermessage.Hook("_Notify", DisplayNotify)

