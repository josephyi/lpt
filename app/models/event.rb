class Event < ActiveRecord::Base

  VALID_TYPES = [
    'Performance'
  ]

  validates :event_type, inclusion: { in: VALID_TYPES }

end
