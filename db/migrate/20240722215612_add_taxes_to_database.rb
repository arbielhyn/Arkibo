class AddTaxesToDatabase < ActiveRecord::Migration[6.1]
  def up
    Tax.create(province: "Alberta", pst: 0, gst: 5.0, hst: 0)
    Tax.create(province: "British Columbia", pst: 7.0, gst: 5.0, hst: 0)
    Tax.create(province: "Manitoba", pst: 7.0, gst: 5.0, hst: 0)
    Tax.create(province: "New Brunswick", pst: 10.0, gst: 5.0, hst: 0)
    Tax.create(province: "Newfoundland and Labrador", pst: 10.0, gst: 5.0, hst: 0)
    Tax.create(province: "Northwest Territories", pst: 5.0, gst: 5.0, hst: 0)
    Tax.create(province: "Nova Scotia", pst: 10.0, gst: 5.0, hst: 0)
    Tax.create(province: "Nunavut", pst: 5.0, gst: 5.0, hst: 0)
    Tax.create(province: "Ontario", pst: 0, gst: 0, hst: 13.0)
    Tax.create(province: "Prince Edward Island", pst: 10.0, gst: 5.0, hst: 0)
    Tax.create(province: "Quebec", pst: 9.975, gst: 5.0, hst: 0)
    Tax.create(province: "Saskatchewan", pst: 6.0, gst: 5.0, hst: 0)
    Tax.create(province: "Yukon", pst: 0, gst: 5.0, hst: 0)
  end

  def down
    Tax.where(province: ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador",
                         "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island",
                         "Quebec", "Saskatchewan", "Yukon"]).delete_all
  end
end
