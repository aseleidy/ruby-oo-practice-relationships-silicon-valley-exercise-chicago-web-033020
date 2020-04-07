class VentureCapitalist
    attr_accessor :name
    attr_reader :total_worth 

    @@all = []

    def initialize(name, total_worth)
        @name = name
        @total_worth = total_worth.to_i
        self.class.all << self 
    end  

    def self.all 
        @@all 
    end 

    def tres_commas_club 
        if self.total_worth > 1000000000
            return true 
        else 
            return false 
        end 
    end 

    def self.tres_commas_club 
        self.all.select do |vc|
            vc.total_worth > 1000000000
        end 
    end 

    def offer_contract(startup, type, investment) 
        FundingRound.new(startup, self, type, investment)
    end 

    def funding_rounds 
        FundingRound.all.select do |round|
            round.vc == self 
        end 
    end 

    def portfolio 
        startups = self.funding_rounds.collect do |round|
            round.startup 
        end 
        startups.uniq
    end 

    def biggest_investment
        funding_rounds.max do |round_a, round_b|
            round_a.investment <=> round_b.investment
        end 
    end 

    def invested(domain)
        domain_rounds = self.funding_rounds.select do |round|
            round.startup.domain == domain 
        end  

        domain_rounds.reduce(0) do |sum, round|
            sum + round.investment
        end 
    end 
end
