class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String

  embedded_in :parent, polymorphic: true, touch: true

  validates :order, presence: true
  validates :name, presence: true

  def meters
    case u 
    when "meters" then d
    when "miles" then d * 1609.34
    when "kilometers" then d * 1000
    when "yards" then d * 0.9144
    else
      nil
    end
  end
  
  def miles
    case u 
    when "meters" then d * 0.000621371
    when "miles" then d
    when "kilometers" then d * 0.621371
    when "yards" then d * 0.000568182
    else
      nil
    end
  end
end
