# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# SEED REGION TABLE
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'regions.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   r = Region.new
#   r.id = row['id']
#   r.name = row['name']
#   r.display_region_id = row['display_region_id']
#   row['is_master_region'].nil? ? r.is_master_region = false : r.is_master_region = true
#   r.display_priority = row['display_priority']
#   r.save
#   puts "#{r.name} saved to region table"
# end

# puts "There are now #{Region.count} rows in the Regions table"

# FIX COLUMN IDs

# (2..236).each do |i|
#   Territory.where(id: i).update_all(id: i - 1)
# end

# SEED TERRITORY TABLE

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'territories.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   next if Territory.where(name: row['name']).exists?
#   t = Territory.new
#   t.name = row['name']
#   t.weekend_start = row['weekend_start']
#   t.region_id = row['region_id']
#   t.default_currency = row['default_currency']
#   t.continent_id = row['continent_id']
#   t.is_displayed.nil? ? t.is_displayed = false : t.is_displayed = true
#   t.save!
#   puts "#{t.name} saved to territories table"
# end
# puts "#{Territory.count} rows saved to database"

# SEED FILMS & DIRECTORS

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'films.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   next if Film.where(title: row['title']).exists?
#   f = Film.new
#   f.title = row['title']
#   f.save
#   puts "#{f.title} saved"
# end

# puts "#{Film.count} records in the film database"

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'films.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   next if Person.where(first_name: row['first'], last_name: row['last']).exists?
#   p = Person.new
#   p.first_name = row['first']
#   p.last_name = row['last']
#   p.save
#   puts "#{p.first_name} #{p.last_name} saved"
# end

# puts "#{Person.count} records in the person database"

# DIRECTOR_FILM SEED

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'films.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   did = Person.find_by(first_name: row['first'], last_name: row['last']).id
#   fid = Film.find_by(title: row['title']).id
#   next if DirectorFilm.where(director_id: did, film_id: fid ).exists?
#   df = DirectorFilm.new
#   df.director_id = did
#   df.film_id = fid
#   df.save
#   puts "director-film saved"
# end

# puts "#{DirectorFilm.count} records in the database"

# ADD DISTRIBUTORS
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'distributors.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   next if Distributor.where(name: row['dist']).exists?
#   d = Distributor.new
#   d.name = row['dist']
#   d.save
#   puts "#{d.name} added to database"

# end

# puts "#{Distributor.count} records in the database"

# ADD DISTRIBUTED TERRITORIES
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'dts.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   p row['title']
#   p row['dist']
#   p row['terr']
#   fid = Film.find_by(title: row['title']).id
#   did = Distributor.find_by(name: row['dist']).id
#   tid = Territory.find_by(name: row['terr']).id

#   next if DistributedTerritory.where(film_id: fid, distributor_id: did, territory_id: tid).exists?
#   dt = DistributedTerritory.new
#   dt.film_id = fid
#   dt.distributor_id = did
#   dt.territory_id = tid
#   dt.save

# end

# puts "#{DistributedTerritory.count} records in the database"

# ADD GROSS BOXES
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'dts.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   fid = Film.find_by(title: row['title']).id
#   did = Distributor.find_by(name: row['dist']).id
#   tid = Territory.find_by(name: row['terr']).id
#   dt_id = DistributedTerritory.find_by(film_id: fid, distributor_id: did, territory_id: tid).id
#   next if GrossBox.where(distributed_territory_id: dt_id).exists?
#   cume_bo = row['cume_bo'].to_i
#   cume_adm = row['cume_adm'].to_i
#   next if !( cume_bo > 0 || cume_adm > 0 )
#   gb = GrossBox.new
#   gb.distributed_territory_id = dt_id
#   gb.local_currency_cents = cume_bo
#   gb.admissions = cume_adm
#   gb.currency = row['currency']
#   row['ended'] == "Complete" ? gb.is_ended = true : gb.is_ended = false
#   gb.save
#   puts "BOX RECORD SAVED"
# end

# puts "#{GrossBox.count} records in the database"

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'dts.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   fid = Film.find_by(title: row['title']).id
#   did = Distributor.find_by(name: row['dist']).id
#   tid = Territory.find_by(name: row['terr']).id
#   dt_id = DistributedTerritory.find_by(film_id: fid, distributor_id: did, territory_id: tid).id
#   next if row['w_cume'] == 0 || PeriodBox.where(distributed_territory_id: dt_id, sequence: 10).exists? #update
#   pb = PeriodBox.new
#   pb.distributed_territory_id = dt_id
#   pb.sequence = 10 #update
#   pb.start_date = row['start_10'] #update
#   pb.end_date = row['end_10'] #update
#   pb.currency = row['currency']
#   pb.local_currency_cents = row['w_cume']
#   pb.admissions = row['w_adm']
#   pb.screen_count = row['w_screen']
#   pb.rank = row['rank']
#   pb.period_type = 'Weekend'

#   pb.save

#   puts 'PB Added to PB DB'
# end

# puts "#{PeriodBox.count} rows in PB Database"

# SEED RELEASE DATES
# def is_date?(i)
#   i.to_i > 0
# end
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'dts.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   fid = Film.find_by(title: row['title']).id
#   did = Distributor.find_by(name: row['dist']).id
#   tid = Territory.find_by(name: row['terr']).id
#   release_format = "Theatrical"
#   dt_id = DistributedTerritory.find_by(film_id: fid, distributor_id: did, territory_id: tid).id
#   next if ReleaseDate.where(distributed_territory_id: dt_id, release_format: release_format).exists? 
#   rd = ReleaseDate.new
#   rd.distributed_territory_id = dt_id
#   rd.date = row['date'] if is_date?(row['date'])
#   rd.context = row['date'] if !is_date?(row['date'])
#   rd.release_format = "Theatrical"
  
#   rd.save

#   puts 'RD Added to RD DB'
# end

# puts "#{ReleaseDate.count} rows in RD Database"

