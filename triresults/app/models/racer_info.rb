class RacerInfo
  include Mongoid::Document
  field :racer_id, as: :_id
  field :_id, default:->{ racer_id }
  field :fn, type: String, as: :first_name
  field :ln, type: String, as: :last_name
  field :g, type: String, as: :gender
  field :yr, type: Integer, as: :birth_year
  field :res, type: Address, as: :residence

  embedded_in :parent, polymorphic: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :gender, inclusion: { in: ['M', 'F'], message: "must be M or F" }
  validates :birth_year, presence: true
  validates :birth_year, numericality: { less_than: Time.now.year, message: "must in past"}
end
