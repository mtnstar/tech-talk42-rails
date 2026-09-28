# Die Seeds sind idempotent: Du kannst `bin/rails db:seed` beliebig oft laufen lassen.
# Sobald es die Spalte `canton` gibt (README, Schritt 4), wird sie mitbefüllt.
peaks = [
  ["Dufourspitze",   4634, "VS"], ["Dom",         4545, "VS"], ["Weisshorn",  4506, "VS"],
  ["Matterhorn",     4478, "VS"], ["Finsteraarhorn", 4274, "BE"], ["Jungfrau", 4158, "BE"],
  ["Mönch",          4107, "BE"], ["Piz Bernina", 4049, "GR"], ["Eiger",      3967, "BE"],
  ["Blüemlisalp",    3661, "BE"], ["Tödi",        3614, "GL"], ["Titlis",     3238, "OW"],
  ["Säntis",         2502, "AR"], ["Niesen",      2362, "BE"], ["Stockhorn",  2190, "BE"],
  ["Pilatus",        2128, "LU"], ["Rigi",        1798, "SZ"], ["Chasseral",  1606, "BE"],
  ["Napf",           1408, "LU"], ["Uetliberg",    870, "ZH"]
]

with_canton = Peak.column_names.include?("canton")

peaks.each do |name, altitude, canton|
  peak = Peak.find_or_initialize_by(name:)
  peak.altitude = altitude
  peak.canton = canton if with_canton
  peak.save!
end

puts "🏔️  #{Peak.count} Gipfel im Buch#{" (mit Kanton)" if with_canton}."
