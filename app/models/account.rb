class Account < ActiveRecord::Base
	has_many :tasks

	SALT = "b6b033a"

	def authenticate(password) 
		self.password == Digest::MD5.hexdigest(password + SALT)	
	end

end
