class Event < ActiveRecord::Base
  validates_presence_of :name
  #validates :name, presence: true
  #這是新版Document裡提供的寫法

  has_many :attendees
end
