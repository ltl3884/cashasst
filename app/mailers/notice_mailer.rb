class NoticeMailer < ApplicationMailer

	def send_mail(subject, to, body)
		@body = body
		mail(to: to, subject: subject)
	end

end
