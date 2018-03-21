# -*- encoding : utf-8 -*-
class WebConf

  # 站台設定檔

  # ---------------------------------------------------------------------
  # Model沒辦法直接使用CountrySettings.domain.send(xxx)來取得想要的變數 
  # EX: Product Model的price method就需要這種方式來拿掉各別國家的錢幣符號
  # 因此寫此類別來解決Model沒辦法直接使用CountrySettings問題, 並統一存取這個介面
  # ---------------------------------------------------------------------

  # WebConf這個類別在控制, 各國的資訊, 統一使用此類別來存取資料
  # 這樣所有 controller, model, api 都吃的到[目前語系, 貨幣, 目前登入授權供應商(facebook, qq, weibo...)]的變數了
  # 可以直接用 WebConf.get_params[:xxx]來取得設定
  # 類別變數, customization中的
  # basic
  # country_code = 國家域名 ex: us
  # upload_dir   = 某s3 bucket下的某個目錄 ex: fet
  # host         = 設定host會需要用到, 如製作sitemap, ex: www.sogi.com
  # search
  # provider     = 要使用的搜尋引擎 ex: google
  # code         = 如果搜尋引擎需要某些代碼, 那就要填 ex: 12345697
  
  @@custom = YAML.load_file("config/customization.yml")

  def self.get_params

    # 取得國家的預設設定
    # .symbolize_keys 是把String轉成symbo的方法, 已節省記憶體空間
    country = Setting::CountrySettings.domain.send(@@custom[:country_code]).symbolize_keys
    
    # 如果在config/customization.yml設定同名的key => value 
    # 即可覆蓋掉CountrySettings的預設設定
    if @@custom.has_key?(:override)
      @@custom[:override].keys.each do |key|
        if @@custom[:override][key.to_sym].present?
          country[key.to_sym] = @@custom[:override][key.to_sym]
        end
      end
    end

    # 回傳參數
    return country
  end

  # 取得設定的host
  def self.host
    @@custom[:host]
  end

  # 取得要上傳到某s3 bucket下的某個目錄
  def self.upload_dir
    @@custom[:upload_dir]
  end

  # 取得搜尋引擎設定
  def self.search_tool
    @@custom[:seach]
  end

  # 取得國家域名
  def self.country_code
    @@custom[:country_code]
  end

  # 取得統計系統URL
  def self.counter_url
    @@custom[:counter_url]
  end

  # 取得 google 管理工具驗證代碼
  def self.google_manage_code
    @@custom[:google_manage_code]
  end

  def self.qq_code
    @@custom[:qq_code]
  end

  def self.is_data_schedule_enabled
    @@custom[:is_data_schedule_enabled]
  end

  def self.is_schedule_enabled?
    @@custom[:is_schedule_enabled]
  end

end
