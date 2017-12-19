class Group < ActiveRecord::Base
    has_many :usergroups, dependent: :destroy
    has_many :users, through: :usergroups

    validates :name, presence: true, length: { minimum: 6 }
    validates :desc, presence: true, length: { minimum: 11 }
end
