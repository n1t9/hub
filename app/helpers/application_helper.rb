module ApplicationHelper
  # 2024年11月28日 13:22
  def format_datetime(datetime)
    datetime.strftime("%Y\u5E74%m\u6708%d\u65E5 %H:%M")
  end
end
