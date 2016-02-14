class Address
  include Mongoid::Document
  field :city, type: String
  field :state, type: String
  field :loc, type: Point, as: :location

  attr_accessor :city, :state, :location

  def initialize(city, state, location)
    @city = city
    @state = state
    @location = location
  end

  def mongoize
    location = @location.nil? ? nil : @location.mongoize
    {:city => @city, :state => @state, :loc => location }
  end

  def self.mongoize object
    case object
    when nil then nil
    when Hash then object
    when Address then object.mongoize
    end
  end

  def self.demongoize object
    case object
    when nil then nil
    when Hash then Address.new(object[:city], object[:state], Point.demongoize(object[:loc]))
    when Address then object
    end
  end

  def self.evolve object
    mongoize object
  end
end
