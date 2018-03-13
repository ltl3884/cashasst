namespace :cashasst do
  desc "获取用户信息"
  task(:account_info => :environment) do
    Account.all.each do |account|
      hb_account = Huobi::Account.new(account.name)
      info = hb_account.accounts_info
      if info["status"] == "ok"
        info["data"].each do |d|
          account.spot_id = d["id"] if d["type"] == "spot"
          account.otc_id = d["id"] if d["type"] == "otc"
          account.point_id = d["id"] if d["type"] == "point"  
        end
      end
      account.save
    end
  end
end