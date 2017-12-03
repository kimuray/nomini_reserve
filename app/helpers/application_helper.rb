module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: false, hard_wrap: true)
    options = {
      autolink: true,
      space_after_headers: true,
      fenced_code_blocks: true
    }
    markdown = Redcarpet::Markdown.new(renderer, options)
    markdown.render(text).html_safe
  end

  # 市区町村のリスト
  def city_list(city)
    city ||= City.initial_display
    options_for_select(city.same_prefecture_cities.map{|city| [city.name, city.city_code]}, city.city_code)
  end

  # 店舗名の表示制御
  def shop_name_text(shop)
    if current_user.subscription.present?
      shop.name
    end
  end

end
