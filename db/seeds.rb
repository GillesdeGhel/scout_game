ingenieur = Guild.create(
  name: 'Ingénieurs',
  mining_multiplicator: 1,
  revenues_multiplicator: 0.7,
  attack_construction_cost_multiplicator: 0.7,
  defense_construction_cost_multiplicator: 1,
  attack_power_multiplicator: 1.3,
  defense_power_multiplicator: 0.8
)
constructeur = Guild.create(
  name: 'Batisseurs',
  mining_multiplicator: 0.7,
  revenues_multiplicator: 1,
  attack_construction_cost_multiplicator: 1,
  defense_construction_cost_multiplicator: 0.7,
  attack_power_multiplicator: 0.8,
  defense_power_multiplicator: 1.3
)
marchand = Guild.create(
  name: 'Marchands',
  mining_multiplicator: 1.3,
  revenues_multiplicator: 1.5,
  attack_construction_cost_multiplicator: 1,
  defense_construction_cost_multiplicator: 1,
  attack_power_multiplicator: 0.7,
  defense_power_multiplicator: 0.6
)
mercenaire = Guild.create(
  name: 'Soldats',
  mining_multiplicator: 1,
  revenues_multiplicator: 1,
  attack_construction_cost_multiplicator: 1.5,
  defense_construction_cost_multiplicator: 1.5,
  attack_power_multiplicator: 1.5,
  defense_power_multiplicator: 1.2
)
arbaletrier = Guild.create(
  name: 'Arbalétriers',
  mining_multiplicator: 0.7,
  revenues_multiplicator: 0.7,
  attack_construction_cost_multiplicator: 1,
  defense_construction_cost_multiplicator: 1,
  attack_power_multiplicator: 1.2,
  defense_power_multiplicator: 1.5
)
mineur = Guild.create(
  name: 'Mineurs',
  mining_multiplicator: 1.5,
  revenues_multiplicator: 1.3,
  attack_construction_cost_multiplicator: 1.3,
  defense_construction_cost_multiplicator: 1.3,
  attack_power_multiplicator: 1,
  defense_power_multiplicator: 1
)

servants = Troop.create(name: 'Brieuc', country_name: 'Duché de Bourgogne')
# Patrol.create(name: 'Chamois', troop: servants, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Pumas', troop: servants, money: 200, guild: ingenieur)
# Patrol.create(name: 'Antilopes', troop: servants, money: 200, guild: constructeur)
# Patrol.create(name: 'Faucons', troop: servants, money: 200, guild: marchand)
# Patrol.create(name: 'Brocards', troop: servants, money: 200, guild: mercenaire)
# Patrol.create(name: 'Daims', troop: servants, money: 200, guild: mineur)
Patrol.create(name: 'Jean sans Peur', troop: servants, money: 200, guild: arbaletrier)
Patrol.create(name: 'Charles le Téméraire', troop: servants, money: 200, guild: ingenieur)
Patrol.create(name: 'Marie de Bourgogne', troop: servants, money: 200, guild: constructeur)
Patrol.create(name: 'Philippe le Hardi', troop: servants, money: 200, guild: marchand)
Patrol.create(name: 'Pierre le Pieu', troop: servants, money: 200, guild: mercenaire)
Patrol.create(name: 'Robert le Vieu', troop: servants, money: 200, guild: mineur)
City.create(name: 'Dijon', troop: servants, defense_building_multiplicator: 1, population: 1000)

archers = Troop.create(name: 'Gilles', country_name: 'Royaume de Navarre')
Patrol.create(name: 'Philippe le Long', troop: archers, money: 200, guild: arbaletrier)
Patrol.create(name: 'Louis de Navarre', troop: archers, money: 200, guild: ingenieur)
Patrol.create(name: 'Jacques de Grailly', troop: archers, money: 200, guild: constructeur)
Patrol.create(name: 'Robert de Foy', troop: archers, money: 200, guild: marchand)
Patrol.create(name: 'Charles d\'Albret', troop: archers, money: 200, guild: mercenaire)
Patrol.create(name: 'Etienne d\'Ivrée', troop: archers, money: 200, guild: mineur)
City.create(name: 'Pampelune', troop: archers, defense_building_multiplicator: 1, population: 1000)

