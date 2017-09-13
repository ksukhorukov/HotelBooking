#!/usr/bin/env ruby

require 'date'

require 'pp'

availabilities = [
   { start_date: (Date.parse '01.01.2017'), end_date: (Date.parse '30.01.2017'), beds: 1 },
]

books = [
  { start_date: (Date.parse '01.01.2017'), end_date: (Date.parse '15.01.2017'), beds: 1 },
  { start_date: (Date.parse '16.01.2017'), end_date: (Date.parse '30.01.2017'), beds: 1 }
]

def get_rooms_with_certain_number_of_beds(availabilities, number_of_beds)
  availabilities.select { |avlb| avlb[:beds] == number_of_beds }
end

def check_if_available(room, start_date, end_date)
  room[:start_date] <= start_date && (room[:end_date] >= end_date || room[:end_date] == nil)
end

def reserve_room(availabilities, book, slot)

  availabilities.delete(slot)
  availability_1 = {}
  availability_2 = {}

  return availabilities if slot[:start_date] == book[:start_date] && slot[:end_date] == book[:end_date]

  availability_1 = {
    start_date: slot[:start_date],
    end_date: book[:start_date],
    beds: slot[:beds]
  }
  availability_2 = {
    start_date: book[:end_date],
    end_date: slot[:end_date],
    beds: slot[:beds]
  }

  if slot[:end_date] == book[:end_date]
    availabilities << availability_1
  elsif slot[:start_date] == book[:start_date]
    availabilities << availability_2
  end

  availabilities

end

books.each do |book|
  slot = get_rooms_with_certain_number_of_beds(availabilities, book[:beds]).first
  unless slot.empty?
    if check_if_available(slot, book[:start_date], book[:end_date])
      availabilities = reserve_room(availabilities, book, slot)
    end
  end
end

pp availabilities



