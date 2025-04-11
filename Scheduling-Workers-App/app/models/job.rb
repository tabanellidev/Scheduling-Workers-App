class Job < ApplicationRecord

    validates :date, presence: true
    validates :duration, presence: true, numericality: {greater_than: 0}
    validates :cleaner_id, presence: true
    validates :site_id, presence: true

    belongs_to :cleaner
    belongs_to :site

    
    def job_collegues

        job_collegues = Job.where(date: self.date, site_id: self.site_id).where.not(cleaner_id: self.cleaner_id)

        return job_collegues

    end

    def self.create_all(jobs)

      notice = 1

      transaction do
          jobs.each do |job| 
            job_temp = Job.new(job)
            if not job_temp.save
              notice = job_temp
              raise ActiveRecord::Rollback
            end
          end
      end

      return notice
    end


    def invalid_min?

      min = self.date.strftime("%M")

      puts('--> ', min)

      if min == '00' or min == '15' or min == '30' or min == '45' 
        return false
      end
        
      return true

    end

end
