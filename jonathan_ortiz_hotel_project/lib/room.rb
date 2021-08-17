class Room
    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end

    attr_reader :capacity, :occupants

    def full?
        if @occupants.length >= @capacity
            return true
        else
            return false
        end
    end

    def available_space
        return @capacity - @occupants.length
    end

    def add_occupant(name)
        if !self.full?
            @occupants << name
            return true
        else
            return false
        end
    end
end
