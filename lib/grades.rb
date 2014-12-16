require 'json'

class Grades
  def initialize grades
    @grades = grades
  end

  def microtrends
    result = []
    @grades[1..-1].each_with_index do |grade, index|
      if grade > @grades[index]
        result << :up
      elsif grade < @grades[index]
        result << :down
      else
        result << :even
      end
    end
    result
  end

  def macrotrends
    microtrends = self.microtrends
    if in_decline? microtrends
      return "in decline"
    else
      return "not in decline"
    end
  end

  def in_decline? microtrends_array
    ups_and_downs = microtrends_array.delete_if{|microtrend| microtrend == :even}
    if ups_and_downs[-3..-1].include? :up
      return false
    else
      return true
    end
  end
end


json = File.read("../data/grades.json")
grades = JSON.parse(json)

in_decline = 0
not_in_decline = 0

grades.each do |k,v|
  if Grades.new(v).macrotrends == "in decline"
    in_decline += 1
  elsif Grades.new(v).macrotrends == "not in decline"
    not_in_decline += 1
  end
end

grades.each do |k,v|
  p Grades.new(v).macrotrends
end

p in_decline
p not_in_decline
