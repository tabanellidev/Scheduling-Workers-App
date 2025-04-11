class Cleaner < ApplicationRecord

  validates :internaln, presence: true, uniqueness: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :residence, presence: true
  validates :codfis, presence: true
  validates :license, presence: true
  validates :birthdate, presence: true
  validates :hired, presence: true
  validates :hours_required, presence: true

  has_many :jobs

  private
    def self.internaln_to_id(internaln) 

      cleaner = Cleaner.where('internaln = ?', internaln).first
      
      if cleaner.nil?
        return nil
      else
        return cleaner.id
      end

    end

    def self.id_to_internaln(id) 

      cleaner = Cleaner.find(id)

      return cleaner.internaln

    end

end
