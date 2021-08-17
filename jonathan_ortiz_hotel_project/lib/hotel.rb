require_relative "room"

class Hotel
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each_key do |room|
            @rooms[room] = Room.new(rooms[room])
        end
    end

    attr_reader :rooms

    def name
        result = []
        @name.split(" ").each do |word|
            result << word.capitalize
        end
        return result.join(" ")
    end

    def room_exists?(room_name)
        if @rooms.has_key?(room_name)
            return true
        else
            return false
        end
    end

    def check_in(person, room_name)
        if !self.room_exists?(room_name)
            puts "sorry, room does not exist"
        else
            if @rooms[room_name].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end

    def has_vacancy?
        vacancy = false
        @rooms.each_key do |room_name|
            vacancy = true if @rooms[room_name].capacity > @rooms[room_name].occupants.length
        end
        return vacancy
    end

    def list_rooms
        @rooms.each_pair do |room_name, room|
            puts room_name + ". " + room.available_space.to_s
        end
    end
end
