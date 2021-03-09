class Address < ApplicationRecord
  belongs_to :purchaseditem, optional: true
end
