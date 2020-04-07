require 'pry'

class Startup
    attr_accessor :name
    attr_reader :founder, :domain

    @@all = []
    
    def initialize(name, founder, domain)
        @name = name
        @founder = founder 
        @domain = domain
        self.class.all << self 
    end

    def pivot(name, domain) 
        self.name = name 
        self.domain = domain
    end

    def self.all 
        @@all 
    end 

    def self.find_by_founder(founder) 
        self.all.find do |startup|
            startup.founder == founder 
        end 
    end 

    def self.domains 
        domains = self.all.map do |startup|
            startup.domain
        end   
        domains.uniq
    end 
    
    def sign_contract(vc, type, investment) 
        FundingRound.new(self, vc, type, investment)
    end 

    def funding_rounds
        FundingRound.all.select do |rounds|
            rounds.startup == self 
        end
    end 

    def num_funding_rounds 
        # FundingRound.all.count do |rounds|
        #     rounds.startup == self 
        # end
        funding_rounds.count   
    end 

    def total_funds 
        self.funding_rounds.reduce(0) do |sum, round|
            sum + round.investment 
        end 
    end 

    def investors
        self.funding_rounds.map do |round|
            round.vc
        end 
    end 

    def big_investors
        # self.funding_rounds.map do |round|
        #     if round.vc.tres_commas_club
        #         round.vc 
        #     end  
        # end

        self.investors.select do |investor|
            VentureCapitalist.tres_commas_club.include?(investor)
        end 
    end 

    private

    attr_writer :domain

end
