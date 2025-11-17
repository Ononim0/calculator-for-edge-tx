local function init()
        buttons = {
        {50, 20, "1"},
        {70, 20, "2"},
        {90, 20, "3"},
        {110, 20, "+"},

        {50, 30, "4"},
        {70, 30, "5"},
        {90, 30, "6"},
        {110, 30, "-"},

        {50, 40, "7"},
        {70, 40, "8"},
        {90, 40, "9"},
        {110, 40, "*"},

        {50, 50, "0"},
        {70, 50, "/"},
        {90, 50, "C"},
        {110, 50, "="},
    }

    select_button = 1

    text = ""
    number1 = 0
    number2 = 0
    fn = ""
end

local function contains(list, value)
    for i, v in ipairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

local function run(event)
    lcd.clear()
    for i, button in ipairs(buttons) do
        local x = button[1]
        local y = button[2]
        local t = button[3]
        if i == select_button  then
            lcd.drawText(x, y, t, INVERS)
        else
            lcd.drawText(x, y, t, 0)
        end 
    end

    if event == EVT_ROT_RIGHT then
        select_button = select_button + 1
        if select_button > #buttons then
            select_button = 1
        end

    elseif event == EVT_ROT_LEFT then
        select_button = select_button - 1
        if select_button < 1  then
            select_button = #buttons            
        end
    end

    if event == EVT_ENTER_FIRST then
        if contains({"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}, buttons[select_button][3]) then
            text = text .. buttons[select_button][3]

        elseif contains({"*", "/", "-", "+"}, buttons[select_button][3]) then 

            if text == "" then
                number1 = 0
            else
                number1 = tonumber(text)
            end
            
            text = "" fn = buttons[select_button][3]
        elseif buttons[select_button][3] == "C" then text = "" fn = "" number1 = 0 number2 = 0
        elseif buttons[select_button][3] == '='  then

            if text == "" then
                number2 = 0
            else
                number2 = tonumber(text)
            end
            
            if fn == "+" then text = tostring(tonumber(number1) + tonumber(number2))
            elseif fn == "-" then text = tostring(tonumber(number1) - tonumber(number2))
            elseif fn == "*" then text = tostring(tonumber(number1) * tonumber(number2))
            elseif fn == "/" then text = tostring(tonumber(number1) / tonumber(number2))
            elseif fn == "" then    
            end
            number1 = 0 number2 = 0
        end
    end

    lcd.drawText(10, 10, text)
    --lcd.drawText(110 - lcd.sizeText(text), 10, text) 
    return 0
end

return { init = init, run=run}