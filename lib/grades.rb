class Grading
  def self.microtrends array
    result = []
    array[1..-1].each_with_index do |grade, index|
      if grade > array[index]
        result << :up
      elsif grade < array[index]
        result << :down
      else
        result << :even
      end
    end
    result
  end

  def self.macrotrends array
    microtrends = Grading.microtrends array
    if Grading.in_decline? microtrends
      return "in decline"
    else
      return "not in decline"
    end
  end

  def self.in_decline? array
    quantification_of_decline = array.select{|a| a == :down}
    any_up = array.include? :up
    if any_up
      return false
    elsif quantification_of_decline.length >= 3
      return true
    end
  end
end


grades = Grading.macrotrends([6,3,5,4,3,4,4,5])
p grades
grades = Grading.macrotrends([10, 9, 8, 7])
p grades
