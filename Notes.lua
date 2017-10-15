local NOTE_RADIUSX = nil
local NOTE_RADIUSY = nil
local LINE_SPACING = nil
local NOTE_STEPS = nil
local STEM_HEIGHT = 40

local notes = {}
local types = { quarter=0, half=1, whole=2 }

local function setPressed(this)
  this.colour = function() return {120, 120, 120}; end;
end

local function draw(note, xPos, yPos, type)
  return function(this)
    -- Draw note
    local yOffset = (table.getn(notes) * NOTE_STEPS) - (note * NOTE_STEPS);    
    love.graphics.setColor(this.colour and this.colour() or {0, 0, 0})    
    love.graphics.ellipse(type == types.quarter and 'fill' or 'line', xPos, yPos + yOffset, NOTE_RADIUSX, NOTE_RADIUSY);

    -- Add stem if needed
    if type ~= types.whole then
      local xPosStem = xPos + (NOTE_RADIUSX * 0.8)
      local yPosStem = yPos + yOffset + (NOTE_RADIUSY * 0.5)
      local upOrDown = note <= (table.getn(notes) * 0.5) and -1 or 1      
      love.graphics.line( xPosStem, yPosStem, xPosStem, yPosStem + (STEM_HEIGHT * upOrDown) )
    end

    -- Add name of note to pressed notes
    if this.colour then
      love.graphics.setColor(0, 0, 0) 
      love.graphics.print(this.note, xPos, yPos + yOffset)
    end
  end
end

local function createNote(note, xPos, yPos, type)
  return {
    note = notes[note];
    draw = draw(note, xPos, yPos, type);
    setPressed = setPressed;
  }
end

local function init(LN_SPACING, WIDTH)
  LINE_SPACING = LN_SPACING
  NOTE_STEPS = LN_SPACING * 0.5
  NOTE_RADIUSY = NOTE_STEPS * 0.9
  NOTE_RADIUSX = WIDTH

  -- Initialise array with possible notes
  local offset = string.byte('A')
  local n_letters = string.byte('H') - string.byte('A')
  local possible_positions = 17
  for i=0, possible_positions do
    table.insert(notes, string.char((i % n_letters) + offset))
  end

  return createNote, types
end

return { init=init, types=types }