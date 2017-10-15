local Staff = require('Staff')
local NoteTypes = require('Notes').types

local pressed = nil
local n_notes = nil
local note_it = 1

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
  love.graphics.setNewFont(20)
  
  staff = Staff(100, 600, 200)
  staff:addNote(1, NoteTypes.whole)
  staff:addNote(5)
  staff:addNote(12, NoteTypes.half)
  staff:addNote(9)

  n_notes = table.getn(staff.notes)
end

function love.draw()
  love.graphics.setColor(0, 0, 0)
  staff:draw()
end

function love.keypressed(key, scancode)
  pressed = key
end

function love.update()
  if not pressed or n_notes < note_it then return end
  if staff.notes[note_it].note == string.upper(pressed) then
    staff.notes[note_it]:setPressed()
    note_it = note_it + 1
    pressed = nil
  end
end
  