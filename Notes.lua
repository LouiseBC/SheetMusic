local WINDOW_WIDTH = 500
local NOTE_WIDTH = nil
local NOTE_HEIGHT = nil
local LINE_SPACING = nil
local NOTE_STEPS = nil
local STEM_HEIGHT = 40

local notes = {}

local function setPressed(this)
  this.colour = function() return {120, 120, 120}; end;
end

local function draw(note, xPos, yPos)
  local yOffset = (table.getn(notes) * NOTE_STEPS) - (note * NOTE_STEPS);
  local upOrDown = note <= (table.getn(notes) * 0.5) and -1 or 1

  return function(this)
    love.graphics.setColor(this.colour and this.colour() or {0, 0, 0})    
    love.graphics.ellipse('fill', xPos, yPos + yOffset, NOTE_WIDTH, NOTE_HEIGHT);
    love.graphics.line(
      xPos + (NOTE_WIDTH * 0.8),
      yPos + yOffset + (NOTE_HEIGHT * 0.5),
      xPos + (NOTE_WIDTH * 0.8),
      yPos + yOffset + (NOTE_HEIGHT * 0.5) + (STEM_HEIGHT * upOrDown)
    )
    if this.colour then
      love.graphics.setColor(0, 0, 0) 
      love.graphics.print(this.note, xPos, yPos + yOffset)
    end
  end

end

local function createNote(note, xPos, yPos)
  -- notes[1] is 'A', the lowest note in G
  return {
    noteNum = note;
    note = notes[note];
    draw = draw(note, xPos, yPos);
    setPressed = setPressed;
  }
end

local function init(SPACING, WIDTH)
  LINE_SPACING = SPACING
  NOTE_STEPS = SPACING/2
  NOTE_HEIGHT = NOTE_STEPS * 0.9
  NOTE_WIDTH = WIDTH

  -- Initialise array with possible notes
  local offset = string.byte('A')
  local n_letters = string.byte('H') - string.byte('A')
  local possible_positions = 17
  for i=0, possible_positions do
    table.insert(notes, string.char((i % n_letters) + offset))
  end

  return createNote
end

return init