class Fixnum
  def gcd(other)
    min = self.abs
    max = other.abs
    while min > 0
      tmp = min
      min = max % min
      max = tmp
    end
    max
  end
end
