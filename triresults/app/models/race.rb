class Race
  include Mongoid::Document
  include Mongoid::Timestamps

  field :n, as: :name, type: String
  field :date, type: Date
  field :loc, as: :location, type: Address

  embeds_many :events, class_name: 'Event', order: [:order.asc]

  scope :upcoming, ->{ where(:date.gte => Date.today) }
  scope :past, ->{ where(:date.lt => Date.today) }
end
