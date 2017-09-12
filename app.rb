#!/usr/bin/env ruby

require 'pp'

availabilities = [
   { start_date: 1, end_date: 30, beds: 1 },
   { start_date: 1, end_date: 45, beds: 2 },
   { start_date: 10, end_date: 30, beds: 2 },
   { start_date: 20, end_date: 45, beds: 3 },
   { start_date: 1, end_date: 45, beds: 3 },
]

books = [
  { start_date: 5, end_date: 15, beds: 1 },
  { start_date: 20, end_date: 30, beds: 2 }
]

def get_rooms_with_certain_number_of_beds(availabilities, number_of_beds)
  result = []
  availabilities.each do |availability|
    result << availability if availability[:beds] == number_of_beds
  end
  result
end

def check_if_available(room, start_date, end_date)
  return true if room[:start_date] <= start_date && room[:end_date] >= end_date
  return false
end

def reserve_room(availabilities, book, slot)
  availabilities.delete(slot)
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
  availabilities << availability_1
  availabilities << availability_2
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



