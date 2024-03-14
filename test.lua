

/c local t = 0
for _, s in pairs(game.surfaces) do
  for __, e in pairs(s.find_entities_filtered({name = 'osha-logistic-chest-botRecaller'})) do
    local p = e.position
    local i = e.get_inventory(defines.inventory.chest)
    local c = i.get_contents()
    e.destroy()
    local n = s.create_entity({
      name = 'robot-recall-station',
      position = p,
      raise_built = true,
      force = 'player'
    })
    local ni = n.get_inventory(defines.inventory.chest)
    ni.insert(c)
    t = t+1
  end
end
game.print('Replaced ' .. tostring(t) .. ' chests')