if not mods["CompressedFluids"] then return end

--=================================================================================================

local function startsWith(inputstr, start) 
  return inputstr:sub(1, #start) == start 
end

local function removePrefix(inputstr, start)
  return inputstr:gsub(prefix, '')
end 

--=================================================================================================

local HP_PREFIX = "high-pressure-"

local HP_FLUIDS = {
  ["high-pressure-alien-goo"] = true,
  ["high-pressure-alien-spores"] = true,
  ["high-pressure-ammonia"] = true,
  ["high-pressure-ammoniated-brine"] = true,
  ["high-pressure-angels-ore8-anode-sludge"] = true,
  ["high-pressure-angels-ore8-slime"] = true,
  ["high-pressure-angels-ore8-sludge"] = true,
  ["high-pressure-angels-ore8-solution"] = true,
  ["high-pressure-angels-ore9-anode-sludge"] = true,
  ["high-pressure-angels-ore9-slime"] = true,
  ["high-pressure-angels-ore9-sludge"] = true,
  ["high-pressure-angels-ore9-solution"] = true,
  ["high-pressure-biomethanol"] = true,
  ["high-pressure-brine"] = true,
  ["high-pressure-carbon-dioxide"] = true,
  ["high-pressure-chlorine"] = true,
  ["high-pressure-chlorine"] = true,
  ["high-pressure-crude-oil"] = true,
  ["high-pressure-crystal-matrix"] = true,
  ["high-pressure-crystal-seedling"] = true,
  ["high-pressure-crystal-slurry"] = true,
  ["high-pressure-deuterium"] = true,
  ["high-pressure-dinitrogen-tetroxide"] = true,
  ["high-pressure-dirty-water"] = true,
  ["high-pressure-epoxy"] = true,
  ["high-pressure-ferric-chloride-solution"] = true,
  ["high-pressure-formaldehyde"] = true,
  ["high-pressure-gas-acetone"] = true,
  ["high-pressure-gas-acid"] = true,
  ["high-pressure-gas-allylchlorid"] = true,
  ["high-pressure-gas-ammonia"] = true,
  ["high-pressure-gas-ammonium-chloride"] = true,
  ["high-pressure-gas-benzene"] = true,
  ["high-pressure-gas-butadiene"] = true,
  ["high-pressure-gas-butane"] = true,
  ["high-pressure-gas-carbon-dioxide"] = true,
  ["high-pressure-gas-carbon-monoxide"] = true,
  ["high-pressure-gas-chlor-methane"] = true,
  ["high-pressure-gas-chlorine"] = true,
  ["high-pressure-gas-compressed-air"] = true,
  ["high-pressure-gas-deuterium"] = true,
  ["high-pressure-gas-dimethylamine"] = true,
  ["high-pressure-gas-dimethylhydrazine"] = true,
  ["high-pressure-gas-dinitrogen-tetroxide"] = true,
  ["high-pressure-gas-epichlorhydrin"] = true,
  ["high-pressure-gas-ethane"] = true,
  ["high-pressure-gas-ethanol"] = true,
  ["high-pressure-gas-ethylene-oxide"] = true,
  ["high-pressure-gas-ethylene"] = true,
  ["high-pressure-gas-formaldehyde"] = true,
  ["high-pressure-gas-hydrazine"] = true,
  ["high-pressure-gas-hydrogen-chloride"] = true,
  ["high-pressure-gas-hydrogen-fluoride"] = true,
  ["high-pressure-gas-hydrogen-peroxide"] = true,
  ["high-pressure-gas-hydrogen-sulfide"] = true,
  ["high-pressure-gas-hydrogen"] = true,
  ["high-pressure-gas-melamine"] = true,
  ["high-pressure-gas-methane"] = true,
  ["high-pressure-gas-methanol"] = true,
  ["high-pressure-gas-methylamine"] = true,
  ["high-pressure-gas-monochloramine"] = true,
  ["high-pressure-gas-natural-1"] = true,
  ["high-pressure-gas-nitrogen-dioxide"] = true,
  ["high-pressure-gas-nitrogen-monoxide"] = true,
  ["high-pressure-gas-nitrogen"] = true,
  ["high-pressure-gas-oxygen"] = true,
  ["high-pressure-gas-phosgene"] = true,
  ["high-pressure-gas-propene"] = true,
  ["high-pressure-gas-puffer-atmosphere"] = true,
  ["high-pressure-gas-raw-1"] = true,
  ["high-pressure-gas-residual"] = true,
  ["high-pressure-gas-silane"] = true,
  ["high-pressure-gas-sulfur-dioxide"] = true,
  ["high-pressure-gas-synthesis"] = true,
  ["high-pressure-gas-tungsten-hexafluoride"] = true,
  ["high-pressure-gas-urea"] = true,
  ["high-pressure-gas"] = true,
  ["high-pressure-glycerol"] = true,
  ["high-pressure-heavy-oil"] = true,
  ["high-pressure-heavy-water"] = true,
  ["high-pressure-hydrazine"] = true,
  ["high-pressure-hydrogen-chloride"] = true,
  ["high-pressure-hydrogen-peroxide"] = true,
  ["high-pressure-hydrogen-sulfide"] = true,
  ["high-pressure-hydrogen"] = true,
  ["high-pressure-light-oil"] = true,
  ["high-pressure-liquid-acetic-acid"] = true,
  ["high-pressure-liquid-acetic-anhydride"] = true,
  ["high-pressure-liquid-aqueous-sodium-hydroxide"] = true,
  ["high-pressure-liquid-bisphenol-a"] = true,
  ["high-pressure-liquid-black-liquor"] = true,
  ["high-pressure-liquid-brown-liquor"] = true,
  ["high-pressure-liquid-cellulose-acetate-mixture"] = true,
  ["high-pressure-liquid-cellulose-acetate"] = true,
  ["high-pressure-liquid-chlorauric-acid"] = true,
  ["high-pressure-liquid-condensates"] = true,
  ["high-pressure-liquid-coolant-used"] = true,
  ["high-pressure-liquid-coolant"] = true,
  ["high-pressure-liquid-cupric-chloride-solution"] = true,
  ["high-pressure-liquid-ethylbenzene"] = true,
  ["high-pressure-liquid-ethylene-carbonate"] = true,
  ["high-pressure-liquid-fermentation-raw"] = true,
  ["high-pressure-liquid-ferric-chloride-solution"] = true,
  ["high-pressure-liquid-fish-atmosphere"] = true,
  ["high-pressure-liquid-fish-oil"] = true,
  ["high-pressure-liquid-fuel-oil"] = true,
  ["high-pressure-liquid-fuel"] = true,
  ["high-pressure-liquid-glycerol"] = true,
  ["high-pressure-liquid-green-liquor"] = true,
  ["high-pressure-liquid-hexachloroplatinic-acid"] = true,
  ["high-pressure-liquid-hexafluorosilicic-acid"] = true,
  ["high-pressure-liquid-hydrochloric-acid"] = true,
  ["high-pressure-liquid-hydrofluoric-acid"] = true,
  ["high-pressure-liquid-mineral-oil"] = true,
  ["high-pressure-liquid-multi-phase-oil"] = true,
  ["high-pressure-liquid-naphtha"] = true,
  ["high-pressure-liquid-ngl"] = true,
  ["high-pressure-liquid-nitric-acid"] = true,
  ["high-pressure-liquid-nutrient-pulp"] = true,
  ["high-pressure-liquid-perchloric-acid"] = true,
  ["high-pressure-liquid-phenol"] = true,
  ["high-pressure-liquid-plastic"] = true,
  ["high-pressure-liquid-polluted-fish-atmosphere"] = true,
  ["high-pressure-liquid-polyethylene"] = true,
  ["high-pressure-liquid-propionic-acid"] = true,
  ["high-pressure-liquid-pulping-liquor"] = true,
  ["high-pressure-liquid-raw-fish-oil"] = true,
  ["high-pressure-liquid-raw-vegetable-oil"] = true,
  ["high-pressure-liquid-resin"] = true,
  ["high-pressure-liquid-rubber"] = true,
  ["high-pressure-liquid-styrene"] = true,
  ["high-pressure-liquid-sulfuric-acid"] = true,
  ["high-pressure-liquid-titanium-tetrachloride"] = true,
  ["high-pressure-liquid-toluene"] = true,
  ["high-pressure-liquid-trichlorosilane"] = true,
  ["high-pressure-liquid-tungstic-acid"] = true,
  ["high-pressure-liquid-vegetable-oil"] = true,
  ["high-pressure-liquid-water-heavy"] = true,
  ["high-pressure-liquid-water-semiheavy-1"] = true,
  ["high-pressure-liquid-water-semiheavy-2"] = true,
  ["high-pressure-liquid-water-semiheavy-3"] = true,
  ["high-pressure-liquid-white-liquor"] = true,
  ["high-pressure-lithia-water"] = true,
  ["high-pressure-lubricant"] = true,
  ["high-pressure-mineral-sludge"] = true,
  ["high-pressure-mineral-water"] = true,
  ["high-pressure-nitric-acid"] = true,
  ["high-pressure-nitric-oxide"] = true,
  ["high-pressure-nitrogen-dioxide"] = true,
  ["high-pressure-nitrogen"] = true,
  ["high-pressure-nitroglycerin"] = true,
  ["high-pressure-organotins"] = true,
  ["high-pressure-oxygen"] = true,
  ["high-pressure-petroleum-gas"] = true,
  ["high-pressure-pure-water"] = true,
  ["high-pressure-se-antimatter-stream"] = true,
  ["high-pressure-se-beryllium-hydroxide"] = true,
  ["high-pressure-se-bio-sludge"] = true,
  ["high-pressure-se-chemical-gel"] = true,
  ["high-pressure-se-contaminated-bio-sludge"] = true,
  ["high-pressure-se-contaminated-space-water"] = true,
  ["high-pressure-se-cryonite-slush"] = true,
  ["high-pressure-se-ion-stream"] = true,
  ["high-pressure-se-kr-imersium-sulfide"] = true,
  ["high-pressure-se-liquid-rocket-fuel"] = true,
  ["high-pressure-se-methane-gas"] = true,
  ["high-pressure-se-molten-beryllium"] = true,
  ["high-pressure-se-molten-copper"] = true,
  ["high-pressure-se-molten-holmium"] = true,
  ["high-pressure-se-molten-iron"] = true,
  ["high-pressure-se-neural-gel-2"] = true,
  ["high-pressure-se-neural-gel"] = true,
  ["high-pressure-se-nutrient-gel"] = true,
  ["high-pressure-se-particle-stream"] = true,
  ["high-pressure-se-plasma-stream"] = true,
  ["high-pressure-se-proton-stream"] = true,
  ["high-pressure-se-pyroflux"] = true,
  ["high-pressure-se-space-coolant-cold"] = true,
  ["high-pressure-se-space-coolant-hot"] = true,
  ["high-pressure-se-space-coolant-supercooled"] = true,
  ["high-pressure-se-space-coolant-warm"] = true,
  ["high-pressure-se-space-water"] = true,
  ["high-pressure-se-vitalic-acid"] = true,
  ["high-pressure-slag-slurry"] = true,
  ["high-pressure-sour-gas"] = true,
  ["high-pressure-steam"] = true,
  ["high-pressure-sulfur-dioxide"] = true,
  ["high-pressure-sulfuric-acid"] = true,
  ["high-pressure-sulfuric-nitric-acid"] = true,
  ["high-pressure-thermal-water"] = true,
  ["high-pressure-tungstic-acid"] = true,
  ["high-pressure-vinyl-chloride"] = true,
  ["high-pressure-water-concentrated-mud"] = true,
  ["high-pressure-water-green-waste"] = true,
  ["high-pressure-water-greenyellow-waste"] = true,
  ["high-pressure-water-heavy-mud"] = true,
  ["high-pressure-water-light-mud"] = true,
  ["high-pressure-water-mineralized"] = true,
  ["high-pressure-water-purified"] = true,
  ["high-pressure-water-red-waste"] = true,
  ["high-pressure-water-saline"] = true,
  ["high-pressure-water-thin-mud"] = true,
  ["high-pressure-water-viscous-mud"] = true,
  ["high-pressure-water-yellow-waste"] = true,
  ["high-pressure-water"] = true,
  ["high-pressure-ei_acidic-water"] = true,
  ["high-pressure-ei_ammonia-gas"] = true,
  ["high-pressure-ei_benzol"] = true,
  ["high-pressure-ei_bio-sludge"] = true,
  ["high-pressure-ei_coal-gas"] = true,
  ["high-pressure-ei_cold-coolant"] = true,
  ["high-pressure-ei_concentrated-gaia-water"] = true,
  ["high-pressure-ei_critical-steam"] = true,
  ["high-pressure-ei_cryoflux"] = true,
  ["high-pressure-ei_crystal-solution"] = true,
  ["high-pressure-ei_deuterium"] = true,
  ["high-pressure-ei_diesel"] = true,
  ["high-pressure-ei_dinitrogen-tetroxide-gas"] = true,
  ["high-pressure-ei_dinitrogen-tetroxide-water-solution"] = true,
  ["high-pressure-ei_dirty-water"] = true,
  ["high-pressure-ei_drill-fluid"] = true,
  ["high-pressure-ei_gaia-water"] = true,
  ["high-pressure-ei_heated-deuterium"] = true,
  ["high-pressure-ei_heated-helium-3"] = true,
  ["high-pressure-ei_heated-lithium-6"] = true,
  ["high-pressure-ei_heated-protium"] = true,
  ["high-pressure-ei_heated-tritium"] = true,
  ["high-pressure-ei_heavy-destilate"] = true,
  ["high-pressure-ei_helium-3"] = true,
  ["high-pressure-ei_hot-coolant"] = true,
  ["high-pressure-ei_hydrofluoric-acid"] = true,
  ["high-pressure-ei_hydrogen-gas"] = true,
  ["high-pressure-ei_kerosene"] = true,
  ["high-pressure-ei_lithium-6"] = true,
  ["high-pressure-ei_lithium-7"] = true,
  ["high-pressure-ei_lube-destilate"] = true,
  ["high-pressure-ei_medium-destilate"] = true,
  ["high-pressure-ei_molten-copper"] = true,
  ["high-pressure-ei_molten-glass"] = true,
  ["high-pressure-ei_molten-gold"] = true,
  ["high-pressure-ei_molten-iron"] = true,
  ["high-pressure-ei_molten-lead"] = true,
  ["high-pressure-ei_molten-neodym"] = true,
  ["high-pressure-ei_molten-steel"] = true,
  ["high-pressure-ei_neodym-solution"] = true,
  ["high-pressure-ei_nitric-acid"] = true,
  ["high-pressure-ei_nitric-acid-plutonium-239"] = true,
  ["high-pressure-ei_nitric-acid-thorium-232"] = true,
  ["high-pressure-ei_nitric-acid-uranium-233"] = true,
  ["high-pressure-ei_nitric-acid-uranium-235"] = true,
  ["high-pressure-ei_nitrogen-gas"] = true,
  ["high-pressure-ei_oxygen-difluoride"] = true,
  ["high-pressure-ei_oxygen-gas"] = true,
  ["high-pressure-ei_protium"] = true,
  ["high-pressure-ei_pythogas"] = true,
  ["high-pressure-ei_residual-oil"] = true,
  ["high-pressure-ei_tritium"] = true,
  ["high-pressure-ei_uranium-hexafluorite"] = true,
  ["high-pressure-ei_uranium-solution"] = true
}

local missing_migrations = {}

for fluid, _ in pairs(data.raw.fluid) do
  if startsWith(fluid, HP_PREFIX) and not HP_FLUIDS[fluid] then
    missing_migrations[fluid] = true
  end
end

if table_size(missing_migrations) > 0 then
  log(serpent.block({
    "Better Fluid Throughput would not migrate HP fluid(s):",
    missing_fluid_migration = missing_migrations
  }))
end
