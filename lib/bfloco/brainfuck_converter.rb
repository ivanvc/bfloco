class BrainfuckConverter
  
  def self.convert(quote)
    return unless quote
    original_string = []
    quote.size.times { |i| original_string << quote[i] }
    the_numbers = original_string.sort.uniq

    max = the_numbers.max
    min = the_numbers.min
    mean = the_numbers.mean
    base_number = max-mean > mean-min ? mean-min : max-mean
    looped_numbers = []
    begin
      looped_numbers = []
      i = 0
      the_numbers.each do |v|
        if i==0 || v > the_numbers[i-1] + base_number
          looped_numbers << v
        end
        i += 1
      end
      base_number -= 1
    end while looped_numbers.size.to_f/the_numbers.size<0.25
    gcd = get_gcd(looped_numbers)
    if gcd <= 3 || looped_numbers.map { |n| n/gcd }.max >= 20
      gcd = looped_numbers.gcd
      gcd = 10 if gcd <= 3 || looped_numbers.map { |n| n/gcd }.max >= 20
    end
    result = ""
    gcd.times {|x| result << "+"}
    result << "["
    cells = [0]
    looped_numbers.each do |num|
      result << ">"
      (num/gcd).times { |x| result << "+" }
      cells << num/gcd*gcd
    end
    looped_numbers.size.times { |x| result << "<" }
    result << "-]"
    position = 0

    original_string.each do |char|
      number_to_reach = (cells - [0]).closest(char)
      if position > cells.index(number_to_reach)
        until number_to_reach == cells[position]
          position -= 1
          result << "<"
        end
      else
        until number_to_reach == cells[position]
          position += 1
          result << ">" 
        end
      end
      char_to_add = char - number_to_reach > 0 ? "+" : "-"
      (char - number_to_reach).abs.times do |x| 
        cells[position] = eval("cells[position] #{char_to_add} 1")
        result << char_to_add 
      end
      result << "."
    end 
    result
  end

  def self.get_gcd(array)
    mean = array.mean
    tolerance = array.map { |n| (n - mean).abs }.mean
    tolerance = (tolerance*0.20).to_i
    array.inject(nil) do |l, n| 
      if l 
        gcd = l.gcd(n)
        return gcd unless gcd == 1
        ((n-tolerance)..(n+tolerance)).each do |number| 
          new_gcd = l.gcd(number)
          unless new_gcd == 1 
            gcd = new_gcd
            break
          end
        end if gcd == 1
        gcd
      else
        n
      end
    end
  end

end