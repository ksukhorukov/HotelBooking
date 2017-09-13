#!/usr/bin/env ruby

require 'date'
require 'pp'

availabilities = [
   { start_date: (Date.parse '01.01.2017'), end_date: (Date.parse '30.01.2017'), beds: 1 },
]

books = [
  { start_date: (Date.parse '01.01.2017'), end_date: (Date.parse '30.01.2017'), beds: 1 },
  { start_date: (Date.parse '02.01.2017'), end_date: (Date.parse '15.01.2017'), beds: 1 },
  { start_date: (Date.parse '16.01.2017'), end_date: (Date.parse '20.01.2017'), beds: 1 }
]

def get_available_slot(availabilities, book)
  availabilities
    .select { |avlb| avlb[:beds] == book[:beds] }
    .find { |avlb| is_available?(avlb, book) }
end

def is_available?(room, book)
  room[:start_date] <= book[:start_date] && (room[:end_date] >= book[:end_date] || room[:end_date] == nil)
end

def reserve_room(book, slot)
  intersaction = (slot[:start_date]..slot[:end_date]).to_a &
    (book[:start_date]..book[:end_date]).to_a

  [
    [slot[:start_date], intersaction.first],
    [intersaction.last, slot[:end_date]]
  ].reject { |range| range[0] == range[1] }
   .map { |range| { start_date: range[0], end_date: range[1], beds: slot[:beds] } }
end

books.each do |book|
  slot = get_available_slot(availabilities, book)
  next if slot.nil?

  slots = reserve_room(book, slot)
  availabilities.delete(slot)
  availabilities = availabilities.concat(slots)
end

pp availabilities
