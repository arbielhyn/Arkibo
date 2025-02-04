# app/models/page.rb
class Page < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[id title content created_at updated_at slug] # Adjust as per your actual attributes
  end

  def self.ransackable_associations(auth_object = nil)
    [] # Add associations that you want to be searchable by Ransack
    # For example, if you have associations like :categories, :tags, etc.,
    # you would add them to the array.
  end
end
