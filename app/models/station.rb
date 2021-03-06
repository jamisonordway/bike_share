class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged]
  has_many :start_stations, class_name: "Trip", foreign_key: "start_station_id"
  has_many :end_stations, class_name: "Trip", foreign_key: "end_station_id"
  validates :name, presence: true, uniqueness: true
  validates_presence_of :dock_count, :city, :installation_date

  def self.sort_by_id
    all.order(:id)
  end

  def sum_starting_trips
    start_stations.length
  end

  def sum_ending_trips
    end_stations.length
  end

  # Ask about returning an object from the query.
  def frequent_destination_station
    start_stations.group(:end_station_id).order("count_all desc").count.first
  end

  def frequent_origination_station
    end_stations.group(:start_station_id).order("count_all DESC").count.first
  end

  def date_with_most_trip_starts
    start_stations.group(:start_date).order("count_all DESC").count.first[0]
  end

  def most_freq_zip_codes
    start_stations.group(:zip_code).order("count_all DESC").count.first[0]
  end

  def most_freq_bike_id
    start_stations.group(:bike_id).order("count_all DESC").count.first[0]
  end

  def self.oldest_station
    order("installation_date ASC").first
  end

  def self.newest_station
    order("installation_date DESC").first
  end

  def self.most_bikes
    order("dock_count DESC").first
  end

  def self.least_bikes
    order("dock_count ASC").first
  end

  def self.average_bikes
    average(:dock_count).round
  end
end
