class Card
  attr_reader :value
  def initialize(value)
    @face_down = true
    @value = value
  end

  def hide
    @face_down = true
  end

  def reveal
    @face_down = false
  end

  def revealed?
    !@face_down
  end

  def to_s
    revealed? ? @value : ' '
  end

  def ==(other)
    @value == other.value
  end
end