paladins = Troop.create(name: 'Jerome', country_name: 'Royaume d\'Ecosse')
Patrol.create(name: 'Malcolm McConneghey', troop: paladins, money: 200, guild: arbaletrier)
Patrol.create(name: 'William Wallace', troop: paladins, money: 200, guild: ingenieur)
Patrol.create(name: 'Robert Bruce', troop: paladins, money: 200, guild: constructeur)
Patrol.create(name: 'Edward the Olde', troop: paladins, money: 200, guild: marchand)
Patrol.create(name: 'Kenneth McArthur', troop: paladins, money: 200, guild: mercenaire)
Patrol.create(name: 'Dunclan McClyde', troop: paladins, money: 200, guild: mineur)
City.create(name: 'Edimbourg', troop: paladins, defense_building_multiplicator: 1, population: 1000)

templiers = Troop.create(name: 'Flocky', country_name: 'Duché de Bretagne')
Patrol.create(name: 'Alain Barbetorte', troop: templiers, money: 200, guild: arbaletrier)
Patrol.create(name: 'Anne de Bretagne', troop: templiers, money: 200, guild: ingenieur)
Patrol.create(name: 'Alain Fergent', troop: templiers, money: 200, guild: constructeur)
Patrol.create(name: 'Bernard de Clairvaux', troop: templiers, money: 200, guild: marchand)
Patrol.create(name: 'Pierre de Dreux', troop: templiers, money: 200, guild: mercenaire)
Patrol.create(name: 'Ranulph de Blondeville', troop: templiers, money: 200, guild: mineur)
City.create(name: 'Brest', troop: templiers, defense_building_multiplicator: 1, population: 1000)

# preux = Troop.create(name: 'Preux', country_name: 'Royaume de Castille')
# Patrol.create(name: 'Ecureuils', troop: preux, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Toucans', troop: preux, money: 200, guild: ingenieur)
# Patrol.create(name: 'Lézards', troop: preux, money: 200, guild: constructeur)
# Patrol.create(name: 'Daguets', troop: preux, money: 200, guild: marchand)
# Patrol.create(name: 'Hiboux', troop: preux, money: 200, guild: mercenaire)
# Patrol.create(name: 'Corbeaux', troop: preux, money: 200, guild: mineur)
# City.create(name: 'Tolede', troop: preux, defense_building_multiplicator: 1, population: 1000)

# vaillants = Troop.create(name: 'Vaillants', country_name: 'Royaume de Bohème')
# Patrol.create(name: 'Condors', troop: vaillants, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Grizzlys', troop: vaillants, money: 200, guild: ingenieur)
# Patrol.create(name: 'Lions', troop: vaillants, money: 200, guild: constructeur)
# Patrol.create(name: 'Goélands', troop: vaillants, money: 200, guild: marchand)
# Patrol.create(name: 'Alezans', troop: vaillants, money: 200, guild: mercenaire)
# Patrol.create(name: 'Gerfauts', troop: vaillants, money: 200, guild: mineur)
# City.create(name: 'Prague', troop: vaillants, defense_building_multiplicator: 1, population: 1000)

# chevaliers = Troop.create(name: 'Chevaliers', country_name: 'Royaume d\'Aragon')
# Patrol.create(name: 'Aigles', troop: chevaliers, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Renards', troop: chevaliers, money: 200, guild: ingenieur)
# Patrol.create(name: 'Cougars', troop: chevaliers, money: 200, guild: constructeur)
# Patrol.create(name: 'Courlis', troop: chevaliers, money: 200, guild: marchand)
# Patrol.create(name: 'Mustangs', troop: chevaliers, money: 200, guild: mercenaire)
# Patrol.create(name: 'Eperviers', troop: chevaliers, money: 200, guild: mineur)
# City.create(name: 'Saragosse', troop: chevaliers, defense_building_multiplicator: 1, population: 1000)

# hardis = Troop.create(name: 'Hardis', country_name: 'République de Gènes')
# Patrol.create(name: 'Castors', troop: hardis, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Cigognes', troop: hardis, money: 200, guild: ingenieur)
# Patrol.create(name: 'Fouines', troop: hardis, money: 200, guild: constructeur)
# Patrol.create(name: 'Loutres', troop: hardis, money: 200, guild: marchand)
# Patrol.create(name: 'Ramiers', troop: hardis, money: 200, guild: mercenaire)
# Patrol.create(name: 'Sangliers', troop: hardis, money: 200, guild: mineur)
# City.create(name: 'Genes', troop: hardis, defense_building_multiplicator: 1, population: 1000)

# gueux = Troop.create(name: 'Gueux', country_name: 'Comté de Flandres')
# Patrol.create(name: 'Cobras', troop: gueux, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Coucous', troop: gueux, money: 200, guild: ingenieur)
# Patrol.create(name: 'Lynx', troop: gueux, money: 200, guild: constructeur)
# Patrol.create(name: 'Loups', troop: gueux, money: 200, guild: marchand)
# Patrol.create(name: 'Alcyons', troop: gueux, money: 200, guild: mercenaire)
# Patrol.create(name: 'Mouettes', troop: gueux, money: 200, guild: mineur)
# City.create(name: 'Bruges', troop: gueux, defense_building_multiplicator: 1, population: 1000)

