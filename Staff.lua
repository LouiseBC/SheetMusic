local N_LINES = 9
local LINE_SPACING = 15
local MARGIN_LEFT = 20
local NOTE_WIDTH = LINE_SPACING * 0.75
local Note = require('Notes')(LINE_SPACING, NOTE_WIDTH)

local function addNote(staff, note)
  local shift = MARGIN_LEFT + (table.getn(staff.notes) * NOTE_WIDTH * 2)
  table.insert(staff.notes, Note(note, staff.xPos + shift, staff.yPos))
end

local function draw(staff)
  -- yPos represents the starting point of high C, which intersects with the top line
  local yPos = staff.yPos
  for i=1, N_LINES do
    if i > 2 and i < N_LINES-1 then
      love.graphics.line(
        staff.xPos, 
        yPos + LINE_SPACING * 0.5, 
        staff.xPos + staff.width, 
        yPos + LINE_SPACING * 0.5
      )
    end
    yPos = yPos + LINE_SPACING
  end

  for _, note in ipairs(staff.notes) do
    note:draw()
  end
end

function createStaff(xPos, width, yPos, key)
  local staff = {}
  staff.notes = {}
  staff.xPos = xPos
  staff.yPos = yPos
  staff.width = width

  staff.draw = draw
  staff.addNote = addNote
  return staff
end

return createStaff