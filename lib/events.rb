module Event
  def self.city_plague
    Defense.all.each do |d|
      d.man_power *= 0.7 if d.man_power.positive?
      d.save!
      d.patrol.receipt.update(event: 'Peste dans les villes: -30% hommes en défense')
    end
  end

  def self.campaign_plague
    Attack.all.each do |a|
      a.man_power *= 0.7 if a.man_power.positive?
      a.save!
      a.patrol.receipt.update(event: 'Peste dans les campements: -30% hommes en attaque')
    end
  end

  def self.successfull_trade
    Patrol.all.each do |p|
      p.receipt.update(event: 'Commerce fructueux, +30% de revenu de base')
    end
  end

  def self.fund_raising
    Patrol.all.each do |p|
      p.money += 200
      p.save!
      p.receipt.update(event: 'Levée de fond, +200 or')
    end
  end

  def self.earthquake
    Construction.select(&:defense?).each do |c|
      c.patrol.receipt.update(event: 'Tremblement de terre: Batiments défensif détruits')
      c.destroy!
    end
  end

  def self.fiscal_fraud
    Patrol.all.each do |p|
      p.receipt.update(event: 'Fraude fiscale: pas de revenu de taxe (base)')
    end
  end

  def self.clemency
    Patrol.all.each do |p|
      p.receipt.update(event: 'Clémence et miséricorde: -30% de perte suites aux pillages de villes')
    end
  end

  def self.barbarism
    Patrol.all.each do |p|
      p.receipt.update(event: 'Barbarisme invétéré: +30% des revenus suites aux pillages de villes')
    end
  end

  def self.gas_blast
    Patrol.all.each do |p|
      p.receipt.update(event: 'Coup de grisou: Aucun revenu miniers')
    end
  end
end
