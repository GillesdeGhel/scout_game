module Event
  def self.city_plague
    Defense.all.each do |d|
      d.manpower -= 10 if d.manpower.positive?
      d.save!
      d.patrol.receipt.update(event: 'Peste dans les villes: -10 hommes en défense')
    end
  end

  def self.campaign_plague
    Attack.all.each do |a|
      a.manpower -= 10 if a.manpower.positive?
      a.save!
      a.patrol.receipt.update(event: 'Peste dans les campements: -10 hommes en attaque')
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
    City.all.each do |c|
      c.defense_building_multiplicator = (c.defense_building_multiplicator / 2).round(2)
      c.save!
      next if c.paris?

      c.troop.patrols.each do |p|
        p.receipt.update(event: 'Tremblement de terre: Défenses des villes réduites de moitié')
      end
    end
  end

  def self.fiscal_fraud
    Patrol.all.each do |p|
      p.receipt.update(event: 'Fraude fiscale: pas de revenu de taxe (base)')
    end
  end
end
