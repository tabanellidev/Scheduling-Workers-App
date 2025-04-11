class RepeatableJob < ApplicationRecord

  validates :day, presence: true
  validates :hour, presence: true
  validates :duration, presence: true

  validates :cleaner_id, presence: true
  validates :site_id, presence: true

  belongs_to :cleaner
  belongs_to :site

  enum :day, {Lunedì: 1, Martedì: 2, Mercoledì: 3, Giovedì: 4, Venerdì: 5}

  private
    
    def self.already_exist?(rpj)

      index = RepeatableJob.days[rpj.day]
      times = rpj.hour.split(':')
      now = DateTime.now()
      start_date = now.beginning_of_week(:monday)
      target = start_date + index.days - 1.days + times[0].to_i.hours + times[1].to_i.minutes

      target_string = target.strftime('%d-%m-%Y %H:%M')

      temp = Job.where(date: target_string, site_id: rpj.site_id, cleaner_id: rpj.cleaner_id)

      if temp.count == 0
        return false, target_string
      else
        return true, target_string
      end

    end

    def self.month_bounds(date)

      
      return date.beginning_of_month, date.end_of_month


    end

end
