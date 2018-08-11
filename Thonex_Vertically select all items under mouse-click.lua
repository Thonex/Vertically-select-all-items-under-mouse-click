--[[
    Description: Vertically select all items under mouse-click (all tracks)
    Version: 1.0.0
    Author: Thonex
    Changelog:
        Initial Release
]]--
        
function Select_all_items_under_mouse_all_tracks ()

  reaper.PreventUIRefresh(1)
  reaper.ClearConsole() 
  reaper.Undo_BeginBlock()
  
  Mouse_Pos = reaper.BR_PositionAtMouseCursor( true )
  
  Num_Sel_1 = reaper.CountSelectedMediaItems(0 )
  
  t_Prev_Sel_ID = {}

  for i=0,  Num_Sel_1 -1 do -- scans already selected PLUS the clicked item (clicked item will be first ID)
     t_Prev_Sel_ID[i] = reaper.GetSelectedMediaItem(0,i)  
  end

  local L_Start, R_End = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false) -- Get TimeSelection from orig position
  local _, __ = reaper.GetSet_LoopTimeRange(true, false, Mouse_Pos-.001, Mouse_Pos+.001, false) -- Set TimeSelection 1 ms to right and left of mouse click
  reaper.Main_OnCommand( 40717, 0)  -- Item: Select all items in current time selection

  for i=0,  Num_Sel_1 -1 do
    reaper.SetMediaItemSelected( t_Prev_Sel_ID[i], 1 ) 
  end

  local _, __ = reaper.GetSet_LoopTimeRange(true, false, L_Start, R_End, false) -- Set TimeSelection

  reaper.PreventUIRefresh(-1)
  reaper.UpdateArrange()
  reaper.Undo_EndBlock("Select all items under cursor",-1)

end 
 Select_all_items_under_mouse_all_tracks ()
