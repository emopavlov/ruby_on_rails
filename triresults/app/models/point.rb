class Point
  include Mongoid::Document
  field :longitude, type: Float
  field :latitude, type: Float

  attr_accessor :longitude, :latitude

  def initialize(latitude, longitude)
    @longitude = longitude
    @latitude = latitude
  end

  def mongoize
    {:type => 'Point', :coordinates => [@longitude, @latitude] }
  end

  def self.mongoize object
    case object
    when nil then nil
    when Hash then object
    when Point then object.mongoize
    end
  end

  def self.demongoize object
    case object
    when nil then nil
    when Hash then Point.new(object[:coordinates][1], object[:coordinates][0])
    when Point then object
    end
  end

  def self.evolve object
    mongoize object
  end
end