# lanciers = Troop.create(name: 'Lanciers', country_name: 'Duché de Luxembourg')
# Patrol.create(name: 'Barasinghas', troop: lanciers, money: 200, guild: arbaletrier)
# Patrol.create(name: 'Chousinghas', troop: lanciers, money: 200, guild: ingenieur)
# Patrol.create(name: 'Koalas', troop: lanciers, money: 200, guild: constructeur)
# Patrol.create(name: 'Monax', troop: lanciers, money: 200, guild: marchand)
# Patrol.create(name: 'Salukis', troop: lanciers, money: 200, guild: mercenaire)
# Patrol.create(name: 'Servals', troop: lanciers, money: 200, guild: mineur)
# City.create(name: 'Luxembourg', troop: lanciers, defense_building_multiplicator: 1, population: 1000)

City.create(name: 'Paris', defense_building_multiplicator: 1, population: 1000)

Building.create(name: 'Trébuchet', usage: 'attack', durability: 5, multiplicator: 0.2, cost: 200)
Building.create(name: 'Bélier', usage: 'attack', durability: 4, multiplicator: 0.1, cost: 125)
Building.create(name: 'Tour de siège', usage: 'attack', durability: 2, multiplicator: 0.3, cost: 300)

Building.create(name: 'Tour de guet', usage: 'defense', durability: 8, multiplicator: 0.1, cost: 300)
Building.create(name: 'Baliste', usage: 'defense', durability: 5, multiplicator: 0.15, cost: 150)
Building.create(name: 'Huile bouillante', usage: 'defense', durability: 2, multiplicator: 0.25, cost: 200)

Building.create(name: 'Mur de bois', usage: 'fortification', multiplicator: 1, cost: 200)
Building.create(name: 'Mur de pierre', usage: 'fortification', multiplicator: 2, cost: 400)
Building.create(name: 'Muraille', usage: 'fortification', multiplicator: 3, cost: 800)

Building.create(name: 'Chapelle', usage: 'religious', multiplicator: 0.2, cost: 200)
Building.create(name: 'Eglise', usage: 'religious', multiplicator: 0.4, cost: 400)
Building.create(name: 'Cathédrale', usage: 'religious', multiplicator: 0.6, cost: 800)

Building.create(name: 'Chateau', usage: 'development', multiplicator: 1, cost: 200)
Building.create(name: 'Forteresse', usage: 'development', multiplicator: 3, cost: 400)
Building.create(name: 'Citadelle', usage: 'development', multiplicator: 5, cost: 800)

User.create!([
               { email: 'archers.lonescouts@gmail.com', password: 'archerslonescouts', password_confirmation: 'archerslonescouts', troop: archers },
              #  { email: 'chevaliers.lonescouts@gmail.com', password: 'chevalierslonescouts', password_confirmation: 'chevalierslonescouts', troop: chevaliers },
              #  { email: 'gueux.lonescouts@gmail.com', password: 'gueuxlonescouts', password_confirmation: 'gueuxlonescouts', troop: gueux },
               { email: 'paladins.lonescouts@gmail.com', password: 'paladinslonescouts', password_confirmation: 'paladinslonescouts', troop: paladins },
              #  { email: 'preux.lonescouts@gmail.com', password: 'preuxlonescouts', password_confirmation: 'preuxlonescouts', troop: preux },
              #  { email: 'hardis.lonescouts@gmail.com', password: 'hardislonescouts', password_confirmation: 'hardislonescouts', troop: hardis },
               { email: 'servants.lonescouts@gmail.com', password: 'servantslonescouts', password_confirmation: 'servantslonescouts', troop: servants },
               { email: 'templiers.lonescouts@gmail.com', password: 'templierslonescouts', password_confirmation: 'templierslonescouts', troop: templiers },
              #  { email: 'vaillants.lonescouts@gmail.com', password: 'vaillantslonescouts', password_confirmation: 'vaillantslonescouts', troop: vaillants },
              #  { email: 'lanciers.lonescouts@gmail.com', password: 'lancierslonescouts', password_confirmation: 'lancierslonescouts', troop: lanciers },
               { email: 'admin@gmail.com', password: 'gillesdg95', password_confirmation: 'gillesdg95' }
             ])

Patrol.all.each { |p| Receipt.create(patrol_id: p.id) }
