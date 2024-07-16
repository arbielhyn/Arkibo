class Tax < ApplicationRecord
  belongs_to :user, foreign_key: 'province', primary_key: 'province'
end
