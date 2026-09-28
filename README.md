# 🏔️ Gipfelbuch

Eine winzige Rails-App zum Mitmachen beim Tech Talk 42. Ein Model, 20 Schweizer Gipfel, und in 42 Minuten siehst du, was Rails ausmacht.

## Setup

**Codespaces:** *Code → Codespaces → Create codespace*. Das Setup läuft automatisch.

**Docker:**
```bash
docker run -it --rm -v "$PWD":/app -w /app -p 3000:3000 ruby:3.4 bash
bin/setup
```

**Lokal** (Ruby ≥ 3.4): `bin/setup`

Dann `bin/dev` starten und http://localhost:3000 öffnen. Du solltest die Gipfelliste sehen.

---

## 1 · Ruby in irb

```bash
irb
```
```ruby
matterhorn = 4478
(4000..).include?(matterhorn)     # => true
(1000...2000).cover?(1798)        # => true
[4634, 4478, 2502].select { it > 4000 }
4478.to_s.reverse                 # alles ist ein Objekt
:matterhorn.object_id == :matterhorn.object_id  # Symbols gibt es nur einmal
```

## 2 · Convention over Configuration

Die App wurde mit einer einzigen Zeile generiert:
```bash
bin/rails generate scaffold Peak name:string altitude:integer
```

Schau dich um:
- `app/models/peak.rb` ist leer. Woher kennt das Model seine Spalten? *(ActiveRecord liest sie aus der DB.)*
- Woher weiss Rails, dass `Peak` zur Tabelle `peaks` gehört und `PeaksController` die Views in `app/views/peaks/` rendert?
- `config/routes.rb` hat eine Zeile. Was steckt dahinter? `bin/rails routes`

## 3 · Rails Console

```bash
bin/rails console
```
```ruby
Peak.count
Peak.column_names
Peak.find_by(name: "Eiger")
Peak.where(altitude: 4000..).order(altitude: :desc).pluck(:name)
Peak.maximum(:altitude)
Peak.average(:altitude).round

Peak.create(name: "Gurten", altitude: 858)
```

## 4 · Migration: Kanton hinzufügen

```bash
bin/rails generate migration AddCantonToPeaks canton:string
bin/rails db:migrate
```

- Was hat sich in `db/schema.rb` geändert?
- Probier `bin/rails db:rollback` und wieder `bin/rails db:migrate`.
- Die Seeds kennen die Kantone schon. Einfach nochmals laufen lassen: `bin/rails db:seed`

In der Console (`reload!` nicht vergessen):
```ruby
Peak.column_names              # canton ist da, ohne das Model anzufassen
Peak.group(:canton).count
Peak.where(canton: "BE").pluck(:name)
```

**Challenge:** Der Kanton soll auch in der App erscheinen und editierbar sein. Welche drei Dateien musst du anpassen?

<details>
<summary>Lösung</summary>

- `app/views/peaks/_peak.html.erb`: Kanton anzeigen
- `app/views/peaks/_form.html.erb`: `form.text_field :canton`
- `app/controllers/peaks_controller.rb`: `params.expect(peak: [ :name, :altitude, :canton ])`

Die letzte ist die Strong-Parameters-Whitelist. Ohne sie wird der Kanton beim Speichern stillschweigend ignoriert.
</details>

## 5 · ActiveRecord & Arel

Jede Query zeigt ihr SQL:
```ruby
Peak.where(altitude: 4000..).to_sql
```

Arel, wenn es mehr braucht:
```ruby
p = Peak.arel_table
Peak.where(p[:altitude].gt(4000).or(p[:canton].eq("GR"))).to_sql
```

**Challenge:** Füg in `app/models/peak.rb` zwei Scopes hinzu und probier sie in der Console aus.

<details>
<summary>Lösung</summary>

```ruby
class Peak < ApplicationRecord
  scope :viertausender, -> { where(altitude: 4000..) }
  scope :im_kanton, ->(canton) { where(canton:) }
end

Peak.viertausender.im_kanton("BE").pluck(:name)   # => ["Finsteraarhorn", "Jungfrau", "Mönch"]
```
</details>

---

## Bonus: mit einem AI-Agent

> *„Füge SAC-Hütten hinzu. Eine Hütte gehört zu einem Gipfel. Mit Migration, Model, Test und Anzeige auf der Gipfelseite."*

Achte darauf, wie wenig der Agent suchen muss, um zu wissen, wo was hingehört. Tests laufen mit `bin/rails test`.
