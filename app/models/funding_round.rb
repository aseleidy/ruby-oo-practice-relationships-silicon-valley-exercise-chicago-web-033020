class FundingRound
    attr_reader :startup, :vc, :type, :investment  

    @@all = []

    def initialize(startup, vc, type, investment)
        @startup = startup 
        @vc = vc 
        self.type = type 
        self.investment = investment.to_f
        self.class.all << self 
    end 

    def type=(type)
        if type.class != String 
            raise ArgumentError, "Funding type must be a string."
        else 
            @type = type 
        end 
    end 

    def investment=(investment)
        if investment > 0
            @investment = investment
        else 
            nil  
        end 
    end 

    def self.all 
        @@all 
    end 


end
