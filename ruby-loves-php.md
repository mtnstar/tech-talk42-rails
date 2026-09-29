# Ruby ❤️ php 

## 🐳 Starten mit Docker

**Ruby (irb):**
```bash
docker run -it --rm ruby:3.4 irb
```

**PHP (PsySH):**
```bash
docker run -it --rm php:8.4-cli sh -c "curl -sL https://psysh.org/psysh -o /usr/local/bin/psysh && chmod +x /usr/local/bin/psysh && psysh"
```

Beenden mit `exit` (irb) bzw. `exit` oder `Ctrl+D` (PsySH). Dank `--rm` bleibt danach nichts zurück.

## 💎 irb vs. 🐘 PHP (PsySH)

| # | Ruby (irb) | PHP (PsySH) | Ergebnis |
|---|---|---|---|
| 1 | `5.times { puts "🏔️" }` | `for ($i = 0; $i < 5; $i++) { echo "🏔️\n"; }` | 5× 🏔️ |
| 2 | `4478.to_s.reverse` | `strrev((string) 4478)` | `"8744"` |
| 3 | `(1..10).include?(5)` | `in_array(5, range(1, 10))` | `true` |
| 4 | `(1..10).to_a` | `range(1, 10)` | `[1, 2, …, 10]` |
| 5 | `("a".."e").to_a` | `range('a', 'e')` | `["a", "b", "c", "d", "e"]` |
| 6 | `[1, 2, 3] - [1]` | `array_values(array_diff([1, 2, 3], [1]))` | `[2, 3]` |
| 7 | `h = { altitude: 4242, name: "Rothorn" }` | `$h = ['altitude' => 4242, 'name' => 'Rothorn'];` | |
| 8 | `h[:altitude]` | `$h['altitude']` | `4242` |
| 9 | `hoehen = [4634, 4478, 3967, 2502, 1798, 858]` | `$hoehen = [4634, 4478, 3967, 2502, 1798, 858];` | |
| 10 | `hoehen.select { it > 4000 }` | `array_values(array_filter($hoehen, fn($h) => $h > 4000))` | `[4634, 4478]` |
| 11 | `hoehen.map { it / 1000.0 }` | `array_map(fn($h) => $h / 1000, $hoehen)` | `[4.634, 4.478, …]` |
| 12 | `hoehen.sum / hoehen.size` | `array_sum($hoehen) / count($hoehen)` | Ruby `3506`, PHP `3506.166…` ⚠️ |
| 13 | `hoehen.max` | `max($hoehen)` | `4634` |
| 14 | `hoehen.sort.first(2)` | `$s = $hoehen; sort($s); array_slice($s, 0, 2)` | `[858, 1798]` |
| 15 | `hoehen.partition { it > 3000 }` | `[array_filter($hoehen, fn($h) => $h > 3000), array_filter($hoehen, fn($h) => $h <= 3000)]` | `[[4634, 4478, 3967], [2502, 1798, 858]]` |
| 16 | `hoehen.each_slice(2).to_a` | `array_chunk($hoehen, 2)` | `[[4634, 4478], [3967, 2502], [1798, 858]]` |
| 17 | `gipfel = { "Eiger" => 3967, "Matterhorn" => 4478, "Niesen" => 2362 }` | `$gipfel = ['Eiger' => 3967, 'Matterhorn' => 4478, 'Niesen' => 2362];` | |
| 18 | `gipfel.max_by { \|name, hoehe\| hoehe }` | `array_search(max($gipfel), $gipfel)` | Ruby `["Matterhorn", 4478]`, PHP `"Matterhorn"` |
| 19 | `gipfel.select { \|_, hoehe\| hoehe > 3000 }.keys` | `array_keys(array_filter($gipfel, fn($h) => $h > 3000))` | `["Eiger", "Matterhorn"]` |
| 20 | `%w[eiger mönch jungfrau].map(&:capitalize)` | `array_map('ucfirst', ['eiger', 'mönch', 'jungfrau'])` | `["Eiger", "Mönch", "Jungfrau"]` |

**Worauf achten:**
- Argument-Reihenfolge: `array_filter($array, $fn)` vs. `array_map($fn, $array)` (10, 11)
- Keine Verkettung: `sort()` sortiert in-place und gibt `true` zurück (14)
- `array_filter` behält die Keys, darum `array_values` (10). Bei 15 haben die Teil-Arrays ihre Original-Keys behalten
- Integer-Division in Ruby, Float in PHP (12)
- Kein `partition` und kein `max_by` in PHP (15, 18)
