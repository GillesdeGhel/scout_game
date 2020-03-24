module Event
  def self.city_plague
    Defense.all.each do |d|
      d.man_power *= 0.7 if d.man_power.positive?
      d.save!
    end
    update_receipt('Peste dans les villes: -30% hommes en défense')
  end

  def self.campaign_plague
    Attack.all.each do |a|
      a.man_power *= 0.7 if a.man_power.positive?
      a.save!
    end
    update_receipt('Peste dans les campements: -30% hommes en attaque')
  end

  def self.successfull_trade
    update_receipt('Commerce fructueux, +30% de revenu de base')
  end

  def self.fund_raising
    Patrol.all.each do |p|
      p.money += 200
      p.save!
    end
    update_receipt('Levée de fond, +200 or')
  end

  def self.earthquake
    Construction.select(&:defense?).each do |c|
      c.patrol.receipt.update(event: 'Tremblement de terre: Batiments défensif détruits')
      c.destroy!
    end
  end

  def self.fiscal_fraud
    update_receipt('Fraude fiscale: pas de revenu de taxe (base)')
  end

  def self.clemency
    update_receipt('Clémence et miséricorde: -30% de perte suites aux pillages de villes')
  end

  def self.barbarism
    update_receipt('Barbarisme invétéré: +30% des revenus suites aux pillages de villes')
  end

  def self.gas_blast
    update_receipt('Coup de grisou: Aucun revenu miniers')
  end

  def self.update_receipt(event)
    Patrol.all.each do |p|
      p.receipt.update(event: event)
    end
  end
end
