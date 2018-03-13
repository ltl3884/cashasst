class Task < ActiveRecord::Base
	belongs_to :account
	enum status: {停止: 0, 运行: 1}
	has_many :policies, :dependent => :destroy
	scope :running, -> { where(:status => Task.statuses['运行']).order("id") }
end
