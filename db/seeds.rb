ingenieur = Guild.create(name: 'Ingénieur', attack_construction_cost_multiplicator: 0.7, mining_multiplicator: 1.3, revenues_multiplicator: 0.8)
constructeur = Guild.create(name: 'Constructeur', defense_construction_cost_multiplicator: 0.7, mining_multiplicator: 0.7, defense_power_multiplicator: 1.2)
marchand = Guild.create(name: 'Marchand', attack_power_multiplicator: 0.5, defense_power_multiplicator: 0.5, revenues_multiplicator: 3)
mercenaire = Guild.create(name: 'Mercenaire', attack_power_multiplicator: 2.2, defense_power_multiplicator: 1.5, mining_multiplicator: 0.2, revenues_multiplicator: 0)
arbaletrier = Guild.create(name: 'Arbalétrier', defense_power_multiplicator: 1.6)
mineur = Guild.create(name: 'Mineur', mining_multiplicator: 2, defense_power_multiplicator: 0.7)

servants = Troop.create(name: 'Servants', country_name: 'Duché de Bourgogne')
Patrol.create(name: 'Chamois', troop: servants, money: 500, guild: arbaletrier)
Patrol.create(name: 'Puma', troop: servants, money: 500, guild: ingenieur)
Patrol.create(name: 'Antilope', troop: servants, money: 500, guild: constructeur)
Patrol.create(name: 'Faucon', troop: servants, money: 500, guild: marchand)
Patrol.create(name: 'Brocard', troop: servants, money: 500, guild: mercenaire)
Patrol.create(name: 'Daim', troop: servants, money: 500, guild: mineur)
City.create(name: 'Dijon', troop: servants, defense_building_multiplicator: 0)

archers = Troop.create(name: 'Archers', country_name: 'Royaume de Navarre')
Patrol.create(name: 'Dauphin', troop: archers, money: 500, guild: arbaletrier)
Patrol.create(name: 'Panda', troop: archers, money: 500, guild: ingenieur)
Patrol.create(name: 'Harfang', troop: archers, money: 500, guild: constructeur)
Patrol.create(name: 'Hafflinger', troop: archers, money: 500, guild: marchand)
Patrol.create(name: 'Guépard', troop: archers, money: 500, guild: mercenaire)
Patrol.create(name: 'Héron', troop: archers, money: 500, guild: mineur)
City.create(name: 'Pampelone', troop: archers, defense_building_multiplicator: 0)

paladins = Troop.create(name: 'Paladins', country_name: 'Royaume d\'Ecosse')
Patrol.create(name: 'Husky', troop: paladins, money: 500, guild: arbaletrier)
Patrol.create(name: 'Lapin', troop: paladins, money: 500, guild: ingenieur)
Patrol.create(name: 'Hirondelle', troop: paladins, money: 500, guild: constructeur)
Patrol.create(name: 'Auroch', troop: paladins, money: 500, guild: marchand)
Patrol.create(name: 'Alouettes', troop: paladins, money: 500, guild: mercenaire)
Patrol.create(name: 'Jaguar', troop: paladins, money: 500, guild: mineur)
City.create(name: 'Edimbourg', troop: paladins, defense_building_multiplicator: 0)

templiers = Troop.create(name: 'Templiers', country_name: 'Duché de Bretagne')
Patrol.create(name: 'Léopard', troop: templiers, money: 500, guild: arbaletrier)
Patrol.create(name: 'Seagull', troop: templiers, money: 500, guild: ingenieur)
Patrol.create(name: 'Otarie', troop: templiers, money: 500, guild: constructeur)
Patrol.create(name: 'Mangouste', troop: templiers, money: 500, guild: marchand)
Patrol.create(name: 'Gazelle', troop: templiers, money: 500, guild: mercenaire)
Patrol.create(name: 'Furet', troop: templiers, money: 500, guild: mineur)
City.create(name: 'Brest', troop: templiers, defense_building_multiplicator: 0)

preux = Troop.create(name: 'Preux', country_name: 'Royaume de Castille')
Patrol.create(name: 'Ecureuils', troop: preux, money: 500, guild: arbaletrier)
Patrol.create(name: 'Toucan', troop: preux, money: 500, guild: ingenieur)
Patrol.create(name: 'Lézard', troop: preux, money: 500, guild: constructeur)
Patrol.create(name: 'Daguet', troop: preux, money: 500, guild: marchand)
Patrol.create(name: 'Hibou', troop: preux, money: 500, guild: mercenaire)
Patrol.create(name: 'Corbeau', troop: preux, money: 500, guild: mineur)
City.create(name: 'Tolede', troop: preux, defense_building_multiplicator: 0)

