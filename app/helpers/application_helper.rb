module ApplicationHelper

    def fix_url(str)
      str.starts_with?("http://" || "https://") ? str : "http://#{str}"
    end

    def fix_time(time)
      new_time = time.strftime("%m/%d/%Y %l:%M%P %Z")
    end

end
