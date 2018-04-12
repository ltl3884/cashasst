logfile = File.open("#{Rails.root}/log/service.log", 'a')
logfile.sync = true
LOG = JobLogger.new(logfile)