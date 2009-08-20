class Array
  def sum
    inject(nil) { |sum, x| sum ? sum + x : x }
  end
  
  def mean 
    sum / size
  end
  
  def gcd
    inject(nil) { |l, n| l ? gcd = l.gcd(n) : n }
  end
  
  def closest(number)
    result = self[0]
    inject(nil) do |memo, x| 
      if memo 
        if (number - x).abs < memo 
          result = x
          (number - x).abs
        else 
          memo 
        end
      else 
        (number - x).abs
      end
    end
    result
  end
end