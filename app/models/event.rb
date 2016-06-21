class Event < ActiveRecord::Base
  validates_presence_of :name
  #validates :name, presence: true
  #這是新版Document裡提供的寫法

  has_many :attendees, :dependent => :destroy
  belongs_to :category

  delegate :name, :to => :category, :prefix => true, :allow_nil => true

  has_many :event_groupships, :dependent => :destroy
  has_many :groups, :through => :event_groupships, :dependent => :destroy

  has_one :location, :dependent => :destroy

  belongs_to :user

  accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank
end