vaillants = Troop.create(name: 'Vaillants', country_name: 'Royaume de Bohème')
Patrol.create(name: 'Condor', troop: vaillants, money: 500, guild: arbaletrier)
Patrol.create(name: 'Grizzli', troop: vaillants, money: 500, guild: ingenieur)
Patrol.create(name: 'Lion', troop: vaillants, money: 500, guild: constructeur)
Patrol.create(name: 'Goéland', troop: vaillants, money: 500, guild: marchand)
Patrol.create(name: 'Alezan', troop: vaillants, money: 500, guild: mercenaire)
Patrol.create(name: 'Gerfaut', troop: vaillants, money: 500, guild: mineur)
City.create(name: 'Prague', troop: vaillants, defense_building_multiplicator: 0)

chevaliers = Troop.create(name: 'Chevaliers', country_name: 'Royaume d\'Aragon')
Patrol.create(name: 'Aigle', troop: chevaliers, money: 500, guild: arbaletrier)
Patrol.create(name: 'Renard', troop: chevaliers, money: 500, guild: ingenieur)
Patrol.create(name: 'Cougar', troop: chevaliers, money: 500, guild: constructeur)
Patrol.create(name: 'Courli', troop: chevaliers, money: 500, guild: marchand)
Patrol.create(name: 'Mustang', troop: chevaliers, money: 500, guild: mercenaire)
Patrol.create(name: 'Epervier', troop: chevaliers, money: 500, guild: mineur)
City.create(name: 'Saragosse', troop: chevaliers, defense_building_multiplicator: 0)

hardis = Troop.create(name: 'Hardis', country_name: 'République de Gènes')
Patrol.create(name: 'Castor', troop: hardis, money: 500, guild: arbaletrier)
Patrol.create(name: 'Cigogne', troop: hardis, money: 500, guild: ingenieur)
Patrol.create(name: 'Fouine', troop: hardis, money: 500, guild: constructeur)
Patrol.create(name: 'Loutre', troop: hardis, money: 500, guild: marchand)
Patrol.create(name: 'Ramier', troop: hardis, money: 500, guild: mercenaire)
Patrol.create(name: 'Sanglier', troop: hardis, money: 500, guild: mineur)
City.create(name: 'Genes', troop: hardis, defense_building_multiplicator: 0)

gueux = Troop.create(name: 'Gueux', country_name: 'Comté de Flandres')
Patrol.create(name: 'Cobra', troop: gueux, money: 500, guild: arbaletrier)
Patrol.create(name: 'Coucou', troop: gueux, money: 500, guild: ingenieur)
Patrol.create(name: 'Lynx', troop: gueux, money: 500, guild: constructeur)
Patrol.create(name: 'Loup', troop: gueux, money: 500, guild: marchand)
Patrol.create(name: 'Alcyon', troop: gueux, money: 500, guild: mercenaire)
Patrol.create(name: 'Mouette', troop: gueux, money: 500, guild: mineur)
City.create(name: 'Bruges', troop: gueux, defense_building_multiplicator: 0)

City.create(name: 'Paris', defense_building_multiplicator: 0)

Building.create(name: 'Trébuchet', usage: 'attack', durability: 2, multiplicator: 2, cost: 200)
Building.create(name: 'Bélier', usage: 'attack', durability: 1, multiplicator: 1.5, cost: 50)
Building.create(name: 'Tour de siège', usage: 'attack', durability: 1, multiplicator: 2, cost: 100)
Building.create(name: 'Mur de bois', usage: 'defense', multiplicator: 1.2, cost: 400)
Building.create(name: 'Mur de pierre', usage: 'defense', multiplicator: 1.7, cost: 600)
Building.create(name: 'Muraille', usage: 'defense', multiplicator: 2.6, cost: 800)

User.create!([
               { email: 'archers.lonescouts@gmail.com', password: 'archerslonescouts', password_confirmation: 'archerslonescouts' },
               { email: 'chevaliers.lonescouts@gmail.com', password: 'chevalierslonescouts', password_confirmation: 'chevalierslonescouts' },
               { email: 'gueux.lonescouts@gmail.com', password: 'gueuxlonescouts', password_confirmation: 'gueuxlonescouts' },
               { email: 'paladins.lonescouts@gmail.com', password: 'paladinslonescouts', password_confirmation: 'paladinslonescouts' },
               { email: 'preux.lonescouts@gmail.com', password: 'preuxlonescouts', password_confirmation: 'preuxlonescouts' },
               { email: 'hardis.lonescouts@gmail.com', password: 'hardislonescouts', password_confirmation: 'hardislonescouts' },
               { email: 'servants.lonescouts@gmail.com', password: 'servantslonescouts', password_confirmation: 'servantslonescouts' },
               { email: 'templiers.lonescouts@gmail.com', password: 'templierslonescouts', password_confirmation: 'templierslonescouts' },
               { email: 'vaillants.lonescouts@gmail.com', password: 'vaillantslonescouts', password_confirmation: 'vaillantslonescouts' },
               { email: 'admin@gmail.com', password: 'gillesdg95', password_confirmation: 'gillesdg95' }
             ])

Patrol.all.each { |p| Receipt.create(patrol_id: p.id) }
