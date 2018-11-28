require('pry')
require_relative('models/space_cowboy.rb')
# SpaceCowboy.delete_all

bounty1 = SpaceCowboy.new({
  'name' => 'Bebop',
  'species' => 'Human',
  'bounty_value' => 1000,
  'fav_weapon' => 'Katana'
  })

bounty2 = SpaceCowboy.new({
  'name' => 'Worf',
  'species' => 'Klingon',
  'bounty_value' => 1500,
  'fav_weapon' => 'Batleth'
  })

bounty3 = SpaceCowboy.new({
  'name' => 'Ratchet',
  'species' => 'Fox',
  'bounty_value' => 1600,
  'fav_weapon' => 'Combuster'
  })

bounty4 = SpaceCowboy.new({
  'name' => 'Sonic',
  'species' => 'Hedgehog',
  'bounty_value' => 1400,
  'fav_weapon' => 'Spin'
  })

  bounty1.save()
  bounty2.save()
  bounty3.save()
  bounty4.save()

  bounty1.delete()
  bounty2.name = "Mrs Worfles"
  bounty2.fav_weapon = "Freeze Fire"
  bounty2.update()

  SpaceCowboy.find_by_name("Sonic")
  SpaceCowboy.find_by_name("Ratchet")

  SpaceCowboy.find_by_id("3")

  all_tracks = SpaceCowboy.all

binding.pry
nil
