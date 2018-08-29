class Share < ApplicationRecord
  belongs_to :collection
  belongs_to :network
end
